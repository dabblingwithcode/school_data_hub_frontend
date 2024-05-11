import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

class AdmonitionManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = Endpoints();

  ValueListenable<bool> get isRunning => _isRunning;

  final _isRunning = ValueNotifier<bool>(false);

  AdmonitionManager(
      // this.session,
      );

  //- HELPER FUNCTIONS

  //- HANDLE Admonition CARD

  // Pupil? findPupilById(int pupilId) {
  //   final pupils = pupilManager.readPupils();
  //   final Pupil pupil =
  //       pupils.singleWhere((element) => element.internalId == pupilId);
  //   return pupil;
  // }

  //-POST ADMONITION
  Future<void> postAdmonition(
      int pupilId, DateTime date, String type, String reason) async {
    locator<SnackBarManager>().isRunningValue(true);

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
        await client.post(EndpointsAdmonition.postAdmonition, data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode == 200) {
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Eintrag erfolgreich!');

      pupilManager.patchPupilFromResponse(pupilResponse);
      locator<SnackBarManager>().isRunningValue(false);
    }
  }

  //- PATCH ADMONITION

  patchAdmonition(
      String admonitionId,
      String? admonisher,
      String? reason,
      bool? processed,
      String? file,
      String? processedBy,
      DateTime? processedAt) async {
    final data = jsonEncode({
      if (admonisher != null) "admonishing_user": admonisher,
      if (reason != null) "admonition_reason": reason,
      if (processed != null) "processed": processed,
      if (file != null) "file_url": file,
      if (processedBy != null) "processed_by": processedBy,
      if (processedAt != null) "processed_at": processedAt.formatForJson()
    });
    final Response response = await client
        .patch(EndpointsAdmonition().patchAdmonition(admonitionId), data: data);
    if (response.statusCode != 200) {
      // Handle errors.
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  patchAdmonitionAsProcessed(String admonitionId, bool processed) async {
    locator<SnackBarManager>().isRunningValue(true);

    String data;
    if (processed) {
      data = jsonEncode({
        "processed": processed,
        "processed_at": DateTime.now().formatForJson(),
        "processed_by": locator<SessionManager>().credentials.value.username
      });
    } else {
      data = jsonEncode(
          {"processed": processed, "processed_at": null, "processed_by": null});
    }
    // send request
    final Response response = await client
        .patch(EndpointsAdmonition().patchAdmonition(admonitionId), data: data);
    // Handle errors.
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.warning, 'Fehler beim Patchen der Fehlzeit!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Ereignis geändert!');
    final Map<String, dynamic> pupilResponse = response.data;

    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>().isRunningValue(false);
  }

  postAdmonitionFile(
      File imageFile, String admonitionId, bool isProcessed) async {
    locator<SnackBarManager>().isRunningValue(true);
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
          EndpointsAdmonition().patchAdmonitionProcessedFile(admonitionId);
    } else {
      endpoint = EndpointsAdmonition().patchAdmonitionFile(admonitionId);
    }
    // send request
    final Response response = await client.patch(
      endpoint,
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.warning, 'Fehler beim Patchen der Fehlzeit!');
      locator<SnackBarManager>().isRunningValue(false);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Datei erfolgreich hochgeladen!');
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>().isRunningValue(false);
  }

  deleteAdmonitionFile(
      String admonitionId, String cacheKey, bool isProcessed) async {
    locator<SnackBarManager>().isRunningValue(true);
    // choose endpoint depending on isProcessed
    String endpoint;
    if (isProcessed) {
      endpoint =
          EndpointsAdmonition().deleteAdmonitionProcessedFile(admonitionId);
    } else {
      endpoint = EndpointsAdmonition().deleteAdmonitionFile(admonitionId);
    }

    // send request
    final Response response = await client.delete(endpoint);
    // Handle errors.
    if (response.statusCode != 200) {
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.warning, 'Fehler beim Löschen der Datei!');
      locator<SnackBarManager>().isRunningValue(false);
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // Delete the file from the cache
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // And patch the pupil with the data
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Datei erfolgreich gelöscht!');
    locator<SnackBarManager>().isRunningValue(false);
  }

  deleteAdmonition(String admonitionId) async {
    locator<SnackBarManager>().isRunningValue(true);

    // send request
    Response response = await client
        .delete(EndpointsAdmonition().deleteAdmonition(admonitionId));

    if (response.statusCode != 200) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.warning, 'Fehler - statuscode ${response.statusCode}!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Fehlzeit gelöscht!');

    locator<PupilManager>().patchPupilFromResponse(response.data);
    locator<SnackBarManager>().isRunningValue(false);
  }
}
