import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

class AdmonitionManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = Endpoints();
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);

  AdmonitionManager(
      // this.session,
      );

  //- HELPER FUNCTIONS

  resetOperationReport() {
    _operationReport.value = Report(null, null);
  }

  _setIsRunning(bool bool) {
    _isRunning.value = bool;
  }

  //- HANDLE Admonition CARD
  int? admonitionSum(Pupil pupil) {
    return pupil.pupilAdmonitions?.length;
  }

  int? findAdmonitionIndex(Pupil pupil, DateTime date) {
    final int? foundAdmonitionIndex = pupil.pupilAdmonitions
        ?.indexWhere((datematch) => (datematch.admonishedDay.isSameDate(date)));
    if (foundAdmonitionIndex == null) {
      return null;
    }
    return foundAdmonitionIndex;
  }

  bool pupilIsAdmonishedToday(Pupil pupil) {
    if (pupil.pupilAdmonitions!.isEmpty) return false;
    if (pupil.pupilAdmonitions!
        .any((element) => element.admonishedDay.isSameDate(DateTime.now()))) {
      return true;
    }
    return false;
  }

  Pupil? findPupilById(int pupilId) {
    final pupils = pupilManager.readPupils();
    final Pupil pupil =
        pupils.singleWhere((element) => element.internalId == pupilId);
    return pupil;
  }

  //-POST ADMONITION
  Future<void> postAdmonition(
      int pupilId, DateTime date, String type, String reason) async {
    resetOperationReport();
    _setIsRunning(true);

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
      _operationReport.value = Report('success', 'Eintrag erfolgreich!');
      pupilManager.patchPupilFromResponse(pupilResponse);
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
    resetOperationReport();
    _setIsRunning(true);
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
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  postAdmonitionFile(File imageFile, String admonitionId) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    String fileName = encryptedFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });
    // send request
    final Response response = await client.patch(
      EndpointsAdmonition().patchAdmonitionFile(admonitionId),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  deleteAdmonitionFile(String admonitionId, String cacheKey) async {
    // send request
    final Response response = await client
        .delete(EndpointsAdmonition().deleteAdmonitionFile(admonitionId));
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // Delete the file from the cache
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // And patch the pupil with the data
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  deleteAdmonition(String admonitionId) async {
    resetOperationReport();
    _setIsRunning(true);
    // send request
    Response response = await client
        .delete(EndpointsAdmonition().deleteAdmonition(admonitionId));

    if (response.statusCode != 200) {
      _operationReport.value = Report('warning', response.data);
      return;
    }
    _operationReport.value = Report('success', 'Fehlzeit gelöscht!');
    locator<PupilManager>().patchPupilFromResponse(response.data);
    _setIsRunning(false);
  }
}
