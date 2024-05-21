import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

class AuthorizationManager {
  ValueListenable<List<Authorization>> get authorizations => _authorizations;

  final _authorizations = ValueNotifier<List<Authorization>>([]);
  final client = locator.get<ApiManager>().dioClient.value;
  AuthorizationManager() {
    debug.warning('AuthorizationManager initialized');
  }

  Future<AuthorizationManager> init() async {
    await fetchAuthorizations();
    return this;
  }

  final notificationManager = locator<NotificationManager>();
  final apiAuthorizationService = ApiAuthorizationService();

  Future<void> fetchAuthorizations() async {
    final authorizations = await apiAuthorizationService.fetchAuthorizations();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen geladen');

    _authorizations.value = authorizations;
    return;
  }

  Future<void> postAuthorizationWithPupils(
    String name,
    String description,
    List<int> pupilIds,
  ) async {
    final List<Pupil> responsePupils = await apiAuthorizationService
        .postAuthorizationWithPupils(name, description, pupilIds);

    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    }

    fetchAuthorizations();

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');

    return;
  }

  Future<void> postPupilAuthorization(int pupilId, String authId) async {
    final Pupil updatedPupilWithPupilAuthorization =
        await apiAuthorizationService.postPupilAuthorization(pupilId, authId);

    locator<PupilManager>()
        .updatePupilProxyWithPupil(updatedPupilWithPupilAuthorization);

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    return;
  }

  // Add pupils to an existing authorization
  Future<void> postPupilAuthorizations(
    List<int> pupilIds,
    String authId,
  ) async {
    final List<Pupil> responsePupils =
        await apiAuthorizationService.postPupilAuthorizations(pupilIds, authId);

    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    }

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen erstellt');

    return;
  }

  Future<void> deletePupilAuthorization(
    int pupilId,
    String authId,
  ) async {
    final Pupil responsePupil =
        await apiAuthorizationService.deletePupilAuthorization(pupilId, authId);

    locator<PupilManager>().updatePupilProxyWithPupil(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');
    return;
  }

  Future<void> updatePupilAuthorizationProperty(
      int pupilId, String listId, bool? value, String? comment) async {
    final Pupil responsePupil = await apiAuthorizationService
        .updatePupilAuthorizationProperty(pupilId, listId, value, comment);

    locator<PupilManager>().updatePupilProxyWithPupil(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');

    return;
  }

  Future<void> postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    final Pupil responsePupil = await apiAuthorizationService
        .postAuthorizationFile(file, pupilId, authId);

    locator<PupilManager>().updatePupilProxyWithPupil(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Datei hochgeladen');

    return;
  }

  Future<void> deleteAuthorizationFile(
    int pupilId,
    String authId,
    String cacheKey,
  ) async {
    final Pupil responsePupil = await apiAuthorizationService
        .deleteAuthorizationFile(pupilId, authId, cacheKey);

    locator<PupilManager>().updatePupilProxyWithPupil(responsePupil);

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
  PupilAuthorization getPupilAuthorization(
    int pupilId,
    String authId,
  ) {
    final PupilProxy pupil = locator<PupilManager>()
        .allPupils
        .where((element) => element.internalId == pupilId)
        .first;

    final PupilAuthorization pupilAuthorization = pupil.authorizations!
        .where((element) => element.originAuthorization == authId)
        .first;

    return pupilAuthorization;
  }

  //- diese Funktion hat keinen API-Call
  List<PupilProxy> getPupilsInAuthorization(
    String authorizationId,
  ) {
    final List<PupilProxy> listedPupils = locator<PupilManager>()
        .allPupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();

    return listedPupils;
  }

  //- diese Funktion hat keinen API-Call
  List<PupilProxy> getListedPupilsInAuthorization(
    String authorizationId,
    List<PupilProxy> filteredPupils,
  ) {
    final List<PupilProxy> listedPupils = filteredPupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();

    return listedPupils;
  }
}
