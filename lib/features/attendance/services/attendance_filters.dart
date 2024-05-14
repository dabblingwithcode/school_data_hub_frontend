import 'package:collection/collection.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

bool attendanceFilter(PupilProxy pupil, bool toList) {
  final thisDate = locator<SchooldayManager>().thisDate.value;
  final activeFilters = locator<PupilFilterManager>().filterState.value;
  // Filter pupils present
  if ((activeFilters[PupilFilter.present]! &&
              pupil.pupilMissedClasses!.any((missedClass) =>
                  missedClass.missedDay.isSameDate(thisDate) &&
                      missedClass.missedType == 'late' ||
                  (pupil.pupilMissedClasses!.firstWhereOrNull((missedClass) =>
                          missedClass.missedDay.isSameDate(thisDate))) ==
                      null) ||
          pupil.pupilMissedClasses!.isEmpty) &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.present] == false && toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }

  // Filter pupils not present
  if (activeFilters[PupilFilter.notPresent]! &&
      pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay.isSameDate(thisDate) &&
          (missedClass.missedType == 'missed' ||
              missedClass.missedType == 'home' ||
              missedClass.returned == true)) &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.notPresent] == false && toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }

  // Filter unexcused pupils
  if (activeFilters[PupilFilter.unexcused]! &&
      pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay.isSameDate(thisDate) &&
          missedClass.excused == true &&
          missedClass.missedType == 'missed' &&
          toList == true)) {
    return true;
  } else if (activeFilters[PupilFilter.unexcused] == false && toList == true) {
    return true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    return false;
  }
}
