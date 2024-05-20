import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filter_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/controller/select_matrix_rooms_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

import 'package:schuldaten_hub/features/credit/credit_list_page/widgets/credit_filter_bottom_sheet.dart';

Widget selectRoomListSearchBar(
    BuildContext context,
    List<MatrixRoom> matrixRooms,
    SelectMatrixRoomsListController controller,
    bool filtersOn) {
  return Container(
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      children: [
        const Gap(5),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.meeting_room_rounded,
                  color: backgroundColor,
                ),
                const Gap(10),
                Text(
                  matrixRooms.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Gap(10),
                const Text(
                  'Ausgewählt:',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const Gap(10),
                Text(
                  controller.selectedRooms.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: SearchTextField(
                      searchType: SearchType.room,
                      hintText: 'Raum suchen',
                      refreshFunction: locator<MatrixPolicyFilterManager>()
                          .filterRoomsWithSearchText)),
              InkWell(
                onTap: () => showCreditFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
                // onPressed: () => showBottomSheetFilters(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
