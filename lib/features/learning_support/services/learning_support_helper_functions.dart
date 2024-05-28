import 'package:collection/collection.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

//- overview numbers functions
int developmentPlan1Pupils(List<PupilProxy> filteredPupils) {
  List<PupilProxy> developmentPlan1Pupils = [];
  if (filteredPupils.isNotEmpty) {
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.individualDevelopmentPlan == 1) {
        developmentPlan1Pupils.add(pupil);
      }
    }
    return developmentPlan1Pupils.length;
  }
  return 0;
}

int developmentPlan2Pupils(List<PupilProxy> filteredPupils) {
  List<PupilProxy> developmentPlan1Pupils = [];
  if (filteredPupils.isNotEmpty) {
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.individualDevelopmentPlan == 2) {
        developmentPlan1Pupils.add(pupil);
      }
    }
    return developmentPlan1Pupils.length;
  }
  return 0;
}

int developmentPlan3Pupils(List<PupilProxy> filteredPupils) {
  List<PupilProxy> developmentPlan1Pupils = [];
  if (filteredPupils.isNotEmpty) {
    for (PupilProxy pupil in filteredPupils) {
      if (pupil.individualDevelopmentPlan == 3) {
        developmentPlan1Pupils.add(pupil);
      }
    }
    return developmentPlan1Pupils.length;
  }
  return 0;
}

String preschoolRevision(int value) {
  switch (value) {
    case 0:
      return 'nicht da';
    case 1:
      return 'unauffällig';
    case 2:
      return 'Förderbedarf';
    case 3:
      return 'AO-SF';
    default:
      return 'keine';
  }
}

List<PupilGoal> getGoalsForCategory(PupilProxy pupil, int categoryId) {
  List<PupilGoal> goals = [];
  if (pupil.pupilGoals != null) {
    for (PupilGoal goal in pupil.pupilGoals!) {
      if (goal.goalCategoryId == categoryId) {
        goals.add(goal);
      }
      return goals;
    }
  }
  return [];
}

PupilCategoryStatus? getCategoryStatus(PupilProxy pupil, int goalCategoryId) {
  if (pupil.pupilCategoryStatuses != null) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus? categoryStatus = pupil.pupilCategoryStatuses!
          .lastWhereOrNull(
              (element) => element.goalCategoryId == goalCategoryId);
      return categoryStatus;
    }
  }
  return null;
}

PupilGoal? getGoalForCategory(PupilProxy pupil, int goalCategoryId) {
  if (pupil.pupilGoals != null) {
    if (pupil.pupilGoals!.isNotEmpty) {
      final PupilGoal? goal = pupil.pupilGoals!.lastWhereOrNull(
          (element) => element.goalCategoryId == goalCategoryId);
      return goal;
    }
    return null;
  }
  return null;
}

bool isAuthorizedToChangeStatus(PupilCategoryStatus status) {
  if (locator<SessionManager>().isAdmin.value == true ||
      status.createdBy ==
          locator<SessionManager>().credentials.value.username) {
    return true;
  }
  return false;
}
