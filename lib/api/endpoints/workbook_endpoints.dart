import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';

class EndpointsWorkbook {
  final _client = locator<ApiManager>().dioClient.value;
  final notificationManager = locator<NotificationManager>();

  //- get workbooks
  static const getWorkbooksUrl = '/workbooks/all/flat';
  Future<List<Workbook>> getWorkbooks() async {
    final Response response =
        await _client.get(EndpointsWorkbook.getWorkbooksUrl);

    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Arbeitshefte');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to fetch workbooks', response.statusCode);
    }
    final List<Workbook> workbooks =
        (response.data as List).map((e) => Workbook.fromJson(e)).toList();
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitshefte erfolgreich geladen');
    notificationManager.isRunningValue(false);
    return workbooks;
  }

  //- post new workbook
  static const postWorkbookUrl = '/workbooks/new';
  Future<Workbook> postWorkbook(
      String name, int isbn, String subject, String level, int amount) async {
    notificationManager.isRunningValue(true);
    final data = jsonEncode({
      "name": name,
      "isbn": isbn,
      "subject": subject,
      "level": level,
      "image_url": null,
      "amount": amount
    });
    final Response response = await _client.post(
      EndpointsWorkbook.postWorkbookUrl,
      data: data,
    );
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch workbooks', response.statusCode);
    }

    Workbook newWorkbook = Workbook.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich erstellt');
    notificationManager.isRunningValue(false);
    return newWorkbook;
  }

  //- patch workbook
  String patchWorkbookUrl(int isbn) {
    return '/workbooks/$isbn';
  }

  Future<Workbook> updateWorkbookProperty(
      {required Workbook workbook,
      String? name,
      int? isbn,
      String? subject,
      String? level}) async {
    final data = jsonEncode({
      "name": name ?? workbook.name,
      "subject": subject ?? workbook.subject,
      "level": level ?? workbook.level,
      "image_url": workbook.imageUrl
    });
    final Response response = await _client.patch(
        EndpointsWorkbook().patchWorkbookUrl((workbook.isbn)),
        data: data);
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren des Arbeitshefts');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to update a workbook', response.statusCode);
    }

    final Workbook updatedWorkbook = Workbook.fromJson(response.data);
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich aktualisiert');
    notificationManager.isRunningValue(false);
    return updatedWorkbook;
  }

  //- post workbook image
  String patchWorkbookWithImageUrl(int isbn) {
    return '/workbooks/$isbn/image';
  }

  Future<Workbook> postWorkbookFile(File imageFile, int isbn) async {
    notificationManager.isRunningValue(true);
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
    final Response response = await _client.patch(
      EndpointsWorkbook().patchWorkbookWithImageUrl(isbn),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Patchen des Arbeitshefts');
      notificationManager.isRunningValue(false);
      throw ApiException(
          'Failed to upload workbook image', response.statusCode);
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    final Workbook workbook = Workbook.fromJson(pupilResponse);
    notificationManager.showSnackBar(
        NotificationType.success, 'Bild erfolgreich hochgeladen');
    notificationManager.isRunningValue(false);
    return workbook;
  }

  //- get workbook image
  //- this one is called from a widget, should we move it
  //- when we stitch the datalayer back to the widgets?
  String getWorkbookImage(int isbn) {
    return '/workbooks/$isbn/image';
  }

  //- delete workbook
  String deleteWorkbookUrl(int isbn) {
    return '/workbooks/$isbn';
  }

  Future<List<Workbook>> deleteWorkbook(int isbn) async {
    notificationManager.isRunningValue(true);

    final Response response =
        await _client.delete(EndpointsWorkbook().deleteWorkbookUrl(isbn));
    if (response.statusCode != 200) {
      notificationManager.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Arbeitshefts');
      notificationManager.isRunningValue(false);
      throw ApiException('Failed to delete a workbook', response.statusCode);
    }
    final List<Workbook> workbooks =
        (response.data as List).map((e) => Workbook.fromJson(e)).toList();
    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich gelöscht');
    notificationManager.isRunningValue(false);
    return workbooks;
  }

  //- these are not being used
  static const getWorkbooksWithPupils = '/workbooks/all';

  String getWorkbook(int isbn) {
    return '/workbooks/$isbn';
  }
}
