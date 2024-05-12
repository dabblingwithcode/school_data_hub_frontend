import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_personal_data_manager.dart';

class PupilManager {
  ValueListenable<bool> get isRunning => _isRunning;

  final _pupils = <int, PupilProxy>{};

  final _isRunning = ValueNotifier<bool>(false);
  final client = locator.get<ApiManager>().dioClient.value;
  PupilManager();
  Future init() async {
    await fetchAllPupils();
    return;
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

  //-Fetch pupils with the given ids from the backend
  Future fetchPupilsByInternalId(List<int> internalPupilIds) async {
    locator<SnackBarManager>().isRunningValue(true);
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
      locator<SnackBarManager>().showSnackBar(SnackBarType.warning,
          '$deletedPupils had no match and have been deleted from the pupilbase!');
    }

    sortPupilsByName();

    locator<SnackBarManager>().isRunningValue(false);
  }

  List<PupilProxy> readPupils() {
    List<PupilProxy> readPupils = _pupils.value;
    return readPupils;
  }

  deletePupils() {
    _pupils.value = [];
    return;
  }

  //- update pupil in repository
  // updatePupilInRepository(PupilProxy pupil) {
  //   List<PupilProxy> pupils = List.from(_pupils.value);
  //   int index =
  //       pupils.indexWhere((element) => element.internalId == pupil.internalId);
  //   pupils[index] = pupilCopiedWith(pupils[index], pupil);
  //   _pupils.value = pupils;
  //   locator<PupilFilterManager>().cloneToFilteredPupil(pupil);
  // }

  //- update list of pupils in repository
  // void updatePupilsRepository(List<PupilProxy> pupils)  {
  //   List<PupilProxy> repositoryPupils = List.from(_pupils.value);
  //   for (Pupil pupil in pupils) {
  //     int match = repositoryPupils
  //         .indexWhere((element) => element.internalId == pupil.internalId);
  //     if (match != -1) {
  //       repositoryPupils[match] =
  //           pupilCopiedWith(repositoryPupils[match], pupil);
  //     } else {
  //       repositoryPupils.add(pupil);
  //     }
  //   }

  //   sortPupilsByName(repositoryPupils);

  //   locator<PupilFilterManager>().rebuildFilteredPupils();

  //   locator<SnackBarManager>().isRunningValue(false);
  // }

  sortPupilsByName() {
    _pupils.value.sort((a, b) => a.firstName.compareTo(b.firstName));
  }

  patchPupilsWithMissedClasses(List<MissedClass> missedClasses) {
    final List<PupilProxy> pupils = List.from(_pupils.value);
    final DateTime schoolday = missedClasses[0].missedDay;
    for (MissedClass missedClass in missedClasses) {
      int missedPupil = pupils.indexWhere(
          (element) => element.internalId == missedClass.missedPupilId);
      if (missedPupil == -1) {
        debug.error('${missedClass.missedPupilId} not found');
        continue;
      }
      int missedClassIndex = pupils[missedPupil]
          .pupilMissedClasses!
          .indexWhere((element) => element.missedDay == missedClass.missedDay);
      //debugger();
      if (missedClassIndex == -1) {
        pupils[missedPupil] = pupils[missedPupil].copyWith(
          pupilMissedClasses: [
            ...pupils[missedPupil].pupilMissedClasses!,
            missedClass,
          ],
        );
      } else {
        List<MissedClass> updatedMissedClasses =
            List.from(pupils[missedPupil].pupilMissedClasses!);
        updatedMissedClasses[missedClassIndex] = missedClass;
        pupils[missedPupil] = pupils[missedPupil].copyWith(
          pupilMissedClasses: updatedMissedClasses,
        );
      }
    }
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        int missedClassIndex = pupil.pupilMissedClasses!
            .indexWhere((element) => element.missedDay == schoolday);
        if (missedClassIndex != -1 &&
            !missedClasses.any((element) =>
                element.missedDay == schoolday &&
                element.missedPupilId == pupil.internalId)) {
          List<MissedClass> updatedMissedClasses =
              List.from(pupil.pupilMissedClasses!);
          updatedMissedClasses.removeAt(missedClassIndex);
          pupils[pupils.indexOf(pupil)] = pupils[pupils.indexOf(pupil)]
              .copyWith(pupilMissedClasses: updatedMissedClasses);
        }
      }
    }
    _pupils.value = pupils;
    locator<PupilFilterManager>().filterPupils();
  }

  Future fetchShownPupils() async {
    if (locator.isReadySync<PupilFilterManager>()) {
      final List<PupilProxy> shownPupils =
          locator<PupilFilterManager>().filteredPupils.value;
      final List<int> shownPupilIds = pupilIdsFromPupils(shownPupils);
      await fetchPupilsByInternalId(shownPupilIds);
    }
  }

  void patchPupilFromResponse(Map<String, dynamic> pupilResponse) {
    // the response comes as a json - let's make a pupil
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);
    // TODO possibly change internally to map
    _pupils.value
        .firstWhere((element) => element.internalId == responsePupil.internalId)
        .updatePupil(responsePupil);

    // final personalData = locator<PupilPersonalDataManager>()
    //     .getPersonalData(responsePupil.internalId);
    // // now let's patch
    // PupilProxy namedPupil =
    //     patchPupilWithPupilbaseData(pupilbase, responsePupil);
    // // we create a list to manipulate it
    // List<PupilProxy> pupils = List.from(_pupils.value);
    // // let's find the pupil by index from the response
    // int index = pupils.indexWhere(
    //     (element) => element.internalId == responsePupil.internalId);
    // pupils[index] = namedPupil;

    // // write the new value in the manager
    // _pupils.value = pupils;
    // // Because we use the filtered pupils in the presentation layer,
    // // we need to update the filtered list too, ideally without
    // // altering the filter state
    // locator<PupilFilterManager>().cloneToFilteredPupil(namedPupil);
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

    // TODO: what is this for?
    final fileInfo = await cacheManager.getFileFromCache(cacheKey.toString());
    if (fileInfo != null && await fileInfo.file.exists()) {
      await fileInfo.file.delete();
      // File is already cached, use it directly
      //cacheManager.emptyCache();
    }
    patchPupilFromResponse(pupilResponse);
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
    findPupilById(pupilId).clearAvtar();
  }

  Future<void> patchPupil(int pupilId, String jsonKey, var value) async {
    locator<SnackBarManager>().isRunningValue(true);
    //- if the value is relevant to siblings, check for siblings first and handle it if true

    if (jsonKey == 'communication_tutor1' ||
        jsonKey == 'communication_tutor2' ||
        jsonKey == 'parents_contact') {
      final PupilProxy pupil = findPupilById(pupilId);
      if (pupil.family != null) {
        // create list with ids of all pupils with the same family value
        final List<int> pupilIdsWithSameFamily = _pupils.value
            .where((p) => p.family == pupil.family)
            .map((p) => p.internalId)
            .toList();

        final siblingsPatchData =
            jsonEncode({jsonKey: value, 'pupils': pupilIdsWithSameFamily});
        final Response siblingsResponse = await client
            .patch(EndpointsPupil.patchSiblings, data: siblingsPatchData);
        if (siblingsResponse.statusCode != 200) {
          locator<SnackBarManager>().showSnackBar(
              SnackBarType.warning, 'Fehler beim Patchen der Geschwister!');
          locator<SnackBarManager>().isRunningValue(false);
          return;
        }
        // let's update the siblings
        final List<PupilProxy> responsePupils = (siblingsResponse.data as List)
            .map((e) => PupilProxy.fromJson(e))
            .toList();
        updatePupilsRepository(responsePupils);
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.success, 'Geschwister erfolgreich gepatcht!');
        locator<SnackBarManager>().isRunningValue(false);
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
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.warning, 'Fehler beim Patchen des Schülers!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    // let's patch the pupil with the response
    patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Schüler erfolgreich gepatcht!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }
}
