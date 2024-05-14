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
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

class EndpointsAdmonition {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  late final DioClient _client = locator<ApiManager>().dioClient.value;

  //- post admonition
  static const postAdmonitionUrl = '/admonitions/new';
  Future<Pupil> postAdmonition(
      int pupilId, DateTime date, String type, String reason) async {
    locator<NotificationManager>().isRunningValue(true);

    final data = jsonEncode({
      "admonished_day": date.formatForJson(),
      "admonished_pupil_id": pupilId,
      "admonition_reason": reason,
      "admonition_type": type,
      "file_url": null,
      "processed": false,
      "processed_at": null,
      "processed_by": null
    });
    final Response response =
        await _client.post(EndpointsAdmonition.postAdmonitionUrl, data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    //deserialize
    if (response.statusCode != 200) {
      throw ApiException('Failed to post an admonition', response.statusCode);
    }

    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Eintrag erfolgreich!');
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);

    locator<NotificationManager>().isRunningValue(false);
    return responsePupil;
  }

  //- GET
  static const fetchAdmonitionsUrl = '/admonitions/all';

  String getAdmonitionUrl(String id) {
    return '/admonitions/$id';
  }

  String getAdmonitionFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  //- patch admonition
  String patchAdmonitionUrl(String id) {
    return '/admonitions/$id/patch';
  }

  Future<Pupil> patchAdmonition(
      String admonitionId,
      String? admonisher,
      String? reason,
      bool? processed,
      String? file,
      String? processedBy,
      DateTime? processedAt) async {
    // if the admonition is patched as processed,
    // processing user and processed date are automatically added
    final data = jsonEncode({
      if (admonisher != null) "admonishing_user": admonisher,
      if (reason != null) "admonition_reason": reason,
      if (processed != null) "processed": processed,
      if (file != null) "file_url": file,
      if (processedBy != null)
        "processed_by": locator<SessionManager>().credentials.value.username,
      if (processedAt != null) "processed_at": processedAt.formatForJson()
    });
    final Response response = await _client.patch(
        EndpointsAdmonition().patchAdmonitionUrl(admonitionId),
        data: data);
    if (response.statusCode != 200) {
      throw ApiException('Failed to patch an admonition', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);

    locator<NotificationManager>().isRunningValue(false);
    return responsePupil;
  }

  //- upload file to document an admonition
  //- an admonition can be documented with an image file of a document
  //- the file is encrypted before it is uploaded
  //- there are two possible endpoints for the file upload, depending on whether the admonition is processed or not
  String patchAdmonitionFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  String patchAdmonitionProcessedFileUrl(String id) {
    return '/admonitions/$id/processed_file';
  }

  Future<Pupil> patchAdmonitionWithFile(
      File imageFile, String admonitionId, bool isProcessed) async {
    locator<NotificationManager>().isRunningValue(true);
    final encryptedFile = await customEncrypter.encryptFile(imageFile);
    String endpoint;
    String fileName = encryptedFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });
    // choose endpoint depending on isProcessed
    if (isProcessed) {
      endpoint =
          EndpointsAdmonition().patchAdmonitionProcessedFileUrl(admonitionId);
    } else {
      endpoint = EndpointsAdmonition().patchAdmonitionFileUrl(admonitionId);
    }
    // send request
    final Response response = await _client.patch(
      endpoint,
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Patchen der Fehlzeit!');
      locator<NotificationManager>().isRunningValue(false);
      throw ApiException(
          'Failed to upload admonition file', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Datei erfolgreich hochgeladen!');

    final Map<String, dynamic> pupilResponse = response.data;
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);

    locator<NotificationManager>().isRunningValue(false);
    return responsePupil;
  }

  //- delete admonition
  String deleteAdmonitionUrl(String id) {
    return '/admonitions/$id/delete';
  }

  deleteAdmonition(String admonitionId) async {
    locator<NotificationManager>().isRunningValue(true);

    Response response = await _client
        .delete(EndpointsAdmonition().deleteAdmonitionUrl(admonitionId));

    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Löschen des Ereignisses!');
      locator<NotificationManager>().isRunningValue(false);
      throw ApiException('Failed to delete admonition', response.statusCode);
    }
    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Fehlzeit gelöscht!');

    final Pupil responsePupil = Pupil.fromJson(response.data);
    return responsePupil;
  }

//- delete admonition file
//- depending on isProcessed, there are two possible endpoints for the file deletion
  String deleteAdmonitionFileUrl(String id) {
    return '/admonitions/$id/file';
  }

  String deleteAdmonitionProcessedFileUrl(String id) {
    return '/admonitions/$id/processed_file';
  }

  deleteAdmonitionFile(
      String admonitionId, String cacheKey, bool isProcessed) async {
    locator<NotificationManager>().isRunningValue(true);
    // choose endpoint depending on isProcessed
    String endpoint;
    if (isProcessed) {
      endpoint =
          EndpointsAdmonition().deleteAdmonitionProcessedFileUrl(admonitionId);
    } else {
      endpoint = EndpointsAdmonition().deleteAdmonitionFileUrl(admonitionId);
    }

    // send request
    final Response response = await _client.delete(endpoint);
    // Handle errors.
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Löschen der Datei!');
      locator<NotificationManager>().isRunningValue(false);
      throw ApiException('Failed to delete admonition', response.statusCode);
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // Delete the file from the cache
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // And patch the pupil with the data
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);
    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Datei erfolgreich gelöscht!');
    return responsePupil;
  }
}
