part of '../endpoints.dart';

class EndpointsLearningSupport {
  //- GOAL CATEGORIES --------------------------------------------------

  String fetchGoalCategoriesWithChildren = '/goal_categories/all';
  String fetchGoalCategories = '/goal_categories/all/flat';

  //- STATUSES ---------------------------------------------------------

  String postCategoryStatus(int pupilId, int categoryId) {
    return '/category/statuses/$pupilId/$categoryId';
  }

  String patchCategoryStatus(String categoryStatusId) {
    return '/category/statuses/$categoryStatusId';
  }

  String postFileForCategoryStatus(String categoryStatusId) {
    return '/category/statuses/$categoryStatusId/file';
  }

  String deleteCategoryStatus(String categoryStatusId) {
    return '/pupil/category/statuses/$categoryStatusId/delete';
  }

  //- GOALS ------------------------------------------------------------

  //-POST

  String postGoal(int pupilId) {
    return '/category_goals/$pupilId/new';
  }

  //- PATCH

  String patchgoal(String goalId) {
    return '/categor_goals/$goalId';
  }

  //- DELETE

  String deleteGoal(String goalId) {
    return '/category_goals/$goalId/delete';
  }

  //- GOAL CHECKS ------------------------------------------------------

  String postGoalCheck(int id) {
    return '/category_goals/$id/check/new';
  }

  String patchGoalCheck(int goalId, String checkId) {
    return '/category_goals/$goalId/check/$checkId';
  }
}
