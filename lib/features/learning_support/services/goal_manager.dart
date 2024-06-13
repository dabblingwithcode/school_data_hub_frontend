import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import '../models/category/pupil_category_status.dart';

class GoalManager {
  ValueListenable<List<GoalCategory>> get goalCategories => _goalCategories;
  ValueListenable<bool> get isRunning => _isRunning;

  final _goalCategories = ValueNotifier<List<GoalCategory>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  GoalManager() {
    logger.i('GoalManager constructor called');
  }
  Future<GoalManager> init() async {
    await fetchGoalCategories();
    return this;
  }

  final client = locator.get<ApiManager>().dioClient.value;

  final notificationManager = locator<NotificationManager>();

  final apiLearningSupportService = ApiLearningSupportService();

  Future<void> fetchGoalCategories() async {
    final List<GoalCategory> goalCategories =
        await apiLearningSupportService.fetchGoalCategories();

    _goalCategories.value = goalCategories;

    notificationManager.showSnackBar(NotificationType.success,
        '${goalCategories.length} Kategorien geladen');

    return;
  }

  //- this function does not call the API
  List<PupilGoal> getPupilGoalsForCategory(int categoryId) {
    List<PupilGoal> goals = [];
    final List<PupilProxy> pupils = locator<PupilManager>().allPupils;
    for (PupilProxy pupil in pupils) {
      for (PupilGoal goal in pupil.pupilGoals!) {
        if (goal.goalCategoryId == categoryId) {
          goals.add(goal);
        }
      }
    }
    return goals;
  }

  Future<void> postCategoryStatus(
    PupilProxy pupil,
    int goalCategoryId,
    String state,
    String comment,
  ) async {
    final PupilData responsePupil =
        await apiLearningSupportService.postCategoryStatus(
            pupilInternalId: pupil.internalId,
            goalCategoryId: goalCategoryId,
            state: state,
            comment: comment);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Status hinzugefügt');

    return;
  }

  Future<void> updateCategoryStatusProperty({
    required PupilProxy pupil,
    required String statusId,
    String? state,
    String? comment,
    String? createdBy,
    String? createdAt,
  }) async {
    final PupilData responsePupil =
        await apiLearningSupportService.updateCategoryStatusProperty(
            pupil, statusId, state, comment, createdBy, createdAt);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Status aktualisiert');

    return;
  }

  Future<void> deleteCategoryStatus(String statusId) async {
    final PupilData responsePupil =
        await apiLearningSupportService.deleteCategoryStatus(statusId);

    notificationManager.showSnackBar(
        NotificationType.success, 'Status gelöscht');

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);
    return;
  }

  Future postNewCategoryGoal(int goalCategoryId, int pupilId,
      String description, String strategies) async {
    final PupilData responsePupil = await apiLearningSupportService
        .postNewCategoryGoal(goalCategoryId, pupilId, description, strategies);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Ziel hinzugefügt');

    return;
  }

  Future deleteGoal(String goalId) async {
    final PupilData responsePupil =
        await apiLearningSupportService.deleteGoal(goalId);

    locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(NotificationType.success, 'Ziel gelöscht');

    return;
  }

  //- these functions do not call the API
  GoalCategory getGoalCategory(int categoryId) {
    final GoalCategory goalCategory = goalCategories.value
        .firstWhere((element) => element.categoryId == categoryId);
    return goalCategory;
  }

  GoalCategory getRootCategory(int categoryId) {
    GoalCategory goalCategory = _goalCategories.value
        .firstWhere((element) => element.categoryId == categoryId);
    if (goalCategory.parentCategory == null) {
      return goalCategory;
    } else {
      return getRootCategory(goalCategory.parentCategory!);
    }
  }

  Color getCategoryColor(int categoryId) {
    final GoalCategory rootCategory = getRootCategory(categoryId);
    return getRootCategoryColor(rootCategory)!;
  }

  Color? getRootCategoryColor(GoalCategory goalCategory) {
    if (goalCategory.categoryName == 'Körper, Wahrnehmung, Motorik') {
      return koerperWahrnehmungMotorikColor;
    } else if (goalCategory.categoryName == 'Sozialkompetenz / Emotionalität') {
      return sozialEmotionalColor;
    } else if (goalCategory.categoryName == 'Mathematik') {
      return mathematikColor;
    } else if (goalCategory.categoryName == 'Lernen und Leisten') {
      return lernenLeistenColor;
    } else if (goalCategory.categoryName == 'Deutsch') {
      return deutschColor;
    } else if (goalCategory.categoryName == 'Sprache und Sprechen') {
      return spracheSprechenColor;
    }
    return null;
  }

  Widget getCategoryStatusSymbol(
      PupilProxy pupil, int goalCategoryId, String statusId) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus categoryStatus = pupil.pupilCategoryStatuses!
          .firstWhere((element) =>
              element.goalCategoryId == goalCategoryId &&
              element.statusId == statusId);

      switch (categoryStatus.state) {
        case 'none':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_1-4.png'));
        case 'green':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_4-4.png'));
        case 'yellow':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_3-4.png'));
        // case 'orange':
        //   return Colors.orange;
        case 'red':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_2-4.png'));
      }
      return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
    }

    return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
  }

  Widget getLastCategoryStatusSymbol(PupilProxy pupil, int goalCategoryId) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus? categoryStatus = pupil.pupilCategoryStatuses!
          .lastWhereOrNull(
              (element) => element.goalCategoryId == goalCategoryId);

      if (categoryStatus != null) {
        switch (categoryStatus.state) {
          case 'none':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_1-4.png'));
          case 'green':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_4-4.png'));
          case 'yellow':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_3-4.png'));
          // case 'orange':
          //   return Colors.orange;
          case 'red':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_2-4.png'));
        }
      }
      return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
    }

    return SizedBox(width: 40, child: Image.asset('assets/growth_1-4.png'));
  }
}
