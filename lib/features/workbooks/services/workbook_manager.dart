import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';

class WorkbookManager {
  ValueListenable<List<Workbook>> get workbooks => _workbooks;

  final _workbooks = ValueNotifier<List<Workbook>>([]);

  WorkbookManager();
  final client = locator.get<ApiManager>().dioClient.value;
  final session = locator.get<SessionManager>().credentials.value;

  Future<WorkbookManager> init() async {
    await getWorkbooks();
    return this;
  }

  Future getWorkbooks() async {
    try {
      final response = await client.get(EndpointsWorkbook.getWorkbooksUrl);
      final workbooks =
          (response.data as List).map((e) => Workbook.fromJson(e)).toList();
      debug.success(
          'WorkbookRepository fetched ${workbooks.length} workbooks! | ${StackTrace.current}');
      _workbooks.value = workbooks;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
  }

  Future postWorkbook(
      String name, int isbn, String subject, String level, int amount) async {
    final data = jsonEncode({
      "name": name,
      "isbn": isbn,
      "subject": subject,
      "level": level,
      "image_url": null,
      "amount": amount
    });
    final Response response = await client.post(
      EndpointsWorkbook.postWorkbookUrl,
      data: data,
    );
    if (response.statusCode != 200) {
      // handle errors
    }
    debug.success('Workbook created! | ${StackTrace.current}');
    Workbook newWorkbook = Workbook.fromJson(response.data);
    _workbooks.value = [..._workbooks.value, newWorkbook];
  }

  patchWorkbook(name, isbn, subject, level) async {
    final Workbook workbook = _workbooks.value.firstWhere(
      (workbook) => workbook.isbn == isbn,
    );

    final data = jsonEncode({
      "name": name ?? workbook.name,
      "subject": subject ?? workbook.subject,
      "level": level ?? workbook.level,
      "image_url": workbook.imageUrl
    });
    final Response response = await client.patch(
        EndpointsWorkbook().patchWorkbookUrl((workbook.isbn)),
        data: data);
    if (response.statusCode != 200) {
      // handle errors
    }
    debug.success('Workbook updated! | ${StackTrace.current}');
    final Workbook updatedWorkbook = Workbook.fromJson(response.data);

    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere(
      (workbook) => workbook.isbn == updatedWorkbook.isbn,
    );
    workbooks[index] = updatedWorkbook;

    _workbooks.value = workbooks;
  }

  postWorkbookFile(File imageFile, int isbn) async {
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
      EndpointsWorkbook().patchWorkbookWithImageUrl(isbn),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    final Workbook workbook = Workbook.fromJson(pupilResponse);
    updateWorkbookInRepositoryWithResponse(workbook);
  }

  //- this function is not calling the Api
  updateWorkbookInRepositoryWithResponse(Workbook workbook) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == workbook.isbn);
    workbooks[index] = workbook;
    _workbooks.value = workbooks;
  }

  deleteWorkbook(int isbn) async {
    final Response response =
        await client.delete(EndpointsWorkbook().deleteWorkbookUrl(isbn));
    if (response.statusCode != 200) {
      // handle errors
    }

    debug.success('Workbook deleted! | ${StackTrace.current}');
    final workbooks =
        (response.data as List).map((e) => Workbook.fromJson(e)).toList();
    _workbooks.value = workbooks;
    List<PupilProxy> pupils =
        List<PupilProxy>.from(locator<PupilManager>().allPupils);
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilWorkbooks != null) {
        final PupilWorkbook? pupilWorkbook = pupil.pupilWorkbooks!
            .firstWhereOrNull((element) => element.workbookIsbn == isbn);
        // if (pupilWorkbook != null) {
        //   List<PupilWorkbook> updatedPupilWorkbooks = [
        //     ...pupil.pupilWorkbooks!
        //   ];
        //   updatedPupilWorkbooks.remove(pupilWorkbook);

        //   Pupil updatedPupil =
        //       pupil.copyWith(pupilWorkbooks: updatedPupilWorkbooks);

        //   locator<PupilManager>().updatePupilInRepository(updatedPupil);
        // }
      }
    }
  }

  //- this function is not calling the Api
  Workbook? getWorkbookByIsbn(int? isbn) {
    if (isbn == null) return null;
    final Workbook? workbook =
        _workbooks.value.firstWhereOrNull((element) => element.isbn == isbn);
    return workbook;
  }

  newPupilWorkbook(int pupilId, int isbn) async {
    final Response response = await client
        .post(EndpointsPupilWorkbook().newPupilWorkbookUrl(pupilId, isbn));
    if (response.statusCode != 200) {
      // handle errors
    }
    debug.success('Workbook created! | ${StackTrace.current}');

    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(response.data));
  }

  deletePupilWorkbook(int pupilId, int isbn) async {
    final Response response = await client
        .delete(EndpointsPupilWorkbook().deletePupilWorkbookUrl(pupilId, isbn));
    if (response.statusCode != 200) {
      // handle errors
    }
    debug.success('Workbook deleted! | ${StackTrace.current}');
    locator<PupilManager>()
        .updatePupilProxyWithPupil(Pupil.fromJson(response.data));
  }
}
