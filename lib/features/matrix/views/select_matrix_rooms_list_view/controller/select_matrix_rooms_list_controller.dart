import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filters_manager.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_helper_functions.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/select_matrix_rooms_list_view.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

import 'package:watch_it/watch_it.dart';

class SelectMatrixRoomsList extends WatchingStatefulWidget {
  final List<String>? selectableRooms;
  const SelectMatrixRoomsList(this.selectableRooms, {super.key});

  @override
  SelectMatrixRoomsListController createState() =>
      SelectMatrixRoomsListController();
}

class SelectMatrixRoomsListController extends State<SelectMatrixRoomsList> {
  List<MatrixRoom>? rooms;
  List<MatrixRoom>? filteredRooms;
  Map<PupilFilter, bool>? inheritedFilters;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<String> selectedRooms = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    //locator<PupilFilterManager>().refreshFilteredPupils();
    setState(() {
      inheritedFilters = locator<PupilFilterManager>().filterState.value;
      rooms = locator<MatrixPolicyManager>().matrixRooms.value;
    });
    super.initState();
  }

  void cancelSelect() {
    setState(() {
      selectedRooms.clear();
      isSelectMode = false;
    });
  }

  void onCardPress(String roomId) {
    if (selectedRooms.contains(roomId)) {
      setState(() {
        selectedRooms.remove(roomId);
        if (selectedRooms.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedRooms.add(roomId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedRooms.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<MatrixRoom> shownRooms =
            locator<MatrixPolicyFilterManager>().filteredMatrixRooms.value;
        isSelectMode = true;
        selectedRooms = shownRooms.map((room) => room.id).toList();
      } else {
        isSelectMode = false;
        selectedRooms.clear();
      }
    });
  }

  List<String> getSelectedPupilIds() {
    return selectedRooms.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<MatrixRoom> rooms =
        watchValue((MatrixPolicyManager x) => x.matrixRooms);
    List<MatrixRoom> filteredRooms =
        watchValue((MatrixPolicyFilterManager x) => x.filteredMatrixRooms);

    List<MatrixRoom> filteredListedRooms =
        roomsFromRoomIds(widget.selectableRooms!)
            .where((room) => filteredRooms.contains(room))
            .toList();
    return SelectMatrixRoomsListView(this, filteredListedRooms);
  }
}
