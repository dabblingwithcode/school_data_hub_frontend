import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class CompetenceManager {
  ValueListenable<List<Competence>> get competences => _competences;
  ValueListenable<bool> get isRunning => _isRunning;

  final _competences = ValueNotifier<List<Competence>>([]);
  final _isRunning = ValueNotifier<bool>(false);
  final client = locator.get<ApiManager>().dioClient.value;
  final snackBarManager = locator<NotificationManager>();
  CompetenceManager() {
    debug.warning('CompetenceManager initialized');
  }
  Future<CompetenceManager> init() async {
    await firstFetchCompetences();
    return this;
  }

  final notificationManager = locator<NotificationManager>();
  final apiCompetenceService = ApiCompetenceService();

  Future<void> firstFetchCompetences() async {
    final List<Competence> competences =
        await apiCompetenceService.fetchCompetences();

    _competences.value = competences;

    snackBarManager.showSnackBar(
        NotificationType.success, 'Kompetenzen geladen');

    return;
  }

  Future<void> fetchCompetences() async {
    final List<Competence> competences =
        await apiCompetenceService.fetchCompetences();

    _competences.value = competences;
    locator<CompetenceFilterManager>().refreshFilteredCompetences(competences);

    notificationManager.showSnackBar(
        NotificationType.success, 'Kompetenzen aktualisiert!');

    return;
  }

  Future<void> postNewCompetence(
    int? parentCompetence,
    String competenceName,
    String? competenceLevel,
    String? indicators,
  ) async {
    final Competence newCompetence =
        await apiCompetenceService.postNewCompetence(
            parentCompetence, competenceName, competenceLevel, indicators);

    _competences.value = [..._competences.value, newCompetence];
    locator<CompetenceFilterManager>()
        .refreshFilteredCompetences(_competences.value);

    snackBarManager.showSnackBar(
        NotificationType.success, 'Kompetenz erstellt');

    return;
  }

  Future<void> updateCompetenceProperty(
    int competenceId,
    String competenceName,
    String? competenceLevel,
    String? indicators,
  ) async {
    final Competence updatedCompetence =
        await apiCompetenceService.updateCompetenceProperty(
            competenceId, competenceName, competenceLevel, indicators);

    final List<Competence> competences = List.from(_competences.value);
    final index = competences
        .indexWhere((element) => element.competenceId == competenceId);
    competences[index] = updatedCompetence;

    _competences.value = competences;
    locator<CompetenceFilterManager>()
        .refreshFilteredCompetences(_competences.value);

    notificationManager.showSnackBar(
        NotificationType.success, 'Kompetenz aktualisiert');

    return;
  }

  //- hier werden keine API Calls gemacht, nur die Kompetenz aus der Liste geholt
  Competence getCompetence(int competenceId) {
    final Competence competence = _competences.value
        .firstWhere((element) => element.competenceId == competenceId);
    return competence;
  }
}
