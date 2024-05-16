import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

enum SchooldayEventType {
  parentsMeeting('Eg'),
  admonition('rk'),
  afternoonCareAdmonition('rkogs'),
  admonitionAndBanned('rkabh');

  final String value;
  const SchooldayEventType(this.value);
}

enum AdmonitionReason {
  violenceAgainstPupils('gm'),
  violenceAgainstTeachers('gl'),
  violenceAgainstThings('gk'),
  insultOthers('ab'),
  dangerousBehaviour('gv'),
  annoyOthers('äa'),
  ignoreInstructions('il'),
  disturbLesson('us'),
  other('ss');

  final String value;
  const AdmonitionReason(this.value);
}

class SchooldayEventManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = ApiSettings();

  ValueListenable<bool> get isRunning => _isRunning;

  final _isRunning = ValueNotifier<bool>(false);

  SchooldayEventManager(
      // this.session,
      );

  //- HELPER FUNCTIONS

  //- HANDLE SchooldayEvent CARD

  // PupilProxy? findPupilById(int pupilId) {
  //   final pupils = pupilManager.readPupils();
  //   final PupilProxy pupil =
  //       pupils.singleWhere((element) => element.internalId == pupilId);
  //   return pupil;
  // }

  //-POST ADMONITION
  Future<void> postSchooldayEvent(
      int pupilId, DateTime date, String type, String reason) async {
    locator<NotificationManager>().isRunningValue(true);

    final data = jsonEncode({
      "admonished_day": date.formatForJson(),
      "admonished_pupil_id": pupilId,
      "schooldayEvent_reason": reason,
      "schooldayEvent_type": type,
      "file_url": null,
      "processed": false,
      "processed_at": null,
      "processed_by": null
    });
    final Response response = await client
        .post(EndpointsSchooldayEvent.postSchooldayEventUrl, data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode == 200) {
      locator<NotificationManager>()
          .showSnackBar(NotificationType.success, 'Eintrag erfolgreich!');

      pupilManager.updatePupilFromResponse(pupilResponse);
      locator<NotificationManager>().isRunningValue(false);
    }
  }

  //- PATCH ADMONITION

  patchSchooldayEvent(
      String schooldayEventId,
      String? admonisher,
      String? reason,
      bool? processed,
      String? file,
      String? processedBy,
      DateTime? processedAt) async {
    final data = jsonEncode({
      if (admonisher != null) "admonishing_user": admonisher,
      if (reason != null) "schooldayEvent_reason": reason,
      if (processed != null) "processed": processed,
      if (file != null) "file_url": file,
      if (processed != null) "processed_by": processedBy,
      if (processed != null) "processed_at": DateTime.now().formatForJson(),
    });
    final Response response = await client.patch(
        EndpointsSchooldayEvent().patchSchooldayEventUrl(schooldayEventId),
        data: data);
    if (response.statusCode != 200) {
      // Handle errors.
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().updatePupilFromResponse(pupilResponse);
  }

  //- THIS ONE IS NOT NEEDED ANY MORE
  //- TODO - SWITCH TO THE NEW PATCH ADMONITION FUNCTION
  patchSchooldayEventAsProcessed(
      String schooldayEventId, bool processed) async {
    locator<NotificationManager>().isRunningValue(true);

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
    final Response response = await client.patch(
        EndpointsSchooldayEvent().patchSchooldayEventUrl(schooldayEventId),
        data: data);
    // Handle errors.
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Patchen der Fehlzeit!');
      locator<NotificationManager>().isRunningValue(false);
      return;
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Ereignis geändert!');
    final Map<String, dynamic> pupilResponse = response.data;

    await locator<PupilManager>().updatePupilFromResponse(pupilResponse);
    locator<NotificationManager>().isRunningValue(false);
  }

  patchSchooldayEventWithFile(
      File imageFile, String schooldayEventId, bool isProcessed) async {
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
      endpoint = EndpointsSchooldayEvent()
          .patchSchooldayEventProcessedFileUrl(schooldayEventId);
    } else {
      endpoint = EndpointsSchooldayEvent()
          .patchSchooldayEventFileUrl(schooldayEventId);
    }
    // send request
    final Response response = await client.patch(
      endpoint,
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Patchen der Fehlzeit!');
      locator<NotificationManager>().isRunningValue(false);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Datei erfolgreich hochgeladen!');
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().updatePupilFromResponse(pupilResponse);
    locator<NotificationManager>().isRunningValue(false);
  }

  deleteSchooldayEventFile(
      String schooldayEventId, String cacheKey, bool isProcessed) async {
    locator<NotificationManager>().isRunningValue(true);
    // choose endpoint depending on isProcessed
    String endpoint;
    if (isProcessed) {
      endpoint = EndpointsSchooldayEvent()
          .deleteSchooldayEventProcessedFileUrl(schooldayEventId);
    } else {
      endpoint = EndpointsSchooldayEvent()
          .deleteSchooldayEventFileUrl(schooldayEventId);
    }

    // send request
    final Response response = await client.delete(endpoint);
    // Handle errors.
    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(
          NotificationType.warning, 'Fehler beim Löschen der Datei!');
      locator<NotificationManager>().isRunningValue(false);
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // Delete the file from the cache
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // And patch the pupil with the data
    await locator<PupilManager>().updatePupilFromResponse(pupilResponse);
    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Datei erfolgreich gelöscht!');
    locator<NotificationManager>().isRunningValue(false);
  }

  deleteSchooldayEvent(String schooldayEventId) async {
    locator<NotificationManager>().isRunningValue(true);

    // send request
    Response response = await client.delete(
        EndpointsSchooldayEvent().deleteSchooldayEventUrl(schooldayEventId));

    if (response.statusCode != 200) {
      locator<NotificationManager>().showSnackBar(NotificationType.warning,
          'Fehler - statuscode ${response.statusCode}!');
      locator<NotificationManager>().isRunningValue(false);
      return;
    }
    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Fehlzeit gelöscht!');

    locator<PupilManager>().updatePupilFromResponse(response.data);
    locator<NotificationManager>().isRunningValue(false);
  }
}