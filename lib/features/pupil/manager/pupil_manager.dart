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
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter_impl.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilManager extends ChangeNotifier {
  final _pupils = <int, PupilProxy>{};

  List<PupilProxy> get allPupils => _pupils.values.toList();

  PupilManager();

  //- HELPER METHODS

  void clearData() {
    _pupils.clear();
  }

  PupilProxy findPupilById(int id) {
    return _pupils[id]!;
  }

  List<PupilProxy> pupilsFromPupilIds(List<int> pupilIds) {
    List<PupilProxy> pupilsfromPupilIds = [];

    for (int pupilId in pupilIds) {
      pupilsfromPupilIds.add(_pupils[pupilId]!);
    }

    return pupilsfromPupilIds;
  }

  List<int> pupilIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.internalId).toList();
  }

  List<PupilProxy> restOfPupils(List<int> pupilIds) {
    Map<int, PupilProxy> allPupils = Map<int, PupilProxy>.of(_pupils);
    allPupils.removeWhere((key, value) => pupilIds.contains(key));
    return allPupils.values.toList();
  }

  List<PupilProxy> siblings(PupilProxy pupil) {
    if (pupil.family == null) {
      return [];
    }

    Map<int, PupilProxy> allPupils = Map<int, PupilProxy>.of(_pupils);

    allPupils.removeWhere((key, value) => value.family != pupil.family);

    allPupils.remove(pupil.internalId);
    final pupilSiblings = allPupils.values.toList();
    return pupilSiblings;
  }

  List<PupilProxy> pupilsWithBirthdaySinceDate(DateTime date) {
    Map<int, PupilProxy> allPupils = Map<int, PupilProxy>.of(_pupils);
    final DateTime now = DateTime.now();
    allPupils.removeWhere((key, pupil) {
      final birthdayThisYear =
          DateTime(now.year, pupil.birthday.month, pupil.birthday.day);
      // Ensure the birthday this year is not before the specified date and not after today.
      return !(birthdayThisYear.isAtSameMomentAs(date) ||
          (birthdayThisYear.isAfter(date) && birthdayThisYear.isBefore(now)));
    });
    final pupilsWithBirthdaySinceDate = allPupils.values.toList();
    pupilsWithBirthdaySinceDate.sort((b, a) {
      final birthdayA =
          DateTime(DateTime.now().year, a.birthday.month, a.birthday.day);
      final birthdayB =
          DateTime(DateTime.now().year, b.birthday.month, b.birthday.day);
      return birthdayA.compareTo(birthdayB);
    });
    return pupilsWithBirthdaySinceDate;
  }

  //- API CONSUMER METHODS

  final apiPupilService = ApiPupilService();

  //- Fetch all available pupils from the backend

  Future<void> fetchAllPupils() async {
    final pupilsToFetch = locator.get<PupilIdentityManager>().availablePupilIds;
    if (pupilsToFetch.isEmpty) {
      return;
    }
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> init() async {
    await fetchAllPupils();
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.internalId).toList());
  }

  //- Fetch pupils with the given ids from the backend

  Future<void> fetchPupilsByInternalId(List<int> internalPupilIds) async {
    locator<NotificationManager>().isRunningValue(true);

    // fetch the pupils from the backend
    final fetchedPupils = await apiPupilService.fetchListOfPupils(
        internalPupilIds: internalPupilIds);

    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilIdentitiesIds = internalPupilIds
        .where((element) =>
            !fetchedPupils.any((pupil) => pupil.internalId == element))
        .toList();

    // now we match the pupils from the response with their personal data
    final pupilIdentityManager = locator.get<PupilIdentityManager>();
    for (PupilData fetchedPupil in fetchedPupils) {
      final proxyInRepository = _pupils[fetchedPupil.internalId];
      if (proxyInRepository != null) {
        proxyInRepository.updatePupil(fetchedPupil);
      } else {
        // if the pupil is not in the repository, that would be weird
        // since we did not send the id to the backend

        final pupilIdentity =
            pupilIdentityManager.getPupilIdentity(fetchedPupil.internalId);

        _pupils[fetchedPupil.internalId] =
            PupilProxy(pupilData: fetchedPupil, pupilIdentity: pupilIdentity);
      }
    }

    // remove the outdated pupil identities that
    // did not get a response from the backend
    // because this means they are outdated
    // and we do not need them anymore

    if (outdatedPupilIdentitiesIds.isNotEmpty) {
      final deletedPupilIdentities = await pupilIdentityManager
          .deletePupilIdentities(outdatedPupilIdentitiesIds);
      locator<NotificationManager>().showSnackBar(NotificationType.warning,
          '$deletedPupilIdentities sind nicht mehr in der Datenbank und wurden gelöscht.');
    }

    locator<NotificationManager>().isRunningValue(false);

    notifyListeners();
  }

  void updatePupilProxyWithPupilData(PupilData pupilData) {
    final proxy = _pupils[pupilData.internalId];
    if (proxy != null) {
      proxy.updatePupil(pupilData);
      // No need to call notifyListeners here, because the proxy will notify the listeners itself
      // notifyListeners();
    }
  }

  void updatePupilProxiesWithPupilData(List<PupilData> pupils) {
    for (PupilData pupil in pupils) {
      updatePupilProxyWithPupilData(pupil);
    }
  }

  void updatePupilsFromMissedClassesOnASchoolday(
      List<MissedClass> allMissedClasses) {
    if (allMissedClasses.isEmpty) {
      return;
    }
    for (MissedClass missedClass in allMissedClasses) {
      final missedPupil = _pupils[missedClass.missedPupilId];

      if (missedPupil == null) {
        logger.f('Pupil ${missedClass.missedPupilId} not found',
            stackTrace: StackTrace.current);
        continue;
      }

      missedPupil.updateFromMissedClassesOnASchoolday(allMissedClasses);
    }
    // no need to notify listeners here, because the pupils will notify the listeners themselves
    //notifyListeners();
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

    final PupilData pupilUpdate = await apiPupilService.updatePupilWithAvatar(
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
    await apiPupilService.deletePupilAvatar(
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

        final List<PupilData> siblingsUpdate =
            await apiPupilService.updateSiblingsProperty(
                siblingsPupilIds: pupilIdsWithSameFamily,
                property: jsonKey,
                value: value);

        // now update the siblings with the new data

        for (PupilData sibling in siblingsUpdate) {
          _pupils[sibling.internalId]!.updatePupil(sibling);
        }

        locator<NotificationManager>().showSnackBar(
            NotificationType.success, 'Geschwister erfolgreich gepatcht!');
        locator<NotificationManager>().isRunningValue(false);
      }
    }

    // The pupil is no sibling. Make the api call for the single pupil

    final PupilData pupilUpdate = await apiPupilService.updatePupilProperty(
        id: pupilId, property: jsonKey, value: value);

    // now update the pupil in the repository

    _pupils[pupilId]!.updatePupil(pupilUpdate);

    locator<NotificationManager>().isRunningValue(false);
  }

  PupilsFilter getPupilFilter() {
    //return PupilsFilterImplementation(this, sortMode: sortMode);
    return PupilsFilterImplementation(this);
  }
}
