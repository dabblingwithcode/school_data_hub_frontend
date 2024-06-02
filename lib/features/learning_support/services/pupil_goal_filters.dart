import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

List<PupilProxy> categoryGoalFilteredPupils(List<PupilProxy> filteredPupils) {
  final Map<PupilFilter, bool> activeFilters =
      locator<PupilFilterManager>().filterState.value;

  if (filteredPupils.isNotEmpty) {
    List<PupilProxy> categoryFilteredPupils = [];
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.pupilGoals != null) {
        if ((activeFilters[PupilFilter.supportAreaMotorics] == true &&
                pupil.pupilGoals!.any((element) =>
                    locator<GoalManager>()
                        .getRootCategory(element.goalCategoryId)
                        .categoryId ==
                    1)) ||
            (activeFilters[PupilFilter.supportAreaMotorics] == false)) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }

        if (activeFilters[PupilFilter.supportAreaEmotions] == true &&
            pupil.pupilGoals!.any((element) =>
                locator<GoalManager>()
                    .getRootCategory(element.goalCategoryId)
                    .categoryId ==
                2)) {
        } else if (activeFilters[PupilFilter.supportAreaEmotions] == false) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[PupilFilter.supportAreaMath] == true &&
            pupil.pupilGoals!.any((element) =>
                locator<GoalManager>()
                    .getRootCategory(element.goalCategoryId)
                    .categoryId ==
                3)) {
        } else if (activeFilters[PupilFilter.supportAreaMath] == false) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[PupilFilter.supportAreaLearning] == true &&
            pupil.pupilGoals!.any((element) =>
                locator<GoalManager>()
                    .getRootCategory(element.goalCategoryId)
                    .categoryId ==
                4)) {
        } else if (activeFilters[PupilFilter.supportAreaLearning] == false) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[PupilFilter.supportAreaGerman] == true &&
            pupil.pupilGoals!.any((element) =>
                locator<GoalManager>()
                    .getRootCategory(element.goalCategoryId)
                    .categoryId ==
                5)) {
        } else if (activeFilters[PupilFilter.supportAreaGerman] == false) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[PupilFilter.supportAreaLanguage] == true &&
            pupil.pupilGoals!.any((element) => element.goalCategoryId == 6)) {
        } else if (activeFilters[PupilFilter.supportAreaLanguage] == false) {
        } else {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }

        categoryFilteredPupils.add(pupil);
      }
    }
    return categoryFilteredPupils;
  }
  return [];
}
