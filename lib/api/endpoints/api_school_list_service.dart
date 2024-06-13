import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';

class ApiSchoolListService {
  final _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- get school lists

  static const _getSchoolListsUrl = '/school_lists/all';

  Future<List<SchoolList>> fetchSchoolLists() async {
    notificationManager.isRunningValue(true);

    final response = await _client.get(_getSchoolListsUrl);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Schullisten');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to fetch school lists', response.statusCode);
    }

    final List<SchoolList> schoolLists =
        (response.data as List).map((e) => SchoolList.fromJson(e)).toList();

    notificationManager.isRunningValue(false);

    return schoolLists;
  }

  //- post school list

  static const _postSchoolListWithGroupUrl = '/school_lists/new';

  Future<SchoolList> postSchoolListWithGroup(
      {required String name,
      required String description,
      required List<int> pupilIds,
      required String visibility}) async {
    notificationManager.isRunningValue(true);

    final String data = jsonEncode({
      "list_name": name,
      "list_description": description,
      "pupils": pupilIds,
      "visibility": visibility
    });

    final response =
        await _client.post(_postSchoolListWithGroupUrl, data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen der Schulliste');

      throw ApiException('Failed to create school list', response.statusCode);
    }

    final newList = SchoolList.fromJson(response.data);

    return newList;
  }

  static const postSchoolList = '/school_lists/all';

  //- patch school list

  String _patchSchoolListUrl(String listId) {
    return '/school_lists/$listId/patch';
  }

  Future<SchoolList> updateSchoolListProperty(
      {required SchoolList schoolListToUpdate,
      String? name,
      String? description,
      String? visibility}) async {
    assert(name != null || description != null || visibility != null);
    notificationManager.isRunningValue(true);
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

    final Response response = await _client
        .patch(_patchSchoolListUrl(schoolListToUpdate.listId), data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren der Schulliste');
      throw ApiException('Failed to update school list', response.statusCode);
    }
    return SchoolList.fromJson(response.data);
  }

  //- delete school list

  String _deleteSchoolListUrl(String listId) {
    return '/school_lists/$listId';
  }

  Future<List<SchoolList>> deleteSchoolList(String listId) async {
    notificationManager.isRunningValue(true);

    final Response response =
        await _client.delete(_deleteSchoolListUrl(listId));
    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen der Schulliste');

      throw ApiException('Failed to delete school list', response.statusCode);
    }
    final List<SchoolList> schoolLists =
        (response.data as List).map((e) => SchoolList.fromJson(e)).toList();

    return schoolLists;
  }

  //- PUPIL LISTS -//

  //- POST

  String _addPupilsToSchoolList(String listId) {
    return '/school_lists/$listId/pupils';
  }

  Future<SchoolList> addPupilsToSchoolList(
      {required String listId, required List<int> pupilIds}) async {
    final data = jsonEncode({"pupils": pupilIds});

    notificationManager.isRunningValue(true);

    final response =
        await _client.post(_addPupilsToSchoolList(listId), data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Hinzufügen zur Schulliste');

      throw ApiException('Failed to delete school list', response.statusCode);
    }
    final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

    return updatedSchoolList;
  }

  //- update pupil list property

  String _patchPupilSchoolList(int pupilId, String listId) {
    return '/pupil_lists/$pupilId/$listId';
  }

  Future<SchoolList> patchSchoolListPupil({
    required int pupilId,
    required String listId,
    bool? value,
    String? comment,
  }) async {
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
    notificationManager.isRunningValue(true);
    final response =
        await _client.patch(_patchPupilSchoolList(pupilId, listId), data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren der Schulliste');

      throw ApiException('Failed to patch school list', response.statusCode);
    }

    final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

    return updatedSchoolList;
  }

  //-DELETE
  String _deletePupilsFromSchoolList(String listId) {
    return '/pupil_lists/$listId/delete_pupils';
  }

  Future<SchoolList> deletePupilsFromSchoolList({
    required List<int> pupilIds,
    required String listId,
  }) async {
    final data = jsonEncode({"pupils": pupilIds});

    notificationManager.isRunningValue(true);

    final response =
        await _client.post(_deletePupilsFromSchoolList(listId), data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen von der Schulliste');

      throw ApiException(
          'Failed to delete pupils from school list', response.statusCode);
    }

    final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

    return updatedSchoolList;
  }

  //- this endpoint is not used in the app
  static const getSchoolListWithPupils = '/school_lists/all';
}
