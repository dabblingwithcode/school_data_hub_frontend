import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';

class MatrixPolicyFilterManager {
  ValueListenable<List<MatrixUser>> get filteredMatrixUsers =>
      _filteredMatrixUsers;
  ValueListenable<List<MatrixRoom>> get filteredMatrixRooms =>
      _filteredMatrixRooms;
  ValueListenable<String> get searchText => _searchText;
  ValueListenable<bool> get filtersOn => _filtersOn;
  final _filteredMatrixUsers = ValueNotifier<List<MatrixUser>>(
      locator<MatrixPolicyManager>().matrixUsers.value);
  final _filteredMatrixRooms = ValueNotifier<List<MatrixRoom>>(
      locator<MatrixPolicyManager>().matrixRooms.value);
  final _searchText = ValueNotifier<String>('');
  final _filtersOn = ValueNotifier<bool>(false);

  MatrixPolicyFilterManager() {
    logger.i('MatrixPolicyFilterManager constructor called');
  }

  resetAllMatrixFilters() {
    _searchText.value = '';
    _filteredMatrixUsers.value =
        locator<MatrixPolicyManager>().matrixUsers.value;
    _filteredMatrixRooms.value =
        locator<MatrixPolicyManager>().matrixRooms.value;
  }

  filterUsersWithSearchText(String text) {
    if (text == '') {
      _searchText.value = text;
      _filteredMatrixUsers.value =
          locator<MatrixPolicyManager>().matrixUsers.value;
      return;
    }
    final List<MatrixUser> matrixUsers =
        List.from(locator<MatrixPolicyManager>().matrixUsers.value);
    List<MatrixUser> filteredMatrixUsers = [];
    filteredMatrixUsers = matrixUsers
        .where((MatrixUser user) =>
            user.displayName.contains(text) || user.id!.contains(text))
        .toList();
    _filteredMatrixUsers.value = filteredMatrixUsers;
  }

  filterRoomsWithSearchText(String text) {
    if (text == '') {
      _searchText.value = text;
      _filteredMatrixRooms.value =
          locator<MatrixPolicyManager>().matrixRooms.value;
      return;
    }
    final List<MatrixRoom> matrixRooms =
        List.from(locator<MatrixPolicyManager>().matrixRooms.value);
    List<MatrixRoom> filteredMatrixRooms = [];
    filteredMatrixRooms = matrixRooms
        .where((MatrixRoom room) =>
            room.name!.contains(text) || room.id.contains(text))
        .toList();
    _filteredMatrixRooms.value = filteredMatrixRooms;
  }
}
