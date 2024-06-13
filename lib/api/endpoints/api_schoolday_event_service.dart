import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

class ApiSchooldayEventService {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  late final DioClient _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- post schooldayEvent

  static const _postSchooldayEventUrl = '/admonitions/new';

  Future<PupilData> postSchooldayEvent(
      int pupilId, DateTime date, String type, String reason) async {
    locator<NotificationManager>().isRunningValue(true);

    final data = jsonEncode({
      "admonished_day": date.formatForJson(),
      "admonished_pupil_id": pupilId,
      "admonition_reason": reason,
      "admonition_type": type,
      "file_id": null,
      "processed": false,
      "processed_at": null,
      "processed_by": null
    });

    final Response response =
        await _client.post(_postSchooldayEventUrl, data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.warning, 'Fehler beim Posten des Ereignisses!');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to post an schooldayEvent', response.statusCode);
    }

    final PupilData responsePupil = PupilData.fromJson(response.data);

    locator<NotificationManager>().isRunningValue(false);
    return responsePupil;
  }

  //- GET
  static const fetchSchooldayEventsUrl = '/admonitions/all';

  String getSchooldayEventUrl(String id) {
    return '/admonitions/$id';
  }

  String getSchooldayEventFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  String getSchooldayEventProcessedFileUrl(String id) {
    return '/admonitions/$id/processed_file';
  }

  //- patch schooldayEvent
  String _patchSchooldayEventUrl(String id) {
    return '/admonitions/$id/patch';
  }

  Future<PupilData> patchSchooldayEvent(
      {required String schooldayEventId,
      String? admonisher,
      String? reason,
      bool? processed,
      //String? file,
      String? processedBy,
      DateTime? processedAt,
      DateTime? admonishedDay}) async {
    notificationManager.isRunningValue(true);

    // if the schooldayEvent is patched as processed,
    // processing user and processed date are automatically added

    if (processed == true && processedBy == null && processedAt == null) {
      processedBy = locator<SessionManager>().credentials.value.username;
      processedAt = DateTime.now();
    }

    // if the schooldayEvent is patched as not processed,
    // processing user and processed date are set to null

    if (processed == false) {
      processedBy = null;
      processedAt = null;
    }

    final data = jsonEncode({
      if (admonisher != null) "admonishing_user": admonisher,
      if (reason != null) "admonition_reason": reason,
      if (processed != null) "processed": processed,
      if (processedBy != null) "processed_by": processedBy,
      if (processed == false) "processed_by": null,
      if (processedAt != null) "processed_at": processedAt.formatForJson(),
      if (processed == false) "processed_at": null,
      if (admonishedDay != null)
        "admonished_day": admonishedDay.formatForJson(),
    });

    final Response response = await _client
        .patch(_patchSchooldayEventUrl(schooldayEventId), data: data);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.warning, 'Fehler beim Patchen des Ereignisses!');

      notificationManager.isRunningValue(false);

      throw ApiException(
          'Failed to patch an schooldayEvent', response.statusCode);
    }

    final PupilData responsePupil = PupilData.fromJson(response.data);

    locator<NotificationManager>().isRunningValue(false);

    return responsePupil;
  }

  //- upload file to document an schooldayEvent

  //- an schooldayEvent can be documented with an image file of a document
  //- the file is encrypted before it is uploaded
  //- there are two possible endpoints for the file upload, depending on whether the schooldayEvent is processed or not

  String _patchSchooldayEventFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  String _patchSchooldayEventProcessedFileUrl(String id) {
    return '/admonitions/$id/processed_file';
  }

  Future<PupilData> patchSchooldayEventWithFile(
      File imageFile, String schooldayEventId, bool isProcessed) async {
    locator<NotificationManager>().isRunningValue(true);

    String endpoint;

    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    String fileName = encryptedFile.path.split('/').last;

    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });

    // choose endpoint depending on isProcessed
    if (isProcessed) {
      endpoint = _patchSchooldayEventProcessedFileUrl(schooldayEventId);
    } else {
      endpoint = _patchSchooldayEventFileUrl(schooldayEventId);
    }

    final Response response = await _client.patch(
      endpoint,
      data: formData,
    );

    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Hochladen des Bildes!');

      locator<NotificationManager>().isRunningValue(false);

      throw ApiException(
          'Failed to upload schooldayEvent file', response.statusCode);
    }

    final PupilData responsePupil = PupilData.fromJson(response.data);

    locator<NotificationManager>().isRunningValue(false);

    return responsePupil;
  }

  //- delete schooldayEvent

  String _deleteSchooldayEventUrl(String id) {
    return '/admonitions/$id/delete';
  }

  Future<PupilData> deleteSchooldayEvent(String schooldayEventId) async {
    locator<NotificationManager>().isRunningValue(true);

    Response response =
        await _client.delete(_deleteSchooldayEventUrl(schooldayEventId));
    locator<NotificationManager>().isRunningValue(false);
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Löschen des Ereignisses!');

      throw ApiException(
          'Failed to delete schooldayEvent', response.statusCode);
    }

    final PupilData responsePupil = PupilData.fromJson(response.data);
    return responsePupil;
  }

//- delete schooldayEvent file
//- depending on isProcessed, there are two possible endpoints for the file deletion
  String _deleteSchooldayEventFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  String _deleteSchooldayEventProcessedFileUrl(String id) {
    return '/admonitions/$id/processed_file';
  }

  deleteSchooldayEventFile(
      String schooldayEventId, String cacheKey, bool isProcessed) async {
    locator<NotificationManager>().isRunningValue(true);

    // choose endpoint depending on isProcessed
    String endpoint;
    if (isProcessed) {
      endpoint = _deleteSchooldayEventProcessedFileUrl(schooldayEventId);
    } else {
      endpoint = _deleteSchooldayEventFileUrl(schooldayEventId);
    }

    final Response response = await _client.delete(endpoint);

    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Löschen der Datei!');

      locator<NotificationManager>().isRunningValue(false);

      throw ApiException(
          'Failed to delete schooldayEvent', response.statusCode);
    }

    final PupilData responsePupil = PupilData.fromJson(response.data);

    // Delete the file from the cache
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);

    notificationManager.isRunningValue(false);

    return responsePupil;
  }
}
