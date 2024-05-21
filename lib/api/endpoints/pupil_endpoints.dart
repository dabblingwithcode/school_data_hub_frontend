import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class ApiPupilService {
  late final DioClient _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- This one is in PupilPersonalDataManager, have to review that one

  static const updateBackendPupilsDatabaseUrl = '/import/pupils/txt';

  Future<List<Pupil>> updateBackendPupilsDatabase({required File file}) async {
    notificationManager.isRunningValue(true);

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    final response = await _client.post(
      updateBackendPupilsDatabaseUrl,
      data: formData,
    );

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Liste konnte nicht aktualisiert werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to export pupils to txt', response.statusCode);
    }

    final List<Pupil> pupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();

    notificationManager.isRunningValue(false);

    return pupils;
  }

  //- THIS ENDPOINTS ARE NOT USED IN THE APP
  static const getAllPupils = '/pupils/all';
  static const getPupilsFlat = '/pupils/all/flat';
  static const postPupil = '/pupils/new';
  String deletePupil(int pupilId) {
    return '/pupils/$pupilId';
  }

  //- fetch list of pupils

  static const fetchPupilsUrl = '/pupils/list';

  Future<List<Pupil>> fetchListOfPupils({
    required List<int> internalPupilIds,
  }) async {
    notificationManager.isRunningValue(true);

    final pupilIdsListToJson = jsonEncode({"pupils": internalPupilIds});

    final response =
        await _client.post(fetchPupilsUrl, data: pupilIdsListToJson);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht geladen werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to fetch pupils', response.statusCode);
    }

    final List<Pupil> responsePupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();

    notificationManager.isRunningValue(false);

    return responsePupils;
  }

  //- NOT USED - Ist das nicht das gleiche wie fetchPupils mit diese eine internalId in der Liste?
  String getOnePupil(int id) {
    return '/pupils/$id';
  }

  //- NOT USED - instead the url is used in downloadOrCachedAndDecryptImage
  String getPupilAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  /// mach das hier für alle endpoints
  /// Functionen mit aussagekraäfigen Namen
  /// die die richtigen Typen zurückgeben
  /// die verwendung in der App kommt dann im nöchsten Schritt
  /// diese funktionen lassen sich dann auch testen
  //- update pupil property

  String updatePupilPropertyUrl(int id) {
    return '/pupils/$id';
  }

  Future<Pupil> updatePupilProperty({
    required int id,
    required String property,
    required dynamic value,
  }) async {
    notificationManager.isRunningValue(true);

    final Map<String, dynamic> data = {property: value};
    final response =
        await _client.patch(updatePupilPropertyUrl(id), data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to update pupil property', response.statusCode);
    }

    /// wenn immer möglich mach die deserialisierung direkt am endpoint
    /// so dass die app nicht mit resonse objekten arbeiten und wissen muss
    /// wie die daten aussehen
    final Pupil responsePupil = Pupil.fromJson(response.data);

    notificationManager.isRunningValue(false);

    return responsePupil;
  }

  //- patch siblings

  static const patchSiblingsUrl = '/pupils/patch_siblings';
  Future<List<Pupil>> updateSiblingsProperty({
    required List<int> siblingsPupilIds,
    required String property,
    required dynamic value,
  }) async {
    notificationManager.isRunningValue(true);

    final data = jsonEncode({
      'pupils': siblingsPupilIds,
      property: value,
    });

    final response = await _client.patch(patchSiblingsUrl, data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Die Geschwister konnten nicht aktualisiert werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to patch siblings', response.statusCode);
    }
    final List<Pupil> responsePupils =
        (response.data as List).map((e) => Pupil.fromJson(e)).toList();

    notificationManager.isRunningValue(false);

    return responsePupils;
  }

  //- post / patch pupil avatar

  String updatePupilhWithAvatarUrl(int id) {
    return '/pupils/$id/avatar';
  }

  Future<Pupil> updatePupilWithAvatar({
    required int id,
    required FormData formData,
  }) async {
    notificationManager.isRunningValue(true);

    final Response response =
        await _client.patch(updatePupilhWithAvatarUrl(id), data: formData);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Das Profilbild konnte nicht aktualisiert werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException('Failed to upload pupil avatar', response.statusCode);
    }

    notificationManager.isRunningValue(false);

    return Pupil.fromJson(response.data);
  }

  //- delete pupil avatar

  String deletePupilAvatarUrl(int internalId) {
    return '/pupils/$internalId/avatar';
  }

  Future<void> deletePupilAvatar({required int internalId}) async {
    notificationManager.isRunningValue(true);

    final Response response =
        await _client.delete(deletePupilAvatarUrl(internalId));

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(NotificationType.error,
          'Das Profilbild konnte nicht gelöscht werden: ${response.statusCode}');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Something went wrong deleting the avatar', response.statusCode);
    }
    //TODO: This is an empty response, should we return something?
    return;
  }
}
