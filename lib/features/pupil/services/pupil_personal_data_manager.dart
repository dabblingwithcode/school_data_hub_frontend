import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_personal_data.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

class PupilPersonalDataManager {
  final Map<int, PupilPersonalData> _pupilPersonalData = {};
  List<int> get availablePupilIds => _pupilPersonalData.keys.toList();

  PupilPersonalData? getPersonalData(int pupilId) {
    return _pupilPersonalData[pupilId];
  }

  // wird nirgends verwendet
  // ValueListenable<bool> get isRunning => _isRunning;
  // final _isRunning = ValueNotifier<bool>(false);

  Future<PupilPersonalDataManager> init() async {
    await getStoredPupilBase();
    return this;
  }

  Future deleteData() async {
    locator<SnackBarManager>().isRunningValue(true);
    await secureStorageDelete('pupilBase');
    _pupilPersonalData.clear();
    locator<PupilManager>().deletePupils();
    locator<PupilFilterManager>().deleteFilteredPupils();
    locator<SnackBarManager>().isRunningValue(false);
  }

  Future getStoredPupilBase() async {
    debug.warning('Getting the stored pupilbase');
    List<PupilPersonalData> storedPersonalDataEntries = [];
    bool pupilPersonalDataExists =
        await secureStorage.containsKey(key: 'pupilBase');
    if (pupilPersonalDataExists == true) {
      debug.warning('There is a pupilbase');

      String? storedString = await secureStorageRead('pupilBase');
      storedPersonalDataEntries = (json.decode(storedString!) as List)
          .map((i) => PupilPersonalData.fromJson(i))
          .toList();
      for (PupilPersonalData pupil in storedPersonalDataEntries) {
        _pupilPersonalData[pupil.id] = pupil;
      }

      //- This would be great place for SIGNAL READY!!!
      // TODO not necessary
      debug.info(
          'Pupilbase loaded - Length is ${_pupilPersonalData.length} | ${StackTrace.current}');
      return;
    } else {
      debug.info('No pupilBase in storage! | ${StackTrace.current}');
      return;
    }
  }

  Future<void> scanNewPupilBase(BuildContext context) async {
    final String? scanResult = await scanner(context, 'Scanning Pupilbase');
    if (scanResult != null) {
      addNewPupilBase(scanResult);
    } else {
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.warning, 'Scan abgebrochen');
      return;
    }
  }

  setNewPupilBase(List<PupilPersonalData> personalDataList) async {
    _pupilPersonalData.clear();
    for (PupilPersonalData pupil in personalDataList) {
      _pupilPersonalData[pupil.id] = pupil;
    }
    await secureStorageWrite('pupilBase', jsonEncode(personalDataList));
  }

  void addNewPupilBase(String scanResult) async {
    String? decryptedResult;

    if (!Platform.isWindows) {
      decryptedResult = await customEncrypter.decrypt(scanResult);
    } else {
      // If the string is imported in windows, it's not encrypted
      decryptedResult = scanResult;
    }
    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> splittedPupilBase = decryptedResult!.split('\n');
    // The properties are separated by commas, let's build the pupilbase objects with them
    final oldLenght = _pupilPersonalData.length;
    for (String data in splittedPupilBase) {
      if (data != '') {
        List splittedData = data.split(',');
        final schoolyear = splittedData[4] == '03'
            ? 'S3'
            : splittedData[4] == '04'
                ? 'S4'
                : splittedData[4];
        final newPersonalData = PupilPersonalData(
          id: int.parse(splittedData[0]),
          name: splittedData[1],
          lastName: splittedData[2],
          group: splittedData[3],
          schoolyear: schoolyear,
          specialNeeds: splittedData[5] == ''
              ? null
              : '${splittedData[5]}${splittedData[6]}',
          gender: splittedData[7],
          language: splittedData[8],
          family: splittedData[9] == '' ? null : splittedData[9],
          birthday: DateTime.tryParse(splittedData[10])!,
          migrationSupportEnds: splittedData[11] == ''
              ? null
              : DateTime.tryParse(splittedData[11])!,
          pupilSince: DateTime.tryParse(splittedData[12])!,
        );
        // TODO: do we really only want to add new entries and not update existing ones?
        if (!_pupilPersonalData.containsKey(newPersonalData.id)) {
          _pupilPersonalData[newPersonalData.id] = newPersonalData;
        }
      }
    }
    debug.info('Pupilbase processed');
    await secureStorageWrite(
        'pupilBase', jsonEncode(_pupilPersonalData.values));
    debug.success(
        'Pupilbase extended: $oldLenght pupils before, now ${_pupilPersonalData.length} | ${StackTrace.current}');
    await locator<PupilManager>().fetchAllPupils();

    locator<BottomNavManager>().setBottomNavPage(0);
  }

  void importPupilsFromTxt(String scanResult) async {
    // The pupils in the string are separated by a line break - let's split them out
    List splittedPupilBase = scanResult.split('\n');
    // The properties are separated by commas, let's build the pupilbase objects with them
    String updatedPupils = '';
    List<PupilPersonalData> scannedPupilBase = [];
    for (String data in splittedPupilBase) {
      if (data != '') {
        List splittedData = data.split(',');
        final schoolyear = splittedData[4] == '03'
            ? 'S3'
            : splittedData[4] == '04'
                ? 'S4'
                : splittedData[4];
        scannedPupilBase.add(PupilPersonalData(
          id: int.parse(splittedData[0]),
          name: splittedData[1],
          lastName: splittedData[2],
          group: splittedData[3],
          schoolyear: schoolyear,
          specialNeeds: splittedData[5] == ''
              ? null
              : '${splittedData[5]}${splittedData[6]}',
          gender: splittedData[7],
          language: splittedData[8],
          family: splittedData[9] == '' ? null : splittedData[9],
          birthday: DateTime.tryParse(splittedData[10])!,
          migrationSupportEnds: splittedData[11] == ''
              ? null
              : DateTime.tryParse(splittedData[11])!,
          pupilSince: DateTime.tryParse(splittedData[12])!,
        ));
        final bool ogsStatus = splittedData[13] == 'OFFGANZ' ? true : false;
        final pupilString = '${int.parse(splittedData[0])},$ogsStatus';
        updatedPupils += '$pupilString\n';
      }
    }
    // let's update the pupils in the server with a txt file
    // First we generate a txt file with updatedPupils
    final textFile = File('temp.txt')..writeAsStringSync(updatedPupils);
    final client = locator.get<ApiManager>().dioClient.value;
    String fileName = textFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        textFile.path,
        filename: fileName,
      ),
    });
    final response = await client.post(
      EndpointsPupil.exportPupilsTxt,
      data: formData,
    );
    debug.warning('RESPONSE is ${response.data}');
    // TODO
    //locator<PupilManager>().patchPupilFromResponse(pupilResponse: response.data);
    // we got now the updated data, let's substitute the old pupilbase
    textFile.delete();
    for (PupilPersonalData element in scannedPupilBase) {
      if (!_pupilPersonalData.containsKey(element.id)) {
        _pupilPersonalData[element.id] = element;
      }
    }

    await secureStorageWrite(
        'pupilBase', jsonEncode(_pupilPersonalData.values.toList()));
    await locator<PupilManager>().fetchAllPupils();
    locator<PupilFilterManager>().refreshFilteredPupils();
    locator<BottomNavManager>().setBottomNavPage(0);
  }

  Future<String> generatePupilBaseQrData(List<int> pupilIds) async {
    String qrString = '';
    for (int pupilId in pupilIds) {
      PupilPersonalData pupilbase = _pupilPersonalData.values
          .where((element) => element.id == pupilId)
          .single;
      final migrationSupportEnds = pupilbase.migrationSupportEnds != null
          ? pupilbase.migrationSupportEnds!.formatForJson()
          : '';
      final specialNeeds = pupilbase.specialNeeds ?? '';
      final family = pupilbase.family ?? '';
      final String pupilbaseString =
          '${pupilbase.id},${pupilbase.name},${pupilbase.lastName},${pupilbase.group},${pupilbase.schoolyear},$specialNeeds,,${pupilbase.gender},${pupilbase.language},$family,${pupilbase.birthday.formatForJson()},$migrationSupportEnds,${pupilbase.pupilSince.formatForJson()},\n';
      qrString = qrString + pupilbaseString;
    }
    final encryptedString = await customEncrypter.encrypt(qrString);
    return encryptedString!;
  }

  Future<Map<String, String>> generateAllPupilBaseQrData(int qrsize) async {
    final List<PupilPersonalData> pupilBase =
        _pupilPersonalData.values.toList();
    // First we group the pupils by their group in a map
    Map<String, List<PupilPersonalData>> groupedPupils =
        pupilBase.groupListsBy((element) => element.group);

    // for (var pupil in pupilBase) {
    //   if (groupedPupils.containsKey(pupil.group)) {
    //     groupedPupils[pupil.group]!.add(pupil);
    //   } else {
    //     groupedPupils[pupil.group] = [pupil];
    //   }
    // }
    final Map<String, String> finalGroupedList = {};

    // Now we iterate over the groupedPupils and generate maps with smaller lists with no more than 12 items and add to the group name the subgroup number
    for (String groupName in groupedPupils.keys) {
      final List<PupilPersonalData> group = groupedPupils[groupName]!;
      int numSubgroups = (group.length / qrsize).ceil();

      for (int i = 0; i < numSubgroups; i++) {
        List<PupilPersonalData> smallerGroup = [];
        int start = i * qrsize;
        int end = (i + 1) * qrsize;
        if (end > group.length) {
          end = group.length;
        }
        smallerGroup.addAll(group.sublist(start, end));
        String qrString = '';
        for (PupilPersonalData pupilbase in smallerGroup) {
          final migrationSupportEnds = pupilbase.migrationSupportEnds != null
              ? pupilbase.migrationSupportEnds!.formatForJson()
              : '';
          final specialNeeds = pupilbase.specialNeeds ?? '';
          final family = pupilbase.family ?? '';
          final String pupilbaseString =
              '${pupilbase.id},${pupilbase.name},${pupilbase.lastName},${pupilbase.group},${pupilbase.schoolyear},$specialNeeds,,${pupilbase.gender},${pupilbase.language},$family,${pupilbase.birthday.formatForJson()},$migrationSupportEnds,${pupilbase.pupilSince.formatForJson()},\n';
          qrString = qrString + pupilbaseString;
        }
        final encryptedString = await customEncrypter.encrypt(qrString);
        String subgroupName = "$groupName - ${i + 1}/$numSubgroups";
        finalGroupedList[subgroupName] = encryptedString!;
      }
    }
    // Extracting entries from the map and sorting them based on keys
    List<MapEntry<String, String>> sortedEntries = finalGroupedList.entries
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    // Creating a new map with sorted entries
    Map<String, String> sortedQrGroupLists = Map.fromEntries(sortedEntries);
    return sortedQrGroupLists;
  }

  Future<void> deletePupilBaseElements(
      List<PupilPersonalData> toBeDeletedPupilBase) async {
    locator<SnackBarManager>().isRunningValue(true);
    for (PupilPersonalData pupilBase in toBeDeletedPupilBase) {
      _pupilPersonalData.remove(pupilBase.id);
    }
    await secureStorageWrite(
        'pupilBase', jsonEncode(_pupilPersonalData.values.toList()));
    locator<SnackBarManager>().isRunningValue(false);
    debug.info(
        'Pupilbase reduced: deleted ${toBeDeletedPupilBase.length} pupils not present in the database, now ${_pupilPersonalData.length} | ${StackTrace.current}');
  }

  importPupilBaseWithWindows() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      addNewPupilBase(rawTextResult);
    } else {
      // User canceled the picker
    }
  }
}
