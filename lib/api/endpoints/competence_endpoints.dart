import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';

class EndpointsCompetence {
  late final DioClient _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- fetch list of competences
  String fetchCompetencesUrl = '/competences/all/flat';
  Future<List<Competence>> fetchCompetences() async {
    notificationManager.isRunningValue(true);

    final response =
        await _client.get(EndpointsCompetence().fetchCompetencesUrl);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Failed to fetch competences');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to fetch competences', response.statusCode);
    }
    final competences =
        (response.data as List).map((e) => Competence.fromJson(e)).toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Kompetenzen geladen');
    notificationManager.isRunningValue(false);
    return competences;
  }

  //- post new competence
  String postNewCompetenceUrl = '/competences/new';
  Future<Competence> postNewCompetence(
      int? parentCompetence,
      String competenceName,
      String? competenceLevel,
      String? indicators) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({
      "parent_competence": parentCompetence,
      "competence_name": competenceName,
      "competence_level": competenceLevel == '' ? null : competenceLevel,
      "indicators": indicators == '' ? null : indicators
    });
    final Response response = await _client
        .post(EndpointsCompetence().postNewCompetenceUrl, data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Failed to post a competence');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to post a competence', response.statusCode);
    }
    final Competence newCompetence = Competence.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Kompetenz erstellt');
    notificationManager.isRunningValue(false);
    return newCompetence;
  }

  //- update competence property
  String patchCompetenceUrl(int competenceId) {
    return '/competences/$competenceId/patch';
  }

  Future<Competence> updateCompetenceProperty(
      int competenceId,
      String competenceName,
      String? competenceLevel,
      String? indicators) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({
      "competence_name": competenceName,
      "competence_level": competenceLevel,
      "indicators": indicators
    });
    final Response response = await _client.patch(
        EndpointsCompetence().patchCompetenceUrl(competenceId),
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Failed to patch a competence');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to patch a competence', response.statusCode);
    }
    final patchedCompetence = Competence.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Kompetenz aktualisiert');
    notificationManager.isRunningValue(false);
    return patchedCompetence;
  }

  //- this endpoint is not implemented
  String deleteCompetence(int id) {
    return '/competences/$id/delete';
  }

  //- all endpoints below are not implemented
  //- COMPETENCE CHECKS ------------------------------------------------

  //- GET

  String getCompetenceCheckFile(String fileId) {
    return '/competence_checks/$fileId';
  }

  //- POST

  String postCompetenceCheck(int pupilId) {
    return '/competence_checks/$pupilId/new';
  }

  String postCompetenceCheckFile(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId/file';
  }

  //- PATCH

  String patchCompetenceCheck(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId';
  }

  // String patchCompetenceCheckWithFile(String competenceCheckId) {
  //   return '/competence/check/$competenceCheckId';
  // }

  //- DELETE

  String deleteCompetenceCheck(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId';
  }

  String deleteCompetenceCheckFile(String fileId) {
    return '/competence_checks/$fileId';
  }

  //- COMPETENCE GOALS -------------------------------------------------

  //- POST
  String postCompetenceGoal(int pupilId) {
    return '/competence_goals/new/$pupilId';
  }

  //- PATCH
  String patchCompetenceGoal(String competenceGoalId) {
    return '/competence_goals/$competenceGoalId';
  }

  //- DELETE
  String deleteCompetenceGoal(String competenceGoalId) {
    return '/competence_goals/$competenceGoalId/delete';
  }
}
