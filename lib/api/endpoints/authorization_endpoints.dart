import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class EndpointsAuthorization {
  final _client = locator.get<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- AUTHORIZATIONS -------------------------------------------

  //- getAuthorizations
  static const String getAuthorizationsUrl = '/authorizations/all';
  Future<List<Authorization>> fetchAuthorizations() async {
    notificationManager.isRunningValue(true);
    final Response response =
        await _client.get(EndpointsAuthorization.getAuthorizationsUrl);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Einwilligungen konnten nicht geladen werden');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to delete admonition', response.statusCode);
    }
    final authorizations =
        (response.data as List).map((e) => Authorization.fromJson(e)).toList();
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen geladen');
    notificationManager.isRunningValue(false);
    return authorizations;
  }

  //- post authorization with a list of pupils as members
  static const String postAuthorizationWithPupilsFromListUrl =
      '/authorizations/new/list';
  Future<List<Pupil>> postAuthorizationWithPupils(
      String name, String description, List<int> pupilIds) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({
      "authorization_description": description,
      "authorization_name": name,
      "pupils": pupilIds
    });
    final Response response = await _client.post(
        EndpointsAuthorization.postAuthorizationWithPupilsFromListUrl,
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Einwilligungen konnten nicht erstellt werden');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to post authorization', response.statusCode);
    }
    final List<Pupil> responsePupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    notificationManager.isRunningValue(false);
    return responsePupils;
  }

  //-PUPIL AUTHORIZATIONS -------------------------------------------

  //- add pupil to authorization
  // generates an association between a pupil and an authorization
  // through the object pupil authorization
  String postPupilAuthorizationUrl(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/new';
  }

  Future postPupilAuthorization(int pupilId, String authId) async {
    notificationManager.isRunningValue(true);
    final data =
        jsonEncode({"comment": null, "file_url": null, "status": null});
    final response = await _client.post(
        EndpointsAuthorization().postPupilAuthorizationUrl(pupilId, authId),
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to post pupil authorization', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    notificationManager.isRunningValue(false);
    return pupilResponse;
  }

  //- post pupil authorizations with list of pupils as members of an authorization
  String postPupilAuthorizationsUrl(String authorizationId) {
    return '/pupil_authorizations/$authorizationId/list';
  }

  Future<List<Pupil>> postPupilAuthorizations(
      List<int> pupilIds, String authId) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({"pupils": pupilIds});
    final response = await _client.post(
        EndpointsAuthorization().postPupilAuthorizationsUrl(authId),
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Es konnten keine Einwilligungen erstellt werden');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to post pupil authorizations', response.statusCode);
    }
    final List<Pupil> responsePupils = (List<Pupil>.from(
        (response.data as List).map((e) => Pupil.fromJson(e))));
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungen erstellt');
    notificationManager.isRunningValue(false);
    return responsePupils;
  }

  //- delete pupil authorization
  String deletePupilAuthorizationUrl(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId';
  }

  Future<Pupil> deletePupilAuthorization(int pupilId, String authId) async {
    notificationManager.isRunningValue(true);
    final response = await _client.delete(
        EndpointsAuthorization().deletePupilAuthorizationUrl(pupilId, authId));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Einwilligung konnte nicht gelöscht werden');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to delete pupil authorization', response.statusCode);
    }
    final pupil = Pupil.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');
    notificationManager.isRunningValue(false);
    return pupil;
  }

  //- patch pupil authorization
  String patchPupilAuthorizationUrl(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId';
  }

  Future<Pupil> updatePupilAuthorizationProperty(
      int pupilId, String listId, bool? value, String? comment) async {
    notificationManager.isRunningValue(true);
    String data = '';
    if (value == null) {
      data = jsonEncode({"comment": comment});
    } else if (comment == null) {
      data = jsonEncode({"status": value});
    } else {
      data = jsonEncode({"comment": comment, "status": value});
    }

    final response = await _client.patch(
        EndpointsAuthorization().patchPupilAuthorizationUrl(pupilId, listId),
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Einwilligung konnte nicht geändert werden');

      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to patch pupil authorization', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data

    final pupil = Pupil.fromJson(response.data);

    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');
    notificationManager.isRunningValue(false);
    return pupil;
  }

  // - patch pupil authorization with file
  String patchPupilAuthorizationWithFileUrl(
      int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }

  Future postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    notificationManager.isRunningValue(true);
    final encryptedFile = await customEncrypter.encryptFile(file);
    String fileName = encryptedFile.path.split('/').last;
    final Response response = await _client.patch(
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
      notificationManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to post pupil authorization file', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Pupil pupilResponse = Pupil.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungsdatei hochgeladen');
    return pupilResponse;
  }

//- delete pupil authorization file
  String deletePupilAuthorizationFileUrl(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }

  Future<Pupil> deleteAuthorizationFile(
      int pupilId, String authId, String cacheKey) async {
    notificationManager.isRunningValue(true);
    final Response response = await _client.delete(EndpointsAuthorization()
        .deletePupilAuthorizationFileUrl(pupilId, authId));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Error: ${response.data}');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to delete pupil authorization file', response.statusCode);
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // First we delete the cached image
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // Then we patch the pupil with the data
    final Pupil pupil = Pupil.fromJson(pupilResponse);
    notificationManager.showSnackBar(
        NotificationType.success, 'Einwilligungsdatei gelöscht');
    notificationManager.isRunningValue(false);
    return pupil;
  }

  //-dieser Endpoint wird in widgets benutzt
  String getPupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }

  //- diese Endpoints sind noch nicht implementiert
  String patchAuthorization(int id) {
    return '/authorizations/$id';
  }

  static const String postAuthorizationWithAllPupils =
      '/authorizations/new/all';

  //- diese Endpunkte werden nicht verwendet
  String postAuthorization(int id) {
    return '/pupil/$id/authorization';
  }

  static const String getAuthorizationsFlatUrl = '/authorizations/all/flat';
  String deleteAuthorization(int id) {
    return '/authorizations/$id';
  }
}
