import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class ApiLearningSupportService {
  late final DioClient _client = locator<ApiManager>().dioClient.value;

  final notificationManager = locator<NotificationManager>();

  //- GOAL CATEGORIES --------------------------------------------------

  //- fetch goal categories
  static const String _fetchGoalCategoriesUrl = '/goal_categories/all/flat';

  Future<List<GoalCategory>> fetchGoalCategories() async {
    notificationManager.isRunningValue(true);

    final response = await _client.get(_fetchGoalCategoriesUrl);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Kategorien');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to fetch goal categories', response.statusCode);
    }

    final List<GoalCategory> goalCategories =
        (response.data as List).map((e) => GoalCategory.fromJson(e)).toList();

    notificationManager.isRunningValue(false);

    return goalCategories;
  }

  //- this endpoint is not used in the app
  static const String fetchGoalCategoriesWithChildren = '/goal_categories/all';

  //- STATUSES ---------------------------------------------------------

  String _postCategoryStatusUrl(int pupilId, int categoryId) {
    return '/category/statuses/$pupilId/$categoryId';
  }

  Future<Pupil> postCategoryStatus(
    int pupilInternalId,
    int goalCategoryId,
    String state,
    String comment,
  ) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      "state": state,
      "file_url": null,
      "comment": comment,
    });

    final response = await _client.post(
        _postCategoryStatusUrl(pupilInternalId, goalCategoryId),
        data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Posten des Status');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to post category status', response.statusCode);
    }
    final Pupil pupil = Pupil.fromJson(response.data);

    notificationManager.showSnackBar(
        NotificationType.success, 'Status erfolgreich gepostet');
    notificationManager.isRunningValue(false);

    return pupil;
  }

  //- update category status
  String _patchCategoryStatusUrl(String categoryStatusId) {
    return '/category/statuses/$categoryStatusId';
  }

  Future<Pupil> updateCategoryStatusProperty(
      PupilProxy pupil,
      String statusId,
      String? state,
      String? comment,
      String? createdBy,
      String? createdAt) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      if (state != null) "state": state,
      if (comment != null) "comment": comment,
      if (createdBy != null) "created_by": createdBy,
      if (createdAt != null) "created_at": createdAt
    });

    final response =
        await _client.patch(_patchCategoryStatusUrl(statusId), data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren des Status');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to update category status', response.statusCode);
    }

    final Pupil pupil = Pupil.fromJson(response.data);

    notificationManager.isRunningValue(false);

    return pupil;
  }

  String postFileForCategoryStatus(String categoryStatusId) {
    return '/category/statuses/$categoryStatusId/file';
  }

  String _deleteCategoryStatusUrl(String categoryStatusId) {
    return '/pupil/category/statuses/$categoryStatusId/delete';
  }

  Future deleteCategoryStatus(String statusId) async {
    notificationManager.isRunningValue(true);

    final response = await _client.delete(_deleteCategoryStatusUrl(statusId));

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Status');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to delete category status', response.statusCode);
    }

    final Pupil pupil = Pupil.fromJson(response.data);

    notificationManager.isRunningValue(false);

    return pupil;
  }

  //- GOALS ------------------------------------------------------------

  //- post category goal

  String _postGoalUrl(int pupilId) {
    return '/category_goals/$pupilId/new';
  }

  Future<Pupil> postNewCategoryGoal(int goalCategoryId, int pupilId,
      String description, String strategies) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      "goal_category_id": goalCategoryId,
      "created_at": DateTime.now().formatForJson(),
      "achieved": 0,
      "achieved_at": null,
      "description": description,
      "strategies": strategies
    });

    final Response response =
        await _client.post(_postGoalUrl(pupilId), data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Hinzufügen des Ziels');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to post category goal', response.statusCode);
    }

    final Pupil pupil = Pupil.fromJson(response.data);

    notificationManager.isRunningValue(false);

    return pupil;
  }

  //- delete category goal

  String _deleteGoalUrl(String goalId) {
    return '/category_goals/$goalId/delete';
  }

  Future deleteGoal(String goalId) async {
    notificationManager.isRunningValue(true);

    final Response response = await _client.delete(_deleteGoalUrl(goalId));

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Ziels');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to delete category goal', response.statusCode);
    }

    final Pupil pupil = Pupil.fromJson(response.data);

    notificationManager.isRunningValue(false);

    return pupil;
  }

  //- NOT IMPLEMENTED ------------------------------------------------------

  String patchgoal(String goalId) {
    return '/category_goals/$goalId';
  }

  String postGoalCheck(int id) {
    return '/category_goals/$id/check/new';
  }

  String patchGoalCheck(int goalId, String checkId) {
    return '/category_goals/$goalId/check/$checkId';
  }
}
