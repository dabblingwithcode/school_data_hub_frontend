import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

enum MissedType {
  isLate('late'),
  isMissed('missed'),
  notSet('none');

  final String value;
  const MissedType(this.value);
}

enum ContactedType {
  notSet('0'),
  contacted('1'),
  calledBack('2'),
  notReached('3');

  final String value;
  const ContactedType(this.value);
}

class AttendanceManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final notificationManager = locator<NotificationManager>();
  final client = locator<ApiManager>().dioClient.value;
  final apiAttendanceService = ApiAttendanceService();

  ValueListenable<List<MissedClass>> get missedClasses => _missedClasses;
  final ValueNotifier<List<MissedClass>> _missedClasses = ValueNotifier([]);
  AttendanceManager() {
    init();
  }

  Future init() async {
    // await fetchMissedClassesOnASchoolday(schooldayManager.thisDate.value);
    addAllPupilMissedClasses();
    return;
  }

  void addAllPupilMissedClasses() {
    final List<MissedClass> allMissedClasses = [];
    for (PupilProxy pupil in pupilManager.allPupils) {
      if (pupil.pupilMissedClasses != null) {
        allMissedClasses.addAll(pupil.pupilMissedClasses!);
      }
    }
    _missedClasses.value = allMissedClasses;
  }

  List<MissedClass> getMissedClassesOnADay(DateTime date) {
    return _missedClasses.value
        .where((missedClass) => missedClass.missedDay.isSameDate(date))
        .toList();
  }

  Future<void> fetchMissedClassesOnASchoolday(DateTime schoolday) async {
    final List<MissedClass> missedClasses =
        await apiAttendanceService.fetchMissedClassesOnASchoolday(schoolday);

    pupilManager.updatePupilsFromMissedClasses(missedClasses);

    // notificationManager.showSnackBar(
    //     NotificationType.success, 'Fehlzeiten erfolgreich geladen!');

    return;
  }

  Future<void> changeExcusedValue(
      int pupilId, DateTime date, bool newValue) async {
    final PupilProxy pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == null || missedClass == -1) {
      return;
    }
    final PupilData responsePupil = await apiAttendanceService.patchMissedClass(
        pupilId: pupilId, date: date, excused: newValue);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> deleteMissedClass(int pupilId, DateTime date) async {
    final PupilData responsePupil =
        await apiAttendanceService.deleteMissedClass(
      pupilId,
      date,
    );

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Fehlzeit erfolgreich gelöscht!');

    return;
  }

  Future<void> changeReturnedValue(
      int pupilId, bool newValue, DateTime date, String? time) async {
    locator<NotificationManager>().isRunningValue(true);
    final PupilProxy pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);

    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp

    //- Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"

    if (missedClass == -1) {
      // This missed class is new
      final PupilData pupilData = await apiAttendanceService.postMissedClass(
        pupilId: pupilId,
        missedType: MissedType.notSet,
        date: date,
        excused: false,
        contactedType: ContactedType.notSet,
        returned: true,
        returnedAt: time,
      );

      locator<PupilManager>().updatePupilProxyWithPupilData(pupilData);

      return;
    }

    //- Case delete 'none' + 'returned' missed class
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that

    if (newValue == false &&
        pupil.pupilMissedClasses![missedClass!].missedType ==
            MissedType.notSet.value) {
      final PupilData responsePupil =
          await apiAttendanceService.deleteMissedClass(
        pupilId,
        date,
      );

      locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

      return;
    }

    //- Case patch an existing missed class entry

    if (newValue == true) {
      final PupilData responsePupil =
          await apiAttendanceService.patchMissedClass(
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: time,
      );

      locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

      return;
    } else {
      final PupilData responsePupil =
          await apiAttendanceService.patchMissedClass(
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: null,
      );

      locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

      return;
    }
  }

  Future<void> changeLateTypeValue(int pupilId, MissedType dropdownValue,
      DateTime date, int minutesLate) async {
    // Let's look for an existing missed class - if pupil and date match, there is one

    final PupilProxy pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == -1) {
      // The missed class does not exist - let's create one

      final PupilData responsePupil =
          await apiAttendanceService.postMissedClass(
        pupilId: pupilId,
        missedType: dropdownValue,
        date: date,
        minutesLate: minutesLate,
        excused: false,
        contactedType: ContactedType.notSet,
        returned: false,
        returnedAt: null,
        writtenExcuse: null,
      );

      locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

      return;
    }

    // The missed class exists already - patching it

    final PupilData responsePupil = await apiAttendanceService.patchMissedClass(
      pupilId: pupilId,
      missedType: dropdownValue,
      date: date,
      minutesLate: minutesLate,
    );

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    return;
  }

  Future<void> createManyMissedClasses(
      id, startdate, enddate, missedType) async {
    List<MissedClass> missedClasses = [];

    final PupilProxy pupil =
        pupilManager.allPupils.firstWhere((pupil) => pupil.internalId == id);

    final List<DateTime> validSchooldays =
        locator<SchooldayManager>().availableDates.value;

    for (DateTime validSchoolday in validSchooldays) {
      // if the date is the same as the startdate or enddate or in between
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        missedClasses.add(MissedClass(
          createdBy: locator<SessionManager>().credentials.value.username!,
          missedPupilId: pupil.internalId,
          missedDay: validSchoolday,
          missedType: missedType,
          excused: false,
          contacted: '0',
          returned: false,
          returnedAt: null,
          minutesLate: null,
          writtenExcuse: null,
        ));
      }
    }

    final PupilData responsePupil = await apiAttendanceService
        .postMissedClassList(missedClasses: missedClasses);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Einträge erfolgreich!');

    return;
  }

  Future<void> changeMissedTypeValue(
      int pupilId, MissedType missedType, DateTime date) async {
    if (missedType == MissedType.notSet) {
      // change value to 'notSet' means there was a missed class that has to be deleted

      await deleteMissedClass(pupilId, date);

      locator<NotificationManager>().isRunningValue(false);

      return;
    }

    // Let's look for an existing missed class - if pupil and date match, there is one

    final PupilProxy pupil = findPupilById(pupilId);
    final int? missedClass = findMissedClassIndex(pupil, date);
    if (missedClass == -1) {
      // The missed class does not exist - let's create one

      logger.i('This missed class is new');

      final PupilData responsePupil =
          await apiAttendanceService.postMissedClass(
        pupilId: pupilId,
        missedType: missedType,
        date: date,
      );

      pupilManager.updatePupilProxyWithPupilData(responsePupil);

      locator<NotificationManager>()
          .showSnackBar(NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }
    // The missed class exists already - patching it
    // we make sure that incidentally stored minutes_late values are deleted
    final PupilData responsePupil = await apiAttendanceService.patchMissedClass(
      pupilId: pupilId,
      missedType: missedType,
      date: date,
      minutesLate: null,
    );

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> changeContactedValue(
      int pupilId, ContactedType contactedType, DateTime date) async {
    // The missed class exists alreade - patching it
    final PupilData responsePupil = await apiAttendanceService.patchMissedClass(
      pupilId: pupilId,
      contactedType: contactedType,
      date: date,
    );

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }
}
