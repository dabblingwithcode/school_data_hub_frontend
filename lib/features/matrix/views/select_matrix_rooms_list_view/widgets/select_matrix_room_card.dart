import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/controller/select_matrix_rooms_list_controller.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixRoomCard extends WatchingWidget {
  final SelectMatrixRoomsListController controller;
  final MatrixRoom passedRoom;

  const SelectMatrixRoomCard(this.controller, this.passedRoom, {super.key});
  @override
  Widget build(BuildContext context) {
    List<MatrixRoom> rooms =
        watchValue((MatrixPolicyManager x) => x.matrixRooms);
    final MatrixRoom room =
        rooms.where((element) => element.id == passedRoom.id).first;

    return GestureDetector(
      onLongPress: () => controller.onCardPress(room.id),
      onTap: () =>
          controller.isSelectMode ? controller.onCardPress(room.id) : {},
      child: Card(
          color: controller.selectedRooms.contains(room.id)
              ? const Color.fromARGB(255, 197, 212, 255)
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            room.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Schreibrecht ab:',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            room.eventsDefault!.toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
