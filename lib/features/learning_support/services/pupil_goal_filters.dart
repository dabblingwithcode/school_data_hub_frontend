import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

List<Pupil> categoryGoalFilteredPupils(List<Pupil> filteredPupils) {
  final Map<PupilFilter, bool> activeFilters =
      locator<PupilFilterManager>().filterState.value;
  bool toList = true;
  if (filteredPupils.isNotEmpty) {
    List<Pupil> categoryFilteredPupils = [];
    for (Pupil pupil in filteredPupils) {
      if (pupil.pupilGoals != null) {
        if (activeFilters[PupilFilter.supportAreaMotorics] == true &&
            pupil.pupilGoals!.any((element) =>
                locator<GoalManager>()
                    .getRootCategory(element.goalCategoryId)
                    .categoryId ==
                1) &&
            toList == true) {
          toList = true;
        } else if (activeFilters[PupilFilter.supportAreaMotorics] == false &&
            toList == true) {
          toList = true;
        } else {
          toList = false;
        }
      }
      if (activeFilters[PupilFilter.supportAreaEmotions] == true &&
          pupil.pupilGoals!.any((element) =>
              locator<GoalManager>()
                  .getRootCategory(element.goalCategoryId)
                  .categoryId ==
              2) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.supportAreaEmotions] == false &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (activeFilters[PupilFilter.supportAreaMath] == true &&
          pupil.pupilGoals!.any((element) =>
              locator<GoalManager>()
                  .getRootCategory(element.goalCategoryId)
                  .categoryId ==
              3) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.supportAreaMath] == false &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (activeFilters[PupilFilter.supportAreaLearning] == true &&
          pupil.pupilGoals!.any((element) =>
              locator<GoalManager>()
                  .getRootCategory(element.goalCategoryId)
                  .categoryId ==
              4) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.supportAreaLearning] == false &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (activeFilters[PupilFilter.supportAreaGerman] == true &&
          pupil.pupilGoals!.any((element) =>
              locator<GoalManager>()
                  .getRootCategory(element.goalCategoryId)
                  .categoryId ==
              5) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.supportAreaGerman] == false &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (activeFilters[PupilFilter.supportAreaLanguage] == true &&
          pupil.pupilGoals!.any((element) => element.goalCategoryId == 6) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.supportAreaLanguage] == false &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (toList == true) {
        categoryFilteredPupils.add(pupil);
      }
    }
    return categoryFilteredPupils;
  }
  return [];
}
