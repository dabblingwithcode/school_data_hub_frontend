import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

class AttendanceManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = EndpointsMissedClass();

  ValueListenable<bool> get isRunning => _isRunning;

  final _isRunning = ValueNotifier<bool>(false);

  AttendanceManager(
      // this.session,
      );
  Future init() async {
    // await fetchMissedClassesOnASchoolday(schooldayManager.thisDate.value);
    return;
  }

  Future<void> fetchMissedClassesOnASchoolday(DateTime schoolday) async {
    // This one is called every 10 seconds, isRunning would be annoying
    final Response response = await client
        .get(EndpointsMissedClass().getMissedClassesOnDate(schoolday));
    if (response.statusCode == 404) {
      debug.info('No missed classes found on $schoolday');
      return;
    }
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');

      return;
    }
    final List<MissedClass> missedClasses = response.data
        .map<MissedClass>((missedClass) => MissedClass.fromJson(missedClass))
        .toList();
    pupilManager.patchPupilsWithMissedClasses(missedClasses);

    return;
  }

  void changeExcusedValue(int pupilId, DateTime date, bool newValue) async {
    locator<SnackBarManager>().isRunningValue(true);
    final Pupil pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == null || missedClass == -1) {
      return;
    }
    final data = jsonEncode({"excused": newValue});
    final Response response = await client
        .patch(endpoints.patchMissedClass(pupilId, date), data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode == 200) {
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');

      debug.warning('Changed excused state to $newValue');

      pupilManager.patchPupilFromResponse(pupilResponse);
    }
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }

  Future<void> deleteMissedClass(int pupilId, DateTime date) async {
    locator<SnackBarManager>().isRunningValue(true);
    final response = await client
        .delete(EndpointsMissedClass().deleteMissedClass(pupilId, date));

    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');

      //- TO-DO: delete the missed class in the manager too! E.g. make the server respond with the pupil?

      return;
    }
    pupilManager.patchPupilFromResponse(response.data);
    locator<SnackBarManager>().isRunningValue(false);

    return;
  }

  void changeReturnedValue(
      int pupilId, bool newValue, DateTime date, String? time) async {
    locator<SnackBarManager>().isRunningValue(true);
    final Pupil pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    final List<int> pupilBaseIds =
        locator<PupilBaseManager>().availablePupilIds.value;
    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp
    //* Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"
    if (missedClass == -1) {
      debug.info('This missed class is new');
      final data = jsonEncode({
        "missed_pupil_id": pupilId,
        "missed_day": date.formatForJson(),
        "missed_type": 'none',
        "excused": false,
        "contacted": '0',
        "returned": true,
        "returned_at": time,
        "minutes_late": null,
        "written_excuse": null
      });
      // making the request
      final Response response =
          await client.post(EndpointsMissedClass.postMissedClass, data: data);
      final Map<String, dynamic> pupilResponse = response.data;
      // handle errors
      if (response.statusCode != 200) {
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.error, 'Fehler: status code ${response.statusCode}');
        locator<SnackBarManager>().isRunningValue(false);
        return;
      }
      // the request was successful -
      //we patch the pupil in the pupilmanager with the response
      pupilManager.patchPupilFromResponse(pupilResponse);
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    //* Case delete 'none' + 'returned' missed class *//
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that
    if (newValue == false &&
        pupil.pupilMissedClasses![missedClass!].missedType == 'none') {
      final response = await client
          .delete(EndpointsMissedClass().deleteMissedClass(pupilId, date));
      await pupilManager.fetchPupilsById(pupilBaseIds);
      if (response.statusCode != 200) {
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.error, 'Fehler: status code ${response.statusCode}');
        locator<SnackBarManager>().isRunningValue(false);
        return;
      }
      locator<PupilFilterManager>().refreshFilteredPupils();
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Fehlzeit gelöscht!');

      return;
    }
    //* Case patch an existing missed class entry
    // The only way to create a 'return' entry in a 'none' missed class slot
    // is to check 'returned' - let's check that
    if (newValue == true) {
      final data = jsonEncode({"returned": newValue, "returned_at": time});
      // send the request
      final Response response = await client
          .patch(endpoints.patchMissedClass(pupilId, date), data: data);
      // handle errors
      if (response.statusCode != 200) {
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.error, 'Fehler: status code ${response.statusCode}');
        locator<SnackBarManager>().isRunningValue(false);

        return;
      }
      // the request was successful -
      //we patch the pupil in the pupilmanager with the response
      final Map<String, dynamic> pupilResponse = response.data;
      pupilManager.patchPupilFromResponse(pupilResponse);
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
      locator<SnackBarManager>().isRunningValue(false);
    }
  }

  Future<void> changeLateTypeValue(
      int pupilId, String dropdownValue, DateTime date, int minutesLate) async {
    locator<SnackBarManager>().isRunningValue(true);
    // Let's look for an existing missed class - if pupil and date match, there is one
    final Pupil pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == -1) {
      // The missed class does not exist - let's create one
      debug.info('This missed class is new');
      final data = jsonEncode({
        "missed_pupil_id": pupilId,
        "missed_day": date.formatForJson(),
        "missed_type": dropdownValue,
        "excused": false,
        "contacted": '0',
        "returned": false,
        "returned_at": null,
        "minutes_late": minutesLate,
        "written_excuse": null
      });

      final Response response =
          await client.post(EndpointsMissedClass.postMissedClass, data: data);
      final Map<String, dynamic> pupilResponse = response.data;
      if (response.statusCode != 200) {
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.error, 'Fehler: status code ${response.statusCode}');
        locator<SnackBarManager>().isRunningValue(false);
        return;
      }
      pupilManager.patchPupilFromResponse(pupilResponse);
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    // The missed class exists already - patching it
    debug.info('This missed class exists - patching');
    final data =
        jsonEncode({"missed_type": dropdownValue, "minutes_late": minutesLate});
    final Response response = await client
        .patch(endpoints.patchMissedClass(pupilId, date), data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');
      locator<SnackBarManager>().isRunningValue(false);

      return;
    }
    // the request was successful -
    //we patch the pupil in the pupilmanager with the response
    pupilManager.patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }

  Future<void> createManyMissedClasses(
      id, startdate, enddate, missedType) async {
    locator<SnackBarManager>().isRunningValue(true);
    List<Map<String, dynamic>> missedClasses = [];
    final Pupil pupil =
        pupilManager.pupils.value.firstWhere((pupil) => pupil.internalId == id);
    final List<DateTime> validSchooldays =
        locator<SchooldayManager>().availableDates.value;
    for (DateTime validSchoolday in validSchooldays) {
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        Map<String, dynamic> data = {
          "missed_pupil_id": pupil.internalId,
          "missed_day": validSchoolday.formatForJson(),
          "missed_type": missedType,
          "excused": false,
          "contacted": '0',
          "returned": false,
          "returned_at": null,
          "minutes_late": null,
          "written_excuse": null
        };
        missedClasses.add(data);
      }
    }
    final listData = jsonEncode(missedClasses);
    final response = await client.post(EndpointsMissedClass.postMissedClassList,
        data: listData);
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');
      return;
    }
    await pupilManager.patchPupilFromResponse(response.data);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Einträge erfolgreich!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }

  void changeMissedTypeValue(
      int pupilId, String dropdownValue, DateTime date) async {
    locator<SnackBarManager>().isRunningValue(true);

    if (dropdownValue == 'none') {
      // change value to 'none' means there was a missed class that has to be deleted
      await deleteMissedClass(pupilId, date);
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    // Let's look for an existing missed class - if pupil and date match, there is one
    final Pupil pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == -1) {
      // The missed class does not exist - let's create one
      debug.info('This missed class is new');
      final data = jsonEncode({
        "missed_pupil_id": pupilId,
        "missed_day": date.formatForJson(),
        "missed_type": dropdownValue,
        "excused": false,
        "contacted": '0',
        "returned": false,
        "returned_at": null,
        "minutes_late": null,
        "written_excuse": null
      });

      final Response response =
          await client.post(EndpointsMissedClass.postMissedClass, data: data);
      final Map<String, dynamic> pupilResponse = response.data;
      if (response.statusCode != 200) {
        locator<SnackBarManager>().showSnackBar(
            SnackBarType.error, 'Fehler: status code ${response.statusCode}');
        locator<SnackBarManager>().isRunningValue(false);
        return;
      }
      await pupilManager.patchPupilFromResponse(pupilResponse);
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    // The missed class exists already - patching it
    debug.info('This missed class exists - patching');

    // we make sure that incidentally stored minutes_late values are deleted
    final data =
        jsonEncode({"missed_type": dropdownValue, "minutes_late": null});
    final Response response = await client
        .patch(endpoints.patchMissedClass(pupilId, date), data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }

    await pupilManager.patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }

  void changeContactedValue(
      int pupilId, String dropdownValue, DateTime date) async {
    locator<SnackBarManager>().isRunningValue(true);

    debug.info('Changing contacted value');
    debug.info('pupilId $pupilId, dropdownValue $dropdownValue, date $date');

    // The missed class exists alreade - patching it
    debug.info('This missed class exists - patching');
    final data = jsonEncode({"contacted": dropdownValue});
    final Response response = await client
        .patch(endpoints.patchMissedClass(pupilId, date), data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.error, 'Fehler: status code ${response.statusCode}');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    await pupilManager.patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }
}
