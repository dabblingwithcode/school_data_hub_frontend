import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';

class WorkbookManager {
  ValueListenable<List<Workbook>> get workbooks => _workbooks;

  final _workbooks = ValueNotifier<List<Workbook>>([]);

  WorkbookManager();
  final client = locator.get<ApiManager>().dioClient.value;
  final session = locator.get<SessionManager>().credentials.value;
  final apiPupilWorkbookService = ApiPupilWorkbookService();

  Future<WorkbookManager> init() async {
    await getWorkbooks();
    logger.i('WorkbookManager constructed!');
    return this;
  }

  final apiWorkbookService = ApiWorkbookService();
  final notificationManager = locator<NotificationManager>();
  final pupilManager = locator<PupilManager>();

  Future<void> getWorkbooks() async {
    final List<Workbook> responseWorkbooks =
        await apiWorkbookService.getWorkbooks();

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitshefte erfolgreich geladen');

    _workbooks.value = responseWorkbooks;

    return;
  }

  Future<void> postWorkbook(
    String name,
    int isbn,
    String subject,
    String level,
    int amount,
  ) async {
    final Workbook responseWorkbook = await apiWorkbookService.postWorkbook(
        name, isbn, subject, level, amount);

    _workbooks.value = [..._workbooks.value, responseWorkbook];

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich erstellt');

    return;
  }

  Future<void> updateWorkbookProperty(name, isbn, subject, level) async {
    final Workbook workbookToUpdate = _workbooks.value.firstWhere(
      (workbook) => workbook.isbn == isbn,
    );

    final Workbook updatedWorkbook =
        await apiWorkbookService.updateWorkbookProperty(
      workbook: workbookToUpdate,
      name: name,
      subject: subject,
      level: level,
    );

    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks
        .indexWhere((workbook) => workbook.isbn == updatedWorkbook.isbn);

    workbooks[index] = updatedWorkbook;

    _workbooks.value = workbooks;

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich aktualisiert');

    return;
  }

  Future<void> postWorkbookFile(File imageFile, int isbn) async {
    final Workbook responseWorkbook =
        await apiWorkbookService.postWorkbookFile(imageFile, isbn);

    updateWorkbookInRepositoryWithResponse(responseWorkbook);

    notificationManager.showSnackBar(
        NotificationType.success, 'Bild erfolgreich hochgeladen');

    return;
  }

  Future<void> deleteWorkbook(int isbn) async {
    final List<Workbook> workbooks =
        await apiWorkbookService.deleteWorkbook(isbn);

    _workbooks.value = workbooks;

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich gelöscht');

    //- TODO: delete all pupilWorkbooks with this isbn
    return;
  }

  Future<void> deleteWorkbookFile(int isbn) async {
    final Workbook responseWorkbook =
        await apiWorkbookService.deleteWorkbookFile(isbn);

    updateWorkbookInRepositoryWithResponse(responseWorkbook);

    notificationManager.showSnackBar(
        NotificationType.success, 'Bild erfolgreich gelöscht');

    return;
  }
  //- PUPIL WORKBOOKS

  Future<void> newPupilWorkbook(int pupilId, int isbn) async {
    final PupilData responsePupil =
        await apiPupilWorkbookService.postNewPupilWorkbook(pupilId, isbn);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft erstellt');

    return;
  }

  Future<void> deletePupilWorkbook(int pupilId, int isbn) async {
    final PupilData responsePupil =
        await apiPupilWorkbookService.deletePupilWorkbook(pupilId, isbn);

    pupilManager.updatePupilProxyWithPupilData(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Arbeitsheft gelöscht');

    return;
  }

  //- helper function
  Workbook? getWorkbookByIsbn(int? isbn) {
    if (isbn == null) return null;
    final Workbook? workbook =
        _workbooks.value.firstWhereOrNull((element) => element.isbn == isbn);
    return workbook;
  }

  //- helper function
  void updateWorkbookInRepositoryWithResponse(Workbook workbook) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == workbook.isbn);
    workbooks[index] = workbook;
    _workbooks.value = workbooks;
  }
}
