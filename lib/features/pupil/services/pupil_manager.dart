import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data_schild.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';

class PupilManager {
  ValueListenable<List<PupilProxy>> get pupils => _pupils;

  ValueListenable<bool> get isRunning => _isRunning;
  final _pupils = ValueNotifier<List<PupilProxy>>([]);

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
        locator.get<PupilBaseManager>().availablePupilIds.value;
    if (pupilsToFetch.isEmpty) {
      return;
    }
    debug.warning('availablePupils im PupilManager $pupilsToFetch');
    await fetchPupilsById(pupilsToFetch);
  }

  //- Fetch listed pupils from the backend
  Future fetchThesePupils(List<PupilProxy> pupils) async {
    List<int> pupilIds = [];
    for (PupilProxy pupil in pupils) {
      pupilIds.add(pupil.internalId);
      await fetchPupilsById(pupilIds);
    }
  }

  //-Fetch pupils with the given ids from the backend
  Future fetchPupilsById(List<int> pupilIds) async {
    locator<SnackBarManager>().isRunningValue(true);
    // we request the data posting a json with the id list - let's build that
    final data = jsonEncode({"pupils": pupilIds});
    // we'll need the pupilbase to parse the response - let's prepare it
    final pupilbase = locator.get<PupilBaseManager>().pupilbase.value;
    // and a list to manipulate the matched pupils
    // and outdated pupilbase that did not get a response later
    List<PupilProxy> matchedPupils = [];
    List<PupilDataFromSchild> outdatedPupilbase = [];
    // request
    try {
      final response = await client.post(EndpointsPupil.getPupils, data: data);
      debug.info('PupilProxy request sent!');
      // we have the response - let's build unidentified Pupils with it
      final fetchedPupilsWithoutBase =
          (response.data as List).map((e) => PupilProxy.fromJson(e)).toList();

      // now we match them with the pupilbase and add the id key values
      for (PupilDataFromSchild pupilBaseElement in pupilbase) {
        if (fetchedPupilsWithoutBase
            .where((element) => element.internalId == pupilBaseElement.id)
            .isNotEmpty) {
          PupilProxy pupilMatch = fetchedPupilsWithoutBase
              .where((element) => element.internalId == pupilBaseElement.id)
              .single;
          PupilProxy namedPupil =
              patchPupilWithPupilbaseData(pupilBaseElement, pupilMatch);
          matchedPupils.add(namedPupil);
        } else {
          // if the pupilbase element was sent and didn't get a response from the server,
          // this means it is outdated -
          // let's remove those
          if (pupilIds.contains(pupilBaseElement.id)) {
            outdatedPupilbase.add(pupilBaseElement);
          }
        }
      }
      // now check if the pupilbase was modified - if so, store the modified base
      if (outdatedPupilbase.isNotEmpty) {
        locator<PupilBaseManager>().deletePupilBaseElements(outdatedPupilbase);
        // debug print the internal_id of every element of the outdated pupilbase in one string
        String deletedPupils = '';
        for (PupilDataFromSchild element in outdatedPupilbase) {
          deletedPupils += '${element.id}, ';
        }
        locator<SnackBarManager>().showSnackBar(SnackBarType.warning,
            '$deletedPupils had no match and have been deleted from the pupilbase!');
      }

      updateListOfPupilsInRepository(matchedPupils);

      // let's update the filtered pupils too
      // handle errors...
      if (matchedPupils.isEmpty) {
        debug.info('PUPILS FETCHED: No matches! | ${StackTrace.current}');
      } else {
        locator<SnackBarManager>().showSnackBar(SnackBarType.success,
            'PUPILS FETCHED: There are ${matchedPupils.length} matches! | ${StackTrace.current}');
      }
      if (locator.isReadySync<PupilFilterManager>()) {
        //locator<PupilFilterManager>().refreshFilteredPupils();
        locator<PupilFilterManager>().rebuildFilteredPupils();
      }

      locator<SnackBarManager>().isRunningValue(false);

      // //! This one gives an error
      // final pupilFilterManager = locator<PupilFilterManager>();
      // pupilFilterManager.refreshFilteredPupils();
    } on DioException catch (e) {
      // handle errors...
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
      rethrow;
    }
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
  updatePupilInRepository(PupilProxy pupil) {
    List<PupilProxy> pupils = List.from(_pupils.value);
    int index =
        pupils.indexWhere((element) => element.internalId == pupil.internalId);
    pupils[index] = pupilCopiedWith(pupils[index], pupil);
    _pupils.value = pupils;
    locator<PupilFilterManager>().cloneToFilteredPupil(pupil);
  }

  //- update list of pupils in repository
  Future updateListOfPupilsInRepository(List<PupilProxy> pupils) async {
    locator<SnackBarManager>().isRunningValue(true);
    List<PupilProxy> repositoryPupils = List.from(_pupils.value);
    for (PupilProxy pupil in pupils) {
      int match = repositoryPupils
          .indexWhere((element) => element.internalId == pupil.internalId);
      if (match != -1) {
        repositoryPupils[match] =
            pupilCopiedWith(repositoryPupils[match], pupil);
      } else {
        repositoryPupils.add(pupil);
      }
    }

    sortPupilsByName(repositoryPupils);

    await locator.isReady<PupilFilterManager>();

    locator<PupilFilterManager>().rebuildFilteredPupils();

    locator<SnackBarManager>().isRunningValue(false);
  }

  sortPupilsByName(List<PupilProxy> pupils) {
    pupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    _pupils.value = pupils;
    return;
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
      await fetchPupilsById(shownPupilIds);
    }
  }

  patchPupilFromResponse(Map<String, dynamic> pupilResponse) {
    // the response comes as a json - let's make a pupil
    final PupilProxy responsePupil = PupilProxy.fromJson(pupilResponse);
    // we need to patch the values from the pupilbase - let's find a match
    final List<PupilDataFromSchild> pupilBaseList =
        locator<PupilBaseManager>().pupilbase.value;
    final PupilDataFromSchild pupilbase = pupilBaseList
        .where((element) => element.id == responsePupil.internalId)
        .first;
    // now let's patch
    PupilProxy namedPupil =
        patchPupilWithPupilbaseData(pupilbase, responsePupil);
    // we create a list to manipulate it
    List<PupilProxy> pupils = List.from(_pupils.value);
    // let's find the pupil by index from the response
    int index = pupils.indexWhere(
        (element) => element.internalId == responsePupil.internalId);
    pupils[index] = namedPupil;

    // write the new value in the manager
    _pupils.value = pupils;
    // Because we use the filtered pupils in the presentation layer,
    // we need to update the filtered list too, ideally without
    // altering the filter state
    locator<PupilFilterManager>().cloneToFilteredPupil(namedPupil);
  }

  postAvatarImage(
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

    final fileInfo = await cacheManager.getFileFromCache(cacheKey.toString());
    if (fileInfo != null && await fileInfo.file.exists()) {
      await fileInfo.file.delete();
      // File is already cached, use it directly
      //cacheManager.emptyCache();
    }
    await patchPupilFromResponse(pupilResponse);
  }

  deleteAvatarImage(int pupilId, String cacheKey) async {
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
    final PupilProxy pupil = (findPupilById(pupilId)).copyWith(avatarUrl: null);
    updatePupilInRepository(pupil);
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
        locator<PupilManager>().updateListOfPupilsInRepository(responsePupils);
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
    await patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Schüler erfolgreich gepatcht!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }
}
