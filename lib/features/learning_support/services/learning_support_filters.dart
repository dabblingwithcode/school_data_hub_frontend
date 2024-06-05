import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';

List<PupilProxy> learningSupportFilter(List<PupilProxy> pupils) {
  final activeFilters = locator<PupilFilterManager>().filterState.value;
  bool toList = true;
  List<PupilProxy> filteredPupils = [];
  for (PupilProxy pupil in pupils) {
    if (activeFilters[PupilFilter.developmentPlan1]! &&
        pupil.individualDevelopmentPlan == 1) {
      toList = true;
    } else if (activeFilters[PupilFilter.developmentPlan1] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    // Filter development plan 2
    if (activeFilters[PupilFilter.developmentPlan2]! &&
        pupil.individualDevelopmentPlan == 2) {
      toList = true;
    } else if (activeFilters[PupilFilter.developmentPlan2] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    // Filter development plan 3
    if (activeFilters[PupilFilter.developmentPlan3]! &&
        pupil.individualDevelopmentPlan == 3) {
      toList = true;
    } else if (activeFilters[PupilFilter.developmentPlan3] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    // Filter special needs
    if (activeFilters[PupilFilter.specialNeeds]! &&
        pupil.specialNeeds != null) {
      toList = true;
    } else if (activeFilters[PupilFilter.specialNeeds] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    // Filter pupils with a development goal

    //- Learning filters -//

    // Filter migrationSupport
    if (activeFilters[PupilFilter.migrationSupport]! &&
        hasLanguageSupport(pupil.migrationSupportEnds) == true) {
      toList = true;
    } else if (activeFilters[PupilFilter.migrationSupport] == false) {
      toList = true;
    } else {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    filteredPupils.add(pupil);
  }
  return filteredPupils;
}
