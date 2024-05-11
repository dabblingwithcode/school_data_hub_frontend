import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
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

  ValueListenable<bool> get isRunning => _isRunning;

  final _schooldays = ValueNotifier<List<Schoolday>>([]);
  final _availableDates = ValueNotifier<List<DateTime>>([]);
  final _thisDate = ValueNotifier<DateTime>(DateTime.now());
  final _startDate = ValueNotifier<DateTime>(DateTime.now());
  final _endDate = ValueNotifier<DateTime>(DateTime.now());

  final _isRunning = ValueNotifier<bool>(false);

  SchooldayManager();

  final client = locator.get<ApiManager>().dioClient.value;
  final session = locator.get<SessionManager>().credentials.value;

  Future<SchooldayManager> init() async {
    await getSchooldays();
    return this;
  }

  Future getSchooldays() async {
    locator<SnackBarManager>().isRunningValue(true);
    try {
      final response = await client.get(EndpointsSchoolday.getSchooldays);
      final schooldays =
          (response.data as List).map((e) => Schoolday.fromJson(e)).toList();
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.success, '${schooldays.length} Schultage geladen!');

      _schooldays.value = schooldays;
      setAvailableDates();
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    locator<SnackBarManager>().isRunningValue(false);
  }

  setAvailableDates() {
    locator<SnackBarManager>().isRunningValue(true);
    List<DateTime> processedAvailableDates = [];
    for (Schoolday day in _schooldays.value) {
      DateTime validDate = day.schoolday;
      processedAvailableDates.add(validDate);
    }
    _availableDates.value = processedAvailableDates;
    debug.success(
        '${_availableDates.value.length} selectableDates | ${StackTrace.current}');

    getThisDate();
    // locator<SnackBarManager>().isRunningValue(false);
  }

  getThisDate() {
    final schooldays = _schooldays.value;
    final closestSchooldayToNow = schooldays.reduce((value, element) =>
        value.schoolday.difference(DateTime.now()).abs() <
                element.schoolday.difference(DateTime.now()).abs()
            ? value
            : element);
    _thisDate.value = closestSchooldayToNow.schoolday;
    debug.success(
        'This day is ${_thisDate.value.formatForUser()} | ${StackTrace.current}');
  }

  setThisDate(DateTime date) {
    _thisDate.value = date;
  }

  setStartDate(DateTime date) {
    _startDate.value = date;
  }

  setEndDate(DateTime date) {
    _endDate.value = date;
  }
}
