import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter_impl.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_personal_data_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilManager extends ChangeNotifier {
  final _pupils = <int, PupilProxy>{};

  List<PupilProxy> get allPupils => _pupils.values.toList();

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
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.internalId).toList());
  }

  //- Fetch pupils with the given ids from the backend
  Future fetchPupilsByInternalId(List<int> internalPupilIds) async {
    locator<NotificationManager>().isRunningValue(true);

    // fetch the pupils from the backend
    final fetchedPupils = await ApiPupilService()
        .fetchListOfPupils(internalPupilIds: internalPupilIds);

    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilPersonalDataIds = internalPupilIds
        .where((element) =>
            !fetchedPupils.any((pupil) => pupil.internalId == element))
        .toList();

    // now we match the pupils from the response with their personal data
    final personalDataManager = locator.get<PupilPersonalDataManager>();
    for (Pupil fetchedPupil in fetchedPupils) {
      final proxyInRepository = _pupils[fetchedPupil.internalId];
      if (proxyInRepository != null) {
        proxyInRepository.updatePupil(fetchedPupil);
      } else {
        // if the pupil is not in the repository, that would be weird
        // since we did not send the id to the backend

        final personalData =
            personalDataManager.getPersonalData(fetchedPupil.internalId);

        _pupils[fetchedPupil.internalId] =
            PupilProxy(pupil: fetchedPupil, personalData: personalData);
      }
    }

    // remove the outdated pupilbase elements that
    // did not get a response from the backend

    if (outdatedPupilPersonalDataIds.isNotEmpty) {
      final deletedPupils = await personalDataManager
          .deletePupilBaseElements(outdatedPupilPersonalDataIds);
      locator<NotificationManager>().showSnackBar(NotificationType.warning,
          '$deletedPupils had no match and have been deleted from the pupilbase!');
    }

    locator<NotificationManager>().isRunningValue(false);

    notifyListeners();
  }

  void clearData() {
    _pupils.clear();
  }

  void updatePupilProxyWithPupil(Pupil pupil) {
    final proxy = _pupils[pupil.internalId];
    if (proxy != null) {
      proxy.updatePupil(pupil);
    }
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
    notifyListeners();
  }

  Future<void> postAvatarImage(
    File imageFile,
    PupilProxy pupilProxy,
  ) async {
    // first we encrypt the file

    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    // Now we prepare the form data for the request.

    String fileName = encryptedFile.path.split('/').last;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });

    // send the Api request

    final Pupil pupilUpdate = await ApiPupilService().updatePupilWithAvatar(
      id: pupilProxy.internalId,
      formData: formData,
    );

    // update the pupil in the repository

    pupilProxy.updatePupil(pupilUpdate);

    // Delete the outdated encrypted file.

    final cacheManager = DefaultCacheManager();
    final cacheKey = pupilProxy.internalId;

    cacheManager.removeFile(cacheKey.toString());
  }

  Future<void> deleteAvatarImage(int pupilId, String cacheKey) async {
    // send the Api request
    await ApiPupilService().deletePupilAvatar(
      internalId: pupilId,
    );

    // Delete the outdated encrypted file in the cache.

    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);

    // and update the repository
    _pupils[pupilId]!.clearAvatar();
  }

  Future<void> patchPupil(int pupilId, String jsonKey, var value) async {
    locator<NotificationManager>().isRunningValue(true);

    // if the value is relevant to siblings, check for siblings first and handle them if true

    if (jsonKey == 'communication_tutor1' ||
        jsonKey == 'communication_tutor2' ||
        jsonKey == 'parents_contact') {
      final PupilProxy pupil = findPupilById(pupilId);
      if (pupil.family != null) {
        // we have a sibling
        // create list with ids of all pupils with the same family value

        final List<int> pupilIdsWithSameFamily = _pupils.values
            .where((p) => p.family == pupil.family)
            .map((p) => p.internalId)
            .toList();

        // call the endpoint to update the siblings

        final List<Pupil> siblingsUpdate = await ApiPupilService()
            .updateSiblingsProperty(
                siblingsPupilIds: pupilIdsWithSameFamily,
                property: jsonKey,
                value: value);

        // now update the siblings with the new data

        for (Pupil sibling in siblingsUpdate) {
          _pupils[sibling.internalId]!.updatePupil(sibling);
        }

        locator<NotificationManager>().showSnackBar(
            NotificationType.success, 'Geschwister erfolgreich gepatcht!');
        locator<NotificationManager>().isRunningValue(false);
      }
    }

    // The pupil is no sibling. Make the api call for the single pupil

    final Pupil pupilUpdate = await ApiPupilService()
        .updatePupilProperty(id: pupilId, property: jsonKey, value: value);

    // now update the pupil in the repository

    _pupils[pupilId]!.updatePupil(pupilUpdate);

    locator<NotificationManager>().isRunningValue(false);
  }

  PupilsFilter getPupilFilter({
    Map<PupilFilter, bool>? filterState,
    Map<PupilSortMode, bool>? sortMode,
  }) {
    return PupilsFilterImplementation(this,
        filterState: filterState, sortMode: sortMode);
  }
}
