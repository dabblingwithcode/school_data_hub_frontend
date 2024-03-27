import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';

bool learningSupportFilter(Pupil pupil, bool toList) {
  final activeFilters = locator<PupilFilterManager>().filterState.value;
  if (activeFilters[PupilFilter.developmentPlan1]! &&
      pupil.individualDevelopmentPlan == 1 &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.developmentPlan1] == false &&
      toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }
  // Filter development plan 2
  if (activeFilters[PupilFilter.developmentPlan2]! &&
      pupil.individualDevelopmentPlan == 2 &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.developmentPlan2] == false &&
      toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }
  // Filter development plan 3
  if (activeFilters[PupilFilter.developmentPlan3]! &&
      pupil.individualDevelopmentPlan == 3 &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.developmentPlan3] == false &&
      toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }
  // Filter special needs
  if (activeFilters[PupilFilter.specialNeeds]! &&
      pupil.specialNeeds != null &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.specialNeeds] == false &&
      toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }
  // Filter pupils with a development goal

  //- Learning filters -//

  // Filter migrationSupport
  if (activeFilters[PupilFilter.migrationSupport]! &&
      hasLanguageSupport(pupil.migrationSupportEnds) == true &&
      toList == true) {
    toList = true;
  } else if (activeFilters[PupilFilter.migrationSupport] == false &&
      toList == true) {
    toList = true;
  } else {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    toList = false;
  }
  return toList;
}
