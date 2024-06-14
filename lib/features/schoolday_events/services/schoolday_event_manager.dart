import 'dart:io';

import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

class SchooldayEventManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = ApiSettings();

  final apiSchooldayEventService = ApiSchooldayEventService();
  final notificationManager = locator<NotificationManager>();

  SchooldayEventManager();

  //- post schoolday event

  Future<void> postSchooldayEvent(
    int pupilId,
    DateTime date,
    String type,
    String reason,
  ) async {
    final PupilData responsePupil = await apiSchooldayEventService
        .postSchooldayEvent(pupilId, date, type, reason);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  //- patch admonition

  Future<void> patchSchooldayEvent(
      {required String schooldayEventId,
      String? admonisher,
      String? reason,
      bool? processed,
      String? processedBy,
      DateTime? processedAt,
      DateTime? admonishedDay}) async {
    final PupilData responsePupil =
        await apiSchooldayEventService.patchSchooldayEvent(
            schooldayEventId: schooldayEventId,
            admonisher: admonisher,
            reason: reason,
            processed: processed,
            processedBy: processedBy,
            processedAt: processedAt,
            admonishedDay: admonishedDay);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich geändert!');

    return;
  }

  // Future<void> patchSchooldayEventAsProcessed(
  //     String schooldayEventId, bool processed) async {
  //   locator<NotificationManager>().isRunningValue(true);

  //   String data;
  //   if (processed) {
  //     data = jsonEncode({
  //       "processed": processed,
  //       "processed_at": DateTime.now().formatForJson(),
  //       "processed_by": locator<SessionManager>().credentials.value.username
  //     });
  //   } else {
  //     data = jsonEncode(
  //         {"processed": processed, "processed_at": null, "processed_by": null});
  //   }
  //   // send request
  //   final Response response = await client.patch(
  //       ApiSchooldayEventService()._patchSchooldayEventUrl(schooldayEventId),
  //       data: data);
  //   // Handle errors.
  //   if (response.statusCode != 200) {
  //     locator<NotificationManager>().showSnackBar(
  //         NotificationType.warning, 'Fehler beim Patchen der Fehlzeit!');
  //     locator<NotificationManager>().isRunningValue(false);
  //     return;
  //   }
  //   // Success! We have a pupil response - let's patch the pupil with the data
  //   locator<NotificationManager>()
  //       .showSnackBar(NotificationType.success, 'Ereignis geändert!');
  //   final Map<String, dynamic> pupilResponse = response.data;

  //   pupilManager
  //       .updatePupilProxyWithPupilData(PupilData.fromJson(pupilResponse));
  //   locator<NotificationManager>().isRunningValue(false);
  // }

  Future<void> patchSchooldayEventWithFile(
      File imageFile, String schooldayEventId, bool isProcessed) async {
    final PupilData responsePupil = await apiSchooldayEventService
        .patchSchooldayEventWithFile(imageFile, schooldayEventId, isProcessed);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Datei erfolgreich hochgeladen!');

    return;
  }

  Future<void> deleteSchooldayEventFile(
      String schooldayEventId, String cacheKey, bool isProcessed) async {
    final PupilData responsePupil = await apiSchooldayEventService
        .deleteSchooldayEventFile(schooldayEventId, cacheKey, isProcessed);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    locator<NotificationManager>()
        .showSnackBar(NotificationType.success, 'Datei erfolgreich gelöscht!');

    return;
  }

  Future<void> deleteSchooldayEvent(String schooldayEventId) async {
    final PupilData responsePupil =
        await apiSchooldayEventService.deleteSchooldayEvent(schooldayEventId);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Ereignis gelöscht!');

    return;
  }
}
