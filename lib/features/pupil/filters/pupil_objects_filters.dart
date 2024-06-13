import 'package:collection/collection.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

bool attendanceFilters(PupilProxy pupil) {
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
      pupil.pupilMissedClasses!.isEmpty)) {
  } else if (activeFilters[PupilFilter.present] == false) {
  } else {
    return false;
  }

  // Filter pupils not present
  if (activeFilters[PupilFilter.notPresent]! &&
      pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay.isSameDate(thisDate) &&
          (missedClass.missedType == 'missed' ||
              missedClass.missedType == 'home' ||
              missedClass.backHome == true))) {
  } else if (activeFilters[PupilFilter.notPresent] == false) {
  } else {
    locator<PupilsFilter>().setFiltersOnValue(true);
    return false;
  }

  // Filter unexcused pupils
  if (activeFilters[PupilFilter.unexcused]! &&
      pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay.isSameDate(thisDate) &&
          missedClass.excused == true &&
          missedClass.missedType == 'missed')) {
  } else if (activeFilters[PupilFilter.unexcused] == false) {
  } else {
    locator<PupilsFilter>().setFiltersOnValue(true);
    return false;
  }

  // Filter OGS pupils
  if (activeFilters[PupilFilter.ogs]! && pupil.ogs == true) {
  } else if (activeFilters[PupilFilter.ogs] == false) {
  } else {
    locator<PupilsFilter>().setFiltersOnValue(true);
    return false;
  }

  if (activeFilters[PupilFilter.notOgs]! && pupil.ogs == false) {
  } else if (activeFilters[PupilFilter.notOgs] == false) {
  } else {
    locator<PupilsFilter>().setFiltersOnValue(true);
    return false;
  }
  return true;
}
