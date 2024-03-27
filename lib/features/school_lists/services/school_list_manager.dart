import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

class SchoolListManager {
  ValueListenable<List<SchoolList>> get schoolLists => _schoolLists;
  ValueListenable<bool> get isRunning => _isRunning;
  ValueListenable<List<PupilList>> get pupilListsInSchoolList =>
      _pupilListsInSchoolList;

  final _pupilListsInSchoolList = ValueNotifier<List<PupilList>>([]);
  final _schoolLists = ValueNotifier<List<SchoolList>>([]);
  final _isRunning = ValueNotifier<bool>(false);
  final client = locator.get<ApiManager>().dioClient.value;
  SchoolListManager() {
    debug.warning('SchoolListManager initialized');
  }
  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  SchoolList getSchoolListById(String listId) {
    return _schoolLists.value.firstWhere((element) => element.listId == listId);
  }

  Future fetchSchoolLists() async {
    try {
      final response = await client.get(EndpointsSchoolList.getSchoolLists);
      final schoolLists =
          (response.data as List).map((e) => SchoolList.fromJson(e)).toList();
      debug.success(
          'SchoolListRepository fetched ${schoolLists.length} schooldays! | ${StackTrace.current}');
      _schoolLists.value = schoolLists;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future patchSchoolList(String listId, String? name, String? description,
      String? visibility) async {
    final schoolListToUpdate = getSchoolListById(listId);
    Map<String, String> jsonMap = {};
    if (name != null) {
      jsonMap["list_name"] = name;
    }
    if (description != null) {
      jsonMap["list_description"] = description;
    }
    if (visibility != null) {
      jsonMap["visibility"] = '${schoolListToUpdate.visibility}*$visibility';
    }
    final String data = jsonEncode(jsonMap);
    final Response response = await client
        .patch(EndpointsSchoolList().patchSchoolList(listId), data: data);
    if (response.statusCode != 200) {
      //handle errors
      debug.error(
          'patchSchoolList error: ${response.statusCode} | ${StackTrace.current}');
    }
    final updatedSchoolList = SchoolList.fromJson(response.data);
    List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
    int index =
        updatedSchoolLists.indexWhere((element) => element.listId == listId);
    updatedSchoolLists[index] = updatedSchoolList;
    _schoolLists.value = updatedSchoolLists;
  }

  Future deleteSchoolList(String listId) async {
    final response =
        await client.delete(EndpointsSchoolList().deleteSchoolList(listId));
    if (response.statusCode == 200) {
      debug.success('list entry successful');
      await fetchSchoolLists();
    }
  }

  SchoolList getSchoolList(String listId) {
    final SchoolList schoolList =
        _schoolLists.value.where((element) => element.listId == listId).first;
    return schoolList;
  }

  List<PupilList> getVisibleSchoolLists(Pupil pupil) {
    final Session session = locator<SessionManager>().credentials.value;
    List<PupilList> visiblePupilLists = pupil.pupilLists!
        .where((pupilList) =>
            getSchoolList(pupilList.originList).visibility == 'public' ||
            getSchoolList(pupilList.originList).createdBy == session.username)
        .toList();
    return visiblePupilLists;
  }

  Future postSchoolListWithGroup(String name, String description,
      List<int> pupilIds, String visibility) async {
    String data = jsonEncode({
      "list_name": name,
      "list_description": description,
      "pupils": pupilIds,
      "visibility": visibility
    });
    final response = await client
        .post(EndpointsSchoolList.postSchoolListWithGroup, data: data);
    if (response.statusCode == 200) {
      final newList = SchoolList.fromJson(response.data);
      List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
      updatedSchoolLists.add(newList);
      _schoolLists.value = updatedSchoolLists;
      await locator<PupilManager>().fetchPupilsById(pupilIds);
      debug.success('list entry successful');
    }
  }

  Future addPupilsToSchoolList(String listId, List<int> pupilIds) async {
    final data = jsonEncode({"pupils": pupilIds});
    final response = await client
        .post(EndpointsSchoolList().addPupilsToSchoolList(listId), data: data);
    if (response.statusCode != 200) {
      // handle errors
      debug.error('addPupilToSchoolList error: ${response.data}');
      return;
    }
    final List<Pupil> responsePupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();
    locator<PupilManager>().updateListOfPupilsInRepository(responsePupils);

    // final SchoolList modifiedSchoolList = SchoolList.fromJson(response.data);
    // List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
    // final index = updatedSchoolLists
    //     .indexWhere((list) => list.listId == modifiedSchoolList.listId);
    // updatedSchoolLists[index] = modifiedSchoolList;
    // _schoolLists.value = updatedSchoolLists;
  }

  Future deletePupilsFromSchoolList(
    List<int> pupilIds,
    String listId,
  ) async {
    final data = jsonEncode({"pupils": pupilIds});
    final response = await client.post(
        EndpointsSchoolList().deletePupilsFromSchoolList(listId),
        data: data);
    if (response.statusCode != 200) {
      // handle errors
      debug.error('removePupilFromSchoolList error: ${response.data}');
      return;
    }
    final List<Pupil> responsePupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();
    locator<PupilManager>().updateListOfPupilsInRepository(responsePupils);
    // final SchoolList modifiedSchoolList = SchoolList.fromJson(response.data);
    // List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
    // final index = updatedSchoolLists
    //     .indexWhere((list) => list.listId == modifiedSchoolList.listId);
    // updatedSchoolLists[index] = modifiedSchoolList;
    // _schoolLists.value = updatedSchoolLists;
  }

  Future patchSchoolListPupil(
      int pupilId, String listId, bool? value, String? comment) async {
    String data;
    if (value != null) {
      data = jsonEncode({
        "pupil_list_status": value,
        "pupil_list_entry_by":
            locator<SessionManager>().credentials.value.username
      });
    } else {
      data = jsonEncode({
        "pupil_list_comment": comment,
        "pupil_list_entry_by":
            locator<SessionManager>().credentials.value.username
      });
    }
    //   jsonEncode({"pupil_list_comment": comment, "pupil_list_status": value});
    final response = await client.patch(
        EndpointsSchoolList().patchPupilSchoolList(pupilId, listId),
        data: data);
    if (response.statusCode == 200) {
      await locator<PupilManager>().patchPupilFromResponse(response.data);
      debug.success('list entry successful');
    }
  }

  // Future deletePupilsFromSchoolList(
  //     List<int> pupilIds, String listId, String comment) async {
  //   final client = locator.get<ApiManager>().dioClient.value;
  //   final String data = jsonEncode({"pupils": pupilIds});
  //   final response = await client
  //       .post(EndpointsSchoolList().deletePupilsFromSchoolList(listId), data: data);
  //   if (response.statusCode != 200) {
  //     //handle errors
  //     debug.error('deletePupilsFromSchoolList error: ${response.data}');
  //   }
  //   final List<Pupil> pupils =
  //       (response.data as List).map((e) => Pupil.fromJson(e)).toList();

  //   locator<PupilManager>().patchListOfPupils(pupils);
  // }

  PupilList getPupilSchoolListEntry(int pupilId, String listId) {
    final Pupil pupil = locator<PupilManager>()
        .pupils
        .value
        .where((element) => element.internalId == pupilId)
        .first;

    final PupilList pupilSchoolListEntry = pupil.pupilLists!
        .where((element) => element.originList == listId)
        .first;
    return pupilSchoolListEntry;
  }

  List<Pupil> getPupilsinSchoolList(String listId) {
    final List<Pupil> pupils = locator<PupilManager>().pupils.value;
    final List<Pupil> listedPupils = pupils
        .where((pupil) => pupil.pupilLists!
            .any((pupilList) => pupilList.originList == listId))
        .toList();
    return listedPupils;
  }

  List<Pupil> pupilsInSchoolList(String listId, List<Pupil> pupils) {
    List<Pupil> pupilsInList = getPupilsinSchoolList(listId);
    return pupils
        .where((pupil) => pupilsInList
            .any((element) => element.internalId == pupil.internalId))
        .toList();
  }
}
