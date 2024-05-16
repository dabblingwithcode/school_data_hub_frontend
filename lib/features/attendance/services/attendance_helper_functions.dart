import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';

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

int missedPupilsSum(List<PupilProxy> filteredPupils, DateTime thisDate) {
  List<PupilProxy> missedPupils = [];
  if (filteredPupils.isNotEmpty) {
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay == thisDate &&
          (missedClass.missedType == 'missed' ||
              missedClass.missedType == 'home' ||
              missedClass.returned == true))) {
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
setMissedTypeValue(int pupilId, DateTime date) {
  final PupilProxy pupil = findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1 || missedClass == null) {
    return 'none';
  }
  final dropdownvalue = pupil.pupilMissedClasses![missedClass].missedType;
  return dropdownvalue;
}

String setContactedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return '0';
  } else {
    final contactedIndex = pupil.pupilMissedClasses![missedClass!].contacted;

    return contactedIndex!;
  }
}

String? setCreatedModifiedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = findPupilById(pupilId);
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
  final PupilProxy pupil = findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return false;
  }
  final excusedValue = pupil.pupilMissedClasses![missedClass!].excused;
  return excusedValue!;
}

bool? setReturnedValue(int pupilId, DateTime date) {
  final PupilProxy pupil = findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);

  if (missedClass == -1) {
    return false;
  }
  final returnedindex = pupil.pupilMissedClasses![missedClass!].returned;
  return returnedindex;
}

String? setReturnedTime(int pupilId, DateTime date) {
  final PupilProxy pupil = findPupilById(pupilId);
  final int? missedClass = findMissedClassIndex(pupil, date);
  if (missedClass == -1) {
    return null;
  }
  final returnedTime = pupil.pupilMissedClasses![missedClass!].returnedAt;
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
