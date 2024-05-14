import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import '../models/category/pupil_category_status.dart';

class GoalManager {
  ValueListenable<List<GoalCategory>> get goalCategories => _goalCategories;
  ValueListenable<bool> get isRunning => _isRunning;

  final _goalCategories = ValueNotifier<List<GoalCategory>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  GoalManager() {
    debug.warning('GoalManager initialized');
  }
  Future<GoalManager> init() async {
    await fetchGoalCategories();
    return this;
  }

  final client = locator.get<ApiManager>().dioClient.value;
  final snackBarManager = locator<NotificationManager>();
  Future fetchGoalCategories() async {
    snackBarManager.isRunningValue(true);
    try {
      final response =
          await client.get(EndpointsLearningSupport().fetchGoalCategoriesUrl);
      final goalCategories =
          (response.data as List).map((e) => GoalCategory.fromJson(e)).toList();
      snackBarManager.showSnackBar(
          NotificationType.success, 'Katgorien geladen');
      debug.success(
          'Fetched ${goalCategories.length} goal categories! | ${StackTrace.current}');
      _goalCategories.value = goalCategories;
      snackBarManager.isRunningValue(false);
      return;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      snackBarManager.showSnackBar(
          NotificationType.error, errorMessage.message);
      snackBarManager.isRunningValue(false);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
  }

  //- this function does not call the API
  List<PupilGoal> getPupilGoalsForCategory(int categoryId) {
    List<PupilGoal> goals = [];
    final List<PupilProxy> pupils = locator<PupilManager>().allPupils.value;
    for (PupilProxy pupil in pupils) {
      for (PupilGoal goal in pupil.pupilGoals!) {
        if (goal.goalCategoryId == categoryId) {
          goals.add(goal);
        }
      }
    }
    return goals;
  }

  Future postCategoryStatus(PupilProxy pupil, int goalCategoryId, String state,
      String comment) async {
    snackBarManager.isRunningValue(true);
    final data =
        jsonEncode({"state": state, "file_url": null, "comment": comment});
    try {
      final response = await client.post(
          EndpointsLearningSupport()
              .postCategoryStatusUrl(pupil.internalId, goalCategoryId),
          data: data);
      if (response.statusCode == 200) {
        locator<PupilManager>().updatePupilFromResponse(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      snackBarManager.showSnackBar(
          NotificationType.error, errorMessage.message);
      snackBarManager.isRunningValue(false);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    snackBarManager.isRunningValue(false);
    return;
  }

  Future patchCategoryStatus(PupilProxy pupil, String statusId, String? state,
      String? comment, String? createdBy, String? createdAt) async {
    snackBarManager.isRunningValue(true);
    final data = jsonEncode({
      if (state != null) "state": state,
      if (comment != null) "comment": comment,
      if (createdBy != null) "created_by": createdBy,
      if (createdAt != null) "created_at": createdAt
    });
    final response = await client.patch(
        EndpointsLearningSupport().patchCategoryStatusUrl(statusId),
        data: data);

    if (response.statusCode != 200) {
      //- TO-DO: Error handling
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      snackBarManager.isRunningValue(false);
    }
    snackBarManager.showSnackBar(
        NotificationType.success, 'Status aktualisiert');
    locator<PupilManager>().updatePupilFromResponse(response.data);
    snackBarManager.isRunningValue(false);
  }

  Future deleteCategoryStatus(String statusId) async {
    snackBarManager.isRunningValue(true);
    try {
      final response = await client
          .delete(EndpointsLearningSupport().deleteCategoryStatusUrl(statusId));
      if (response.statusCode == 200) {
        locator<PupilManager>().updatePupilFromResponse(response.data);
        snackBarManager.showSnackBar(
            NotificationType.success, 'Status gelöscht');
        snackBarManager.isRunningValue(false);
        return;
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      snackBarManager.showSnackBar(
          NotificationType.error, errorMessage.message);
      snackBarManager.isRunningValue(false);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
  }

  Future postNewCategoryGoal(int goalCategoryId, int pupilId,
      String description, String strategies) async {
    snackBarManager.isRunningValue(true);

    final data = jsonEncode({
      "goal_category_id": goalCategoryId,
      "created_at": DateTime.now().formatForJson(),
      "achieved": 0,
      "achieved_at": null,
      "description": description,
      "strategies": strategies
    });
    try {
      final response = await client
          .post(EndpointsLearningSupport().postGoalUrl(pupilId), data: data);
      if (response.statusCode == 200) {
        locator<PupilManager>().updatePupilFromResponse(response.data);
        snackBarManager.showSnackBar(
            NotificationType.success, 'Ziel hinzugefügt');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      snackBarManager.showSnackBar(
          NotificationType.error, errorMessage.message);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    snackBarManager.isRunningValue(false);
    return;
  }

  Future deleteGoal(String goalId) async {
    // final List<PupilProxy> pupils = locator<PupilManager>().pupils.value;
    // final PupilProxy pupil = pupils
    //     .where((element) =>
    //         element.pupilGoals!.any((element) => element.goalId == goalId))
    //     .single;
    snackBarManager.isRunningValue(true);

    try {
      final response =
          await client.delete(EndpointsLearningSupport().deleteGoalUrl(goalId));
      if (response.statusCode == 200) {
        locator<PupilManager>().updatePupilFromResponse(response.data);
        snackBarManager.showSnackBar(NotificationType.success, 'Ziel gelöscht');
        snackBarManager.isRunningValue(false);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      snackBarManager.showSnackBar(
          NotificationType.error, errorMessage.message);
      snackBarManager.isRunningValue(false);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
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
