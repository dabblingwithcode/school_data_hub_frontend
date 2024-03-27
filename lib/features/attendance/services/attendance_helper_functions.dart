import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';

int missedclassSum(Pupil pupil) {
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

int missedclassUnexcusedSum(Pupil pupil) {
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

lateUnexcusedSum(Pupil pupil) {
  int missedClassUnexcusedCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedClassUnexcusedCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'late' && element.excused == true)
        .length;
  }
  return missedClassUnexcusedCount;
}

int contactedSum(Pupil pupil) {
  int contactedCount = pupil.pupilMissedClasses!
      .where((element) => element.contacted != '0')
      .length;

  return contactedCount;
}

bool pupilIsMissedToday(Pupil pupil) {
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
