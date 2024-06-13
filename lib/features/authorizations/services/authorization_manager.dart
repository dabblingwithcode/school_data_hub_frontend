import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

import 'package:schuldaten_hub/common/services/locator.dart';

class AuthorizationManager {
  ValueListenable<List<Authorization>> get authorizations => _authorizations;

  final _authorizations = ValueNotifier<List<Authorization>>([]);
  Map<String, Authorization> _authorizationsMap = {};

  AuthorizationManager() {
    logger.i('AuthorizationManager constructor called');
  }

  Future<AuthorizationManager> init() async {
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen werden geladen');
    await fetchAuthorizations();
    return this;
  }

  final notificationManager = locator<NotificationManager>();
  final apiAuthorizationService = ApiAuthorizationService();

  Future<void> fetchAuthorizations() async {
    final authorizations = await apiAuthorizationService.fetchAuthorizations();

    notificationManager.showSnackBar(NotificationType.success,
        '${authorizations.length} Einwilligungen geladen');

    _authorizations.value = authorizations;
    _authorizationsMap = {
      for (var authorization in authorizations)
        authorization.authorizationId: authorization
    };
    return;
  }

  Future<void> postAuthorizationWithPupils(
    String name,
    String description,
    List<int> pupilIds,
  ) async {
    final Authorization authorization = await apiAuthorizationService
        .postAuthorizationWithPupils(name, description, pupilIds);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');

    return;
  }

  Future<void> postPupilAuthorization(int pupilId, String authId) async {
    final Authorization authorization =
        await apiAuthorizationService.postPupilAuthorization(pupilId, authId);
    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    return;
  }

  // Add pupils to an existing authorization
  Future<void> postPupilAuthorizations(
    List<int> pupilIds,
    String authId,
  ) async {
    final Authorization authorization =
        await apiAuthorizationService.postPupilAuthorizations(pupilIds, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen erstellt');
    return;
  }

  Future<void> deletePupilAuthorization(
    int pupilId,
    String authId,
  ) async {
    final Authorization authorization =
        await apiAuthorizationService.deletePupilAuthorization(pupilId, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');
    return;
  }

  Future<void> updatePupilAuthorizationProperty(
      int pupilId, String listId, bool? value, String? comment) async {
    final Authorization authorization = await apiAuthorizationService
        .updatePupilAuthorizationProperty(pupilId, listId, value, comment);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');

    return;
  }

  Future<void> postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    final Authorization authorization = await apiAuthorizationService
        .postAuthorizationFile(file, pupilId, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Datei hochgeladen');

    return;
  }

  Future<void> deleteAuthorizationFile(
    int pupilId,
    String authId,
    String cacheKey,
  ) async {
    final Authorization responsePupil = await apiAuthorizationService
        .deleteAuthorizationFile(pupilId, authId, cacheKey);

    _authorizationsMap[responsePupil.authorizationId] = responsePupil;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungsdatei gelöscht');

    return;
  }

  //- diese Funktion hat keinen API-Call
  Authorization getAuthorization(
    String authId,
  ) {
    final Authorization authorizations = _authorizations.value
        .where((element) => element.authorizationId == authId)
        .first;

    return authorizations;
  }

  //- diese Funktion hat keinen API-Call
  // PupilAuthorization getPupilAuthorization(
  //   int pupilId,
  //   String authId,
  // ) {

  //   final PupilAuthorization pupilAuthorization = locator<AuthorizationManager>().
  //       .where((element) => element.originAuthorization == authId)
  //       .first;

  //   return pupilAuthorization;
  // }

  //- diese Funktion hat keinen API-Call
  // List<PupilProxy> getPupilsInAuthorization(
  //   String authorizationId,
  // ) {
  //   final List<PupilProxy> listedPupils = locator<PupilManager>()
  //       .allPupils
  //       .where((pupil) => pupil.authorizations!.any((authorization) =>
  //           authorization.originAuthorization == authorizationId))
  //       .toList();

  //   return listedPupils;
  // }

  //- diese Funktion hat keinen API-Call
  List<PupilProxy> getListedPupilsInAuthorization(
    String authorizationId,
    List<PupilProxy> filteredPupils,
  ) {
    final Authorization authorization = _authorizationsMap[authorizationId]!;
    final List<PupilProxy> listedPupils = filteredPupils
        .where((pupil) => authorization.authorizedPupils.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();

    return listedPupils;
  }
}
