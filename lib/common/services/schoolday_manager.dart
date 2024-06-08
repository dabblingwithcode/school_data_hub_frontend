import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';

import 'package:schuldaten_hub/common/models/schoolday_models/schoolday.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

class SchooldayManager {
  ValueNotifier<List<Schoolday>> get schooldays => _schooldays;
  ValueListenable<List<DateTime>> get availableDates => _availableDates;
  ValueListenable<DateTime> get thisDate => _thisDate;
  ValueListenable<DateTime> get startDate => _startDate;
  ValueListenable<DateTime> get endDate => _endDate;
  ValueListenable<List<SchoolSemester>> get schoolSemesters => _schoolSemesters;

  final _schooldays = ValueNotifier<List<Schoolday>>([]);
  final _availableDates = ValueNotifier<List<DateTime>>([]);
  final _thisDate = ValueNotifier<DateTime>(DateTime.now());
  final _startDate = ValueNotifier<DateTime>(DateTime.now());
  final _endDate = ValueNotifier<DateTime>(DateTime.now());
  final _schoolSemesters = ValueNotifier<List<SchoolSemester>>([]);

  SchooldayManager();

  final client = locator.get<ApiManager>().dioClient.value;
  final session = locator.get<SessionManager>().credentials.value;

  Future<SchooldayManager> init() async {
    await getSchooldays();
    await getSchoolSemesters();
    return this;
  }

  final apiSchooldayService = ApiSchooldayService();

  Future<void> getSchooldays() async {
    final List<Schoolday> responseSchooldays =
        await apiSchooldayService.getSchooldaysFromServer();

    locator<NotificationManager>().showSnackBar(NotificationType.success,
        '${responseSchooldays.length} Schultage geladen!');

    _schooldays.value = responseSchooldays;
    setAvailableDates();

    return;
  }

  Future<void> postSchoolday(DateTime schoolday) async {
    final Schoolday newSchoolday =
        await apiSchooldayService.postSchoolday(schoolday);

    _schooldays.value = [..._schooldays.value, newSchoolday];

    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Schultag erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  Future<void> deleteSchoolday(Schoolday schoolday) async {
    final bool isDeleted = await apiSchooldayService.deleteSchoolday(schoolday);

    if (isDeleted) {
      _schooldays.value =
          _schooldays.value.where((day) => day != schoolday).toList();

      locator<NotificationManager>().showSnackBar(
          NotificationType.success, 'Schultag erfolgreich gelöscht');
      return;
    }

    setAvailableDates();

    return;
  }

  Future<void> getSchoolSemesters() async {
    final List<SchoolSemester> responseSchoolSemesters =
        await apiSchooldayService.getSchoolSemesters();

    locator<NotificationManager>().showSnackBar(NotificationType.success,
        '${responseSchoolSemesters.length} Schulhalbjahre geladen!');

    _schoolSemesters.value = responseSchoolSemesters;

    return;
  }

  Future<void> postSchoolSemester(
      {required DateTime startDate,
      required DateTime endDate,
      required bool isFirst}) async {
    final SchoolSemester newSemester =
        await apiSchooldayService.postSchoolSemester(
            startDate: startDate, endDate: endDate, isFirst: isFirst);

    _schoolSemesters.value = [..._schoolSemesters.value, newSemester];

    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Schulhalbjahr erfolgreich erstellt');

    return;
  }

  void setAvailableDates() {
    List<DateTime> processedAvailableDates = [];

    for (Schoolday day in _schooldays.value) {
      DateTime validDate = day.schoolday;
      processedAvailableDates.add(validDate);
    }

    _availableDates.value = processedAvailableDates;

    getThisDate();
  }

  void getThisDate() {
    final schooldays = _schooldays.value;

    // we look for the closest schoolday to now and set it as thisDate

    final closestSchooldayToNow = schooldays.reduce((value, element) =>
        value.schoolday.difference(DateTime.now()).abs() <
                element.schoolday.difference(DateTime.now()).abs()
            ? value
            : element);

    _thisDate.value = closestSchooldayToNow.schoolday;

    return;
  }

  void setThisDate(DateTime date) {
    _thisDate.value = date;
  }

  void setStartDate(DateTime date) {
    _startDate.value = date;
  }

  void setEndDate(DateTime date) {
    _endDate.value = date;
  }
}
