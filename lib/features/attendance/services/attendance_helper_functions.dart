import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

//- lookup functions

int? findMissedClassIndex(PupilProxy pupil, DateTime date) {
  final int? foundMissedClassIndex = pupil.pupilMissedClasses
      ?.indexWhere((datematch) => (datematch.missedDay.isSameDate(date)));
  if (foundMissedClassIndex == null) {
    return null;
  }
  return foundMissedClassIndex;
}

//- overview numbers functions

//- of all pupils

int missedGlobalSum() {
  int missedGlobalSum = 0;
  final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
  for (PupilProxy pupil in allPupils) {
    if (pupil.pupilMissedClasses!.isNotEmpty) {
      missedGlobalSum += pupil.pupilMissedClasses!
          .where((element) =>
              element.missedType == 'missed' ||
              element.missedType == 'home' ||
              element.backHome == true)
          .length;
    }
  }
  return missedGlobalSum;
}

int unexcusedGlobalSum() {
  int unexcusedGlobalSum = 0;
  final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
  for (PupilProxy pupil in allPupils) {
    if (pupil.pupilMissedClasses!.isNotEmpty) {
      unexcusedGlobalSum += pupil.pupilMissedClasses!
          .where((element) =>
              element.missedType == 'missed' && element.excused == true)
          .length;
    }
  }
  return unexcusedGlobalSum;
}

int lateGlobalSum() {
  int lateGlobalSum = 0;
  final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
  for (PupilProxy pupil in allPupils) {
    if (pupil.pupilMissedClasses!.isNotEmpty) {
      lateGlobalSum += pupil.pupilMissedClasses!
          .where((element) => element.missedType == 'late')
          .length;
    }
  }
  return lateGlobalSum;
}

int contactedGlobalSum() {
  int contactedGlobalSum = 0;
  final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
  for (PupilProxy pupil in allPupils) {
    if (pupil.pupilMissedClasses!.isNotEmpty) {
      contactedGlobalSum += pupil.pupilMissedClasses!
          .where((element) => element.contacted != '0')
          .length;
    }
  }
  return contactedGlobalSum;
}

int pickedUpGlobalSum() {
  int pickedUpGlobalSum = 0;
  final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
  for (PupilProxy pupil in allPupils) {
    if (pupil.pupilMissedClasses!.isNotEmpty) {
      pickedUpGlobalSum += pupil.pupilMissedClasses!
          .where((element) => element.backHome == true)
          .length;
    }
  }
  return pickedUpGlobalSum;
}

//- of a list of pupils in a schoolday

int missedPupilsSum(List<PupilProxy> filteredPupils, DateTime thisDate) {
  List<PupilProxy> missedPupils = [];
  if (filteredPupils.isNotEmpty) {
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay == thisDate &&
          (missedClass.missedType == 'missed' ||
              missedClass.missedType == 'home' ||
              missedClass.backHome == true))) {
        missedPupils.add(pupil);
      }
    }
    return missedPupils.length;
  }
  return 0;
}

int unexcusedPupilsSum(List<PupilProxy> filteredPupils, DateTime thisDate) {
  List<PupilProxy> unexcusedPupils = [];

  for (PupilProxy pupil in filteredPupils) {
    if (pupil.pupilMissedClasses!.any((missedClass) =>
        missedClass.missedDay == thisDate && missedClass.excused == true)) {
      unexcusedPupils.add(pupil);
    }
  }

  return unexcusedPupils.length;
}

//- of a list of pupils

int pupilListMissedclassSum(List<PupilProxy> filteredPupils) {
  int pupilsListmissedclassSum = 0;
  for (PupilProxy pupil in filteredPupils) {
    pupilsListmissedclassSum += missedclassSum(pupil);
  }
  return pupilsListmissedclassSum;
}

int pupilListUnexcusedSum(List<PupilProxy> filteredPupils) {
  int pupilsListUnexcusedSum = 0;
  for (PupilProxy pupil in filteredPupils) {
    pupilsListUnexcusedSum += missedclassUnexcusedSum(pupil);
  }
  return pupilsListUnexcusedSum;
}

int pupilListLateSum(List<PupilProxy> filteredPupils) {
  int pupilsListLateSum = 0;
  for (PupilProxy pupil in filteredPupils) {
    pupilsListLateSum += lateSum(pupil);
  }
  return pupilsListLateSum;
}

int pupilListContactedSum(List<PupilProxy> filteredPupils) {
  int pupilsListContactedSum = 0;
  for (PupilProxy pupil in filteredPupils) {
    pupilsListContactedSum += contactedSum(pupil);
  }
  return pupilsListContactedSum;
}

int pupilListPickedUpSum(List<PupilProxy> filteredPupils) {
  int pupilsListPickedUpSum = 0;
  for (PupilProxy pupil in filteredPupils) {
    pupilsListPickedUpSum += pickedUpSum(pupil);
  }
  return pupilsListPickedUpSum;
}
//- of a single pupil

int missedclassSum(PupilProxy pupil) {
  // count the number of missed classes - avoid null when missedClasses is empty
  int missedclassCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedclassCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'missed' && element.excused == false)
        .length;
  }
  return missedclassCount;
}

int missedclassUnexcusedSum(PupilProxy pupil) {
  // count the number of unexcused missed classes
  int missedclassCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedclassCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'missed' && element.excused == true)
        .length;
  }
  return missedclassCount;
}

int lateSum(PupilProxy pupil) {
  int lateCount = 0;
  if (pupil.pupilMissedClasses != null) {
    lateCount = pupil.pupilMissedClasses!
        .where((element) => element.missedType == 'late')
        .length;
  }
  return lateCount;
}

lateUnexcusedSum(PupilProxy pupil) {
  int missedClassUnexcusedCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedClassUnexcusedCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'late' && element.excused == true)
        .length;
  }
  return missedClassUnexcusedCount;
}

int contactedSum(PupilProxy pupil) {
  int contactedCount = pupil.pupilMissedClasses!
      .where((element) => element.contacted != '0')
      .length;

  return contactedCount;
}

int pickedUpSum(PupilProxy pupil) {
  int pickedUpCount = pupil.pupilMissedClasses!
      .where((element) => element.backHome == true)
      .length;

  return pickedUpCount;
}

//- check condition functions

bool pupilIsMissedToday(PupilProxy pupil) {
  if (pupil.pupilMissedClasses!.isEmpty) return false;
  if (pupil.pupilMissedClasses!.any((element) =>
      element.missedDay.isSameDate(DateTime.now()) &&
      element.missedType != 'late')) {
    return true;
  }
  return false;
}

bool schooldayIsToday(DateTime schoolday) {
  if (schoolday.isSameDate(DateTime.now())) {
    return true;
  }
  return false;
}

//- set value functions
MissedType setMissedTypeValue(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1 || missedClass == null) {
    return MissedType.notSet;
  }
  final dropdownvalue = pupil.pupilMissedClasses![missedClass].missedType;

  final MissedType missedType =
      MissedType.values.firstWhere((e) => e.value == dropdownvalue);
  return missedType;
}

ContactedType setContactedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return ContactedType.notSet;
  } else {
    final contactedType = ContactedType.values.firstWhereOrNull(
        (e) => e.value == pupil.pupilMissedClasses![missedClass!].contacted);

    return contactedType ?? ContactedType.notSet;
  }
}

String? setCreatedModifiedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1 || missedClass == null) {
    return null;
  }
  final String createdBy = pupil.pupilMissedClasses![missedClass].createdBy;
  final String? modifiedBy = pupil.pupilMissedClasses![missedClass].modifiedBy;

  if (modifiedBy != null) {
    return modifiedBy;
  }
  return createdBy;
}

bool setExcusedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return false;
  }
  final excusedValue = pupil.pupilMissedClasses![missedClass!].excused;
  return excusedValue!;
}

bool? setReturnedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);

  if (missedClass == -1) {
    return false;
  }
  final returnedindex = pupil.pupilMissedClasses![missedClass!].backHome;
  return returnedindex;
}

String? setReturnedTime(int pupilId, DateTime date) {
  final PupilProxy pupil = locator<PupilManager>().findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return null;
  }
  final returnedTime = pupil.pupilMissedClasses![missedClass!].backHomeAt;
  return returnedTime;
}

//- Date functions

Future<void> setThisDate(BuildContext context, DateTime thisDate) async {
  final DateTime? newDate = await selectDate(context, thisDate);
  if (newDate != null) {
    locator<SchooldayManager>().setThisDate(newDate);
  }
}

String thisDateAsString(BuildContext context, DateTime thisDate) {
  return '${DateFormat('EEEE', Localizations.localeOf(context).toString()).format(thisDate)}, ${thisDate.formatForUser()}';
}
