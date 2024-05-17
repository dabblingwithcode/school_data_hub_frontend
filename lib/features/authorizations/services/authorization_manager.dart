import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
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

  final snackBarManager = locator<NotificationManager>();

  Future fetchAuthorizations() async {
    snackBarManager.isRunningValue(true);
    try {
      final response =
          await client.get(EndpointsAuthorization.getAuthorizationsUrl);
      final authorizations = (response.data as List)
          .map((e) => Authorization.fromJson(e))
          .toList();
      snackBarManager.showSnackBar(
          NotificationType.success, 'Einwilligungen geladen');
      _authorizations.value = authorizations;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      snackBarManager.showSnackBar(NotificationType.error, errorMessage);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
      snackBarManager.isRunningValue(false);
      rethrow;
    }
    snackBarManager.isRunningValue(false);
    return;
  }

  Future postAuthorizationWithPupils(
      String name, String description, List<int> pupilIds) async {
    snackBarManager.isRunningValue(true);
    final data = jsonEncode({
      "authorization_description": description,
      "authorization_name": name,
      "pupils": pupilIds
    });
    final Response response = await client.post(
        EndpointsAuthorization.postAuthorizationWithPupilsFromListUrl,
        data: data);
    if (response.statusCode != 200) {
      //handle errors...
      debug.error(
          'Dio error: ${response.statusCode} ${response.toString()} | ${StackTrace.current}');
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      snackBarManager.isRunningValue(false);
      return;
    }
    final List<Pupil> responsePupils = (List<Pupil>.from(
        (response.data as List).map((e) => Pupil.fromJson(e))));
    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    }

    fetchAuthorizations();
    snackBarManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    snackBarManager.isRunningValue(false);
    return;
  }

  Future postPupilAuthorization(int pupilId, String authId) async {
    snackBarManager.isRunningValue(true);
    final data =
        jsonEncode({"comment": null, "file_url": null, "status": null});
    final response = await client.post(
        EndpointsAuthorization().postPupilAuthorizationUrl(pupilId, authId),
        data: data);
    if (response.statusCode != 200) {
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      debug.error(
          'Dio error: ${response.statusCode} ${response.toString()} | ${StackTrace.current}');
      snackBarManager.isRunningValue(false);
      return;
    }
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(response.data));
    snackBarManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    debug.success('list entry successful');

    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(pupilResponse));
    snackBarManager.isRunningValue(false);
  }

  Future postPupilAuthorizations(List<int> pupilIds, String authId) async {
    snackBarManager.isRunningValue(true);
    final data = jsonEncode({"pupils": pupilIds});
    final response = await client.post(
        EndpointsAuthorization().postPupilAuthorizationsUrl(authId),
        data: data);
    if (response.statusCode != 200) {
      //handle errors...
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      debug.error(
          'Dio error: ${response.statusCode} ${response.toString()} | ${StackTrace.current}');
      snackBarManager.isRunningValue(false);
      return;
    }
    final List<Pupil> responsePupils = (List<Pupil>.from(
        (response.data as List).map((e) => Pupil.fromJson(e))));
    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
      snackBarManager.showSnackBar(
          NotificationType.success, 'Einwilligungen erstellt');
    }
  }

  Future deletePupilAuthorization(int pupilId, String authId) async {
    snackBarManager.isRunningValue(true);
    final response = await client.delete(
        EndpointsAuthorization().deletePupilAuthorizationUrl(pupilId, authId));
    if (response.statusCode != 200) {
      //handle errors...
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      debug.error(
          'Dio error: ${response.statusCode} ${response.toString()} | ${StackTrace.current}');
      snackBarManager.isRunningValue(false);
      return;
    }
    final pupil = Pupil.fromJson(response.data);
    locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    snackBarManager.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');
    snackBarManager.isRunningValue(false);
  }

  Future patchPupilAuthorization(
      int pupilId, String listId, bool? value, String? comment) async {
    snackBarManager.isRunningValue(true);
    String data = '';
    if (value == null) {
      data = jsonEncode({"comment": comment});
    } else if (comment == null) {
      data = jsonEncode({"status": value});
    } else {
      data = jsonEncode({"comment": comment, "status": value});
    }

    final response = await client.patch(
        EndpointsAuthorization().patchPupilAuthorizationUrl(pupilId, listId),
        data: data);
    if (response.statusCode != 200) {
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      debug.error(
          'Dio error: ${response.statusCode} ${response.toString()} | ${StackTrace.current}');
      snackBarManager.isRunningValue(false);
      return;
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(pupilResponse));
    snackBarManager.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');
    snackBarManager.isRunningValue(false);
  }

  Future postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    snackBarManager.isRunningValue(true);
    final encryptedFile = await customEncrypter.encryptFile(file);
    String fileName = encryptedFile.path.split('/').last;
    final Response response = await client.patch(
      EndpointsAuthorization()
          .patchPupilAuthorizationWithFileUrl(pupilId, authId),
      data: FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(encryptedFile.path,
              filename: fileName),
        },
      ),
    );
    if (response.statusCode != 200) {
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(pupilResponse));
    snackBarManager.showSnackBar(NotificationType.success, 'Datei hochgeladen');
  }

  Future deleteAuthorizationFile(
      int pupilId, String authId, String cacheKey) async {
    snackBarManager.isRunningValue(true);
    final Response response = await client.delete(EndpointsAuthorization()
        .deletePupilAuthorizationFileUrl(pupilId, authId));
    if (response.statusCode != 200) {
      snackBarManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // First we delete the cached image
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // Then we patch the pupil with the data
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(pupilResponse));
    snackBarManager.showSnackBar(NotificationType.success, 'Datei gelöscht');
    snackBarManager.isRunningValue(false);
  }

  Authorization getAuthorization(String authId) {
    final Authorization authorizations = _authorizations.value
        .where((element) => element.authorizationId == authId)
        .first;
    return authorizations;
  }

  //- diese Funktionen haben keinen API-Call
  PupilAuthorization getPupilAuthorization(int pupilId, String authId) {
    final PupilProxy pupil = locator<PupilManager>()
        .allPupils
        .where((element) => element.internalId == pupilId)
        .first;
    final PupilAuthorization pupilAuthorization = pupil.authorizations!
        .where((element) => element.originAuthorization == authId)
        .first;
    return pupilAuthorization;
  }

  List<PupilProxy> getPupilsInAuthorization(String authorizationId) {
    final List<PupilProxy> listedPupils = locator<PupilManager>()
        .allPupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();
    return listedPupils;
  }

  List<PupilProxy> getListedPupilsInAuthorization(
      String authorizationId, List<PupilProxy> filteredPupils) {
    final List<PupilProxy> listedPupils = filteredPupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();
    return listedPupils;
  }
}
