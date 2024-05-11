import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filters_manager.dart';

import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_view/room_list_view.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class RoomList extends WatchingStatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  RoomListController createState() => RoomListController();
}

class RoomListController extends State<RoomList> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    List<MatrixUser> matrixUsers = watchValue(
      (MatrixPolicyManager x) => x.matrixUsers,
    );
    List<MatrixRoom> matrixRooms = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixRooms,
    );
    return RoomListView(this, filtersOn, matrixUsers, matrixRooms);
  }
}
