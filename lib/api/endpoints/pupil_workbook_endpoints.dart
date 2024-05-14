import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class EndpointsPupilWorkbook {
  final _client = ApiManager().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- post new pupil workbook
  String newPupilWorkbookUrl(int pupilId, int isbn) {
    return '/pupil_workbooks/$pupilId/$isbn';
  }

  postNewPupilWorkbook(int pupilId, int isbn) async {
    notificationManager.isRunningValue(true);

    final Response response = await _client
        .post(EndpointsPupilWorkbook().newPupilWorkbookUrl(pupilId, isbn));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Arbeitshefts');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to create a pupil workbook', response.statusCode);
    }
    final Pupil pupil = Pupil.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erstellt');
    notificationManager.isRunningValue(false);
    return pupil;
  }

  //- delete pupil workbook
  String deletePupilWorkbookUrl(int pupilId, int isbn) {
    return '/pupil_workbooks/$pupilId/$isbn';
  }

  Future<Pupil> deletePupilWorkbook(int pupilId, int isbn) async {
    notificationManager.isRunningValue(true);
    final Response response = await _client
        .delete(EndpointsPupilWorkbook().deletePupilWorkbookUrl(pupilId, isbn));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Arbeitshefts');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to delete a pupil workbook', response.statusCode);
    }
    final Pupil pupil = Pupil.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft gelöscht');
    notificationManager.isRunningValue(false);
    return pupil;
  }

  //- not implemented
  String patchPupilWorkbook(int pupilId, int isbn) {
    return '/pupil_workbooks/$pupilId/$isbn';
  }
}
