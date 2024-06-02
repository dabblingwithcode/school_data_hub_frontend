import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';

class ApiAttendanceService {
  late final DioClient _client = locator<ApiManager>().dioClient.value;
  final pupilManager = locator<PupilManager>();
  final notificationManager = locator<NotificationManager>();

  //- not implemented
  String getMissedClasses = '/missed_classes/all';
  String getOneMissedClass(int id) {
    return '/missed_classes/$id';
  }

  //- fetch missed classes for a date

  String _getMissedClassesOnDate(DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/schoolday/$missedDate';
  }

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      DateTime schoolday) async {
    // This one is called every 10 seconds, isRunning would be annoying

    final Response response =
        await _client.get(_getMissedClassesOnDate(schoolday));

    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.error, 'Fehler: status code ${response.statusCode}');

      throw ApiException('Failed to fetch missed classes', response.statusCode);
    }

    final List<MissedClass> missedClasses = response.data
        .map<MissedClass>((missedClass) => MissedClass.fromJson(missedClass))
        .toList();

    return missedClasses;
  }

  //- post new class

  static const _postMissedClass = '/missed_classes/new';

  Future<PupilData> postMissedClass({
    required int pupilId,
    required MissedType missedType,
    required DateTime date,
    int? minutesLate,
    bool? writtenExcuse,
    bool? excused,
    bool? returned,
    String? returnedAt,
    ContactedType? contactedType,
  }) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({
      "missed_pupil_id": pupilId,
      "missed_day": date.formatForJson(),
      "missed_type": missedType.value,
      "excused": excused ?? false,
      "contacted": contactedType?.value ?? '0',
      "returned": returned ?? false,
      "returned_at": returnedAt,
      "minutes_late": minutesLate,
      "written_excuse": writtenExcuse ?? false,
    });
    final Response response = await _client.post(_postMissedClass, data: data);
    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Hinzufügen des Eintrags!');

      throw ApiException('Failed to add missed class', response.statusCode);
    }

    final pupil = PupilData.fromJson(response.data);

    return pupil;
  }

  //- post a list of missed classes

  static const _postMissedClassList = '/missed_classes/list';

  Future<PupilData> postMissedClassList(
      {required List<MissedClass> missedClasses}) async {
    final data = jsonEncode([
      missedClasses.map((missedClass) => missedClass.toJson()).toList(),
    ]);

    notificationManager.isRunningValue(true);

    final Response response =
        await _client.post(_postMissedClassList, data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Hinzufügen des Eintrags!');

      throw ApiException(
          'Failed to add many missed classes', response.statusCode);
    }

    final pupil = PupilData.fromJson(response.data);

    return pupil;
  }

  //- patch a missed class

  String _patchMissedClass(int pupilId, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/$pupilId/$missedDate';
  }

  Future<PupilData> patchMissedClass({
    required int pupilId,
    required DateTime date,
    MissedType? missedType,
    int? minutesLate,
    bool? writtenExcuse,
    bool? excused,
    bool? returned,
    String? returnedAt,
    ContactedType? contactedType,
  }) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      "missed_pupil_id": pupilId,
      "missed_day": date.formatForJson(),
      if (missedType != null) "missed_type": missedType.value,
      if (excused != null) "excused": excused,
      if (contactedType != null) "contacted": contactedType.value,
      if (returned != null) "returned": returned,
      if (returnedAt != null) "returned_at": returnedAt,
      if (minutesLate != null) "minutes_late": minutesLate,
      if (writtenExcuse != null) "written_excuse": writtenExcuse,
    });

    final Response response =
        await _client.patch(_patchMissedClass(pupilId, date), data: data);

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Hinzufügen des Eintrags!');

      throw ApiException('Failed to add missed class', response.statusCode);
    }

    final pupil = PupilData.fromJson(response.data);

    return pupil;
  }

  //- delete missed class

  String _deleteMissedClassUrl(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/$id/$missedDate';
  }

  Future<PupilData> deleteMissedClass(int pupilId, DateTime date) async {
    notificationManager.isRunningValue(true);

    final response = await _client.delete(_deleteMissedClassUrl(pupilId, date));

    notificationManager.isRunningValue(false);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler: status code ${response.statusCode}');

      throw ApiException('Failed to delete missed class', response.statusCode);
    }

    final pupil = PupilData.fromJson(response.data);

    return pupil;
  }
}
