import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/models/schoolday_models/schoolday.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';

class ApiSchooldayService {
  final DioClient _client = locator<ApiManager>().dioClient.value;

  final notificationManager = locator<NotificationManager>();

  //- get schooldays

  static const getSchooldaysWithChildren = '/schooldays/all';

  static const _getSchooldays = '/schooldays/all/flat';
  Future<List<Schoolday>> getSchooldaysFromServer() async {
    notificationManager.isRunningValue(true);

    final Response response = await _client.get(_getSchooldays);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Die Schultage konnten nicht geladen werden');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to fetch schooldays', response.statusCode);
    }

    final List<Schoolday> schooldays = List<Schoolday>.from(
        (response.data as List).map((e) => Schoolday.fromJson(e)));

    notificationManager.isRunningValue(false);

    return schooldays;
  }

  String getOneSchoolday(DateTime date) {
    return '/schooldays/${date.formatForJson()}';
  }

  //- POST
  static const _postSchoolday = '/schooldays/new';
  static const postMultipleSchooldays = '/schooldays/new/list';

  Future<Schoolday> postSchoolday(DateTime date) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({'schoolday': date.formatForJson()});

    final Response response = await _client.post(_postSchoolday, data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Schultages');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to post schoolday', response.statusCode);
    }

    notificationManager.isRunningValue(false);

    return Schoolday.fromJson(response.data);
  }

  //- DELETE
  String _deleteSchoolday(DateTime date) {
    return '/schooldays/${date.formatForJson()}';
  }

  Future<bool> deleteSchoolday(Schoolday schoolday) async {
    notificationManager.isRunningValue(true);

    final Response response =
        await _client.delete(_deleteSchoolday(schoolday.schoolday));

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Schultages');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to delete schoolday', response.statusCode);
    }

    notificationManager.isRunningValue(false);

    return true;
  }

  static const deleteSchooldays = '/schooldays/delete/list';

  //- School semester

  static const _getSchoolSemester = '/school_semesters/all';

  Future<List<SchoolSemester>> getSchoolSemesters() async {
    notificationManager.isRunningValue(true);

    final Response response = await _client.get(_getSchoolSemester);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Schulsemester konnten nicht geladen werden');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to fetch school semesters', response.statusCode);
    }

    final List<SchoolSemester> schoolSemesters = List<SchoolSemester>.from(
        (response.data as List).map((e) => SchoolSemester.fromJson(e)));

    notificationManager.isRunningValue(false);

    return schoolSemesters;
  }

  static const _postSchoolSemester = '/school_semesters/new';

  Future<SchoolSemester> postSchoolSemester(
      {required DateTime startDate,
      required DateTime endDate,
      required bool isFirst}) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      'start_date': startDate.formatForJson(),
      'end_date': endDate.formatForJson(),
      'is_first': isFirst
    });

    final Response response =
        await _client.post(_postSchoolSemester, data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Schulsemesters');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to post school semester', response.statusCode);
    }

    notificationManager.isRunningValue(false);

    return SchoolSemester.fromJson(response.data);
  }
}
