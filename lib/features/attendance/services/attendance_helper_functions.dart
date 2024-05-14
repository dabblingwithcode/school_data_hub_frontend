import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';

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

int? findMissedClassIndex(PupilProxy pupil, DateTime date) {
  final int? foundMissedClassIndex = pupil.pupilMissedClasses
      ?.indexWhere((datematch) => (datematch.missedDay.isSameDate(date)));
  if (foundMissedClassIndex == null) {
    return null;
  }
  return foundMissedClassIndex;
}

//-VALUES
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
