import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_personal_data_manager.dart';

class PupilManager {
  final _pupils = <int, PupilProxy>{};

  final client = locator.get<ApiManager>().dioClient.value;

  PupilManager();

  Future init() async {
    await fetchAllPupils();
  }

  //- Fetch all available pupils from the backend
  Future fetchAllPupils() async {
    final pupilsToFetch =
        locator.get<PupilPersonalDataManager>().availablePupilIds;
    if (pupilsToFetch.isEmpty) {
      return;
    }
    debug.warning('availablePupils im PupilManager $pupilsToFetch');
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.internalId).toList());
  }

  //- Fetch pupils with the given ids from the backend
  Future fetchPupilsByInternalId(List<int> internalPupilIds) async {
    locator<NotificationManager>().isRunningValue(true);
    // we request the data posting a json with the id list - let's build that
    final pupilIdList = jsonEncode({"pupils": internalPupilIds});
    // and a list to manipulate the matched pupils
    List<int> outdatedPupilPersonalDataIds = [];
    // request
    final response =
        await client.post(EndpointsPupil.getPupils, data: pupilIdList);
    debug.info('PupilProxy request sent!');
    // we have the response - let's build unidentified Pupils with it
    final fetchedPupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();

    outdatedPupilPersonalDataIds = internalPupilIds
        .where((element) =>
            !fetchedPupils.any((pupil) => pupil.internalId == element))
        .toList();

    // now we match them with their personal data
    final personalDataManager = locator.get<PupilPersonalDataManager>();
    for (Pupil fetchedPupil in fetchedPupils) {
      final proxyInRepository = _pupils[fetchedPupil.internalId];

      if (proxyInRepository != null) {
        proxyInRepository.updatePupil(fetchedPupil);
      } else {
        final personalData =
            personalDataManager.getPersonalData(fetchedPupil.internalId);

        _pupils[fetchedPupil.internalId] =
            PupilProxy(pupil: fetchedPupil, personalData: personalData);
      }
    }
    // remove the outdated pupilbase elements
    if (outdatedPupilPersonalDataIds.isNotEmpty) {
      final deletedPupils = await personalDataManager
          .deletePupilBaseElements(outdatedPupilPersonalDataIds);
      locator<NotificationManager>().showSnackBar(NotificationType.warning,
          '$deletedPupils had no match and have been deleted from the pupilbase!');
    }

    locator<NotificationManager>().isRunningValue(false);
  }

  void clearData() {
    _pupils.clear();
  }

  void updatePupilsFromMissedClasses(List<MissedClass> allMissedClasses) {
    for (MissedClass missedClass in allMissedClasses) {
      final missedPupil = _pupils[missedClass.missedPupilId];

      if (missedPupil == null) {
        debug.error('${missedClass.missedPupilId} not found');
        continue;
      }

      missedPupil.updateFromAllMissedClasses(allMissedClasses);
    }
  }

  Future fetchShownPupils() async {
    /// todo
    // // final List<PupilProxy> shownPupils =
    // //     locator<PupilFilterManager>().filteredPupils.value;
    // // final List<int> shownPupilIds = pupilIdsFromPupils(shownPupils);
    // await fetchPupilsByInternalId(shownPupilIds);
  }

  void updatePupilFromResponse(Map<String, dynamic> pupilResponse) {
    // the response comes as a json - let's make a pupil
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);
    _pupils[responsePupil.internalId]!.updatePupil(responsePupil);
  }

  Future<void> postAvatarImage(
    File imageFile,
    PupilProxy pupil,
  ) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);
    // send request
    String fileName = encryptedFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });
    // send request
    final Response response = await client.patch(
      EndpointsPupil().patchPupilhWithAvatar(pupil.internalId),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }

    // Success! We have a pupil response - let's patch the pupil with the data

    final Map<String, dynamic> pupilResponse = response.data;
    final cacheManager = DefaultCacheManager();
    final cacheKey = pupil.internalId;

    cacheManager.removeFile(cacheKey.toString());

    updatePupilFromResponse(pupilResponse);
  }

  Future<void> deleteAvatarImage(int pupilId, String cacheKey) async {
    // send request
    final Response response = await client.delete(
      EndpointsPupil().deletePupilAvatar(pupilId),
      options: Options(headers: {
        'x-access-token': locator<SessionManager>().credentials.value.jwt
      }),
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong deleting the avatar');
      return;
    }
    // Delete the cached image
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // and update the repository
    _pupils[pupilId]!.clearAvtar();
  }

  Future<void> patchPupil(int pupilId, String jsonKey, var value) async {
    locator<NotificationManager>().isRunningValue(true);
    //- if the value is relevant to siblings, check for siblings first and handle it if true

    if (jsonKey == 'communication_tutor1' ||
        jsonKey == 'communication_tutor2' ||
        jsonKey == 'parents_contact') {
      final PupilProxy pupil = findPupilById(pupilId);
      if (pupil.family != null) {
        // create list with ids of all pupils with the same family value
        final List<int> pupilIdsWithSameFamily = _pupils.values
            .where((p) => p.family == pupil.family)
            .map((p) => p.internalId)
            .toList();

        final siblingsPatchData = jsonEncode({
          jsonKey: value,
          'pupils': pupilIdsWithSameFamily,
        });
        final Response siblingsResponse = await client
            .patch(EndpointsPupil.patchSiblings, data: siblingsPatchData);
        if (siblingsResponse.statusCode != 200) {
          locator<NotificationManager>().showSnackBar(
              NotificationType.warning, 'Fehler beim Patchen der Geschwister!');
          locator<NotificationManager>().isRunningValue(false);
          return;
        }
        // let's update the siblings
        final List<Pupil> siblingPupils = (siblingsResponse.data as List)
            .map((e) => Pupil.fromJson(e))
            .toList();
        for (Pupil sibling in siblingPupils) {
          _pupils[sibling.internalId]!.updatePupil(sibling);
        }

        locator<NotificationManager>().showSnackBar(
            NotificationType.success, 'Geschwister erfolgreich gepatcht!');
        locator<NotificationManager>().isRunningValue(false);
      }
    }
    // prepare the data for the request
    final data = jsonEncode({jsonKey: value});
    final Response response =
        await client.patch(EndpointsPupil().patchPupil(pupilId), data: data);
    // we have a response
    final Map<String, dynamic> pupilResponse = response.data;
    // handle errors
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Patchen des Schülers!');
      locator<NotificationManager>().isRunningValue(false);
      return;
    }
    // let's patch the pupil with the response
    updatePupilFromResponse(pupilResponse);
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Schüler erfolgreich gepatcht!');
    locator<NotificationManager>().isRunningValue(false);
  }
}
