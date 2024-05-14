import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';

class EndpointsSchoolList {
  final _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- get school lists
  static const getSchoolListsUrl = '/school_lists/all/flat';
  Future<List<SchoolList>> fetchSchoolLists() async {
    notificationManager.isRunningValue(true);
    final response = await _client.get(EndpointsSchoolList.getSchoolListsUrl);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Schullisten');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to fetch school lists', response.statusCode);
    }
    final List<SchoolList> schoolLists =
        (response.data as List).map((e) => SchoolList.fromJson(e)).toList();
    notificationManager.showSnackBar(
        NotificationType.success, 'Schullisten geladen');
    notificationManager.isRunningValue(false);
    return schoolLists;
  }

  //- POST
  static const postSchoolListWithGroupUrl = '/school_lists/list';
  Future<SchoolList> postSchoolListWithGroup(
      {required String name,
      required String description,
      required List<int> pupilIds,
      required String visibility}) async {
    String data = jsonEncode({
      "list_name": name,
      "list_description": description,
      "pupils": pupilIds,
      "visibility": visibility
    });
    final response = await _client
        .post(EndpointsSchoolList.postSchoolListWithGroupUrl, data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen der Schulliste');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to create school list', response.statusCode);
    }

    final newList = SchoolList.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich erstellt');
    notificationManager.isRunningValue(false);
    //- hier kommt nur schoollist zurück, es fehlen die pupil lists der SuS,
    //- die jetzt dirty sind
    return newList;
  }

  static const postSchoolList = '/school_lists/all';

  //- patch school list
  String patchSchoolListUrl(String listId) {
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

    final Response response = await _client.patch(
        EndpointsSchoolList().patchSchoolListUrl(schoolListToUpdate.listId),
        data: data);

    //- isRunning direkt nach dem Response überall setzen, zweiten braucht man nicht
    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      throw ApiException('Failed to update school list', response.statusCode);
    }
    return SchoolList.fromJson(response.data);
  }

  //- delete school list
  String deleteSchoolListUrl(String listId) {
    return '/school_lists/$listId';
  }

  Future deleteSchoolList(String listId) async {
    notificationManager.isRunningValue(true);
    final Response response =
        await _client.delete(EndpointsSchoolList().deleteSchoolListUrl(listId));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen der Schulliste');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to delete school list', response.statusCode);
    }
    //- Sollten hier ein response data mit allen Listen als Bestätigung zurückkommen?
  }

  //- PUPIL LISTS -//

  //- POST
  String addPupilsToSchoolList(String listId) {
    return '/school_lists/$listId/pupils';
  }

  //-PATCH
  String patchPupilSchoolList(int pupilId, String listId) {
    return '/pupil_lists/$pupilId/$listId';
  }

  //-DELETE
  String deletePupilsFromSchoolList(String listId) {
    return '/pupil_lists/$listId/delete_pupils';
  }

  //- this endpoint is not used in the app
  static const getSchoolListWithPupils = '/school_lists/all';
}
