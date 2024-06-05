import 'package:collection/collection.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

List<PupilProxy> attendanceFilters(List<PupilProxy> pupils) {
  final thisDate = locator<SchooldayManager>().thisDate.value;
  final activeFilters = locator<PupilFilterManager>().filterState.value;
  List<PupilProxy> filteredPupils = [];
  // Filter pupils present
  for (final PupilProxy pupil in pupils) {
    bool toList = true;
    // Filter pupils present
    if ((activeFilters[PupilFilter.present]! &&
            pupil.pupilMissedClasses!.any((missedClass) =>
                missedClass.missedDay.isSameDate(thisDate) &&
                    missedClass.missedType == 'late' ||
                (pupil.pupilMissedClasses!.firstWhereOrNull((missedClass) =>
                        missedClass.missedDay.isSameDate(thisDate))) ==
                    null) ||
        pupil.pupilMissedClasses!.isEmpty)) {
      toList = true;
    } else if (activeFilters[PupilFilter.present] == false && toList == true) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }

    // Filter pupils not present
    if (activeFilters[PupilFilter.notPresent]! &&
        pupil.pupilMissedClasses!.any((missedClass) =>
            missedClass.missedDay.isSameDate(thisDate) &&
            (missedClass.missedType == 'missed' ||
                missedClass.missedType == 'home' ||
                missedClass.backHome == true)) &&
        toList == true) {
      toList = true;
    } else if (activeFilters[PupilFilter.notPresent] == false &&
        toList == true) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }

    // Filter unexcused pupils
    if (activeFilters[PupilFilter.unexcused]! &&
        pupil.pupilMissedClasses!.any((missedClass) =>
            missedClass.missedDay.isSameDate(thisDate) &&
            missedClass.excused == true &&
            missedClass.missedType == 'missed' &&
            toList == true)) {
      toList = true;
    } else if (activeFilters[PupilFilter.unexcused] == false &&
        toList == true) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }

    // Filter OGS pupils
    if (activeFilters[PupilFilter.ogs]! && pupil.ogs == true) {
      toList = true;
    } else if (activeFilters[PupilFilter.ogs] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }

    if (activeFilters[PupilFilter.notOgs]! && pupil.ogs == false) {
      toList = true;
    } else if (activeFilters[PupilFilter.notOgs] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    filteredPupils.add(pupil);
  }
  return filteredPupils;
}
