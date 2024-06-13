import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';

List<Widget> roomsList(
    MatrixUser matrixUser, List<MatrixRoom> matrixRooms, BuildContext context) {
  List<MatrixRoom> namedMatrixRooms =
      locator<MatrixPolicyManager>().matrixRooms.value;

  return [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: successButtonStyle,
          onPressed: () async {
            // changeCreditDialog(context, pupil);
          },
          child: const Text(
            "RÄUME ÄNDERN",
            style: buttonTextStyle,
          ),
        ),
      ),
    ),
    const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Räume:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
    const Gap(5),
    ListView.builder(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: matrixRooms.length,
      itemBuilder: (BuildContext context, int index) {
        int powerLevel = 0;
        final List<MatrixRoom> matrixRoomList = List.from(matrixRooms);
        MatrixRoom matrixRoom = namedMatrixRooms
            .firstWhere((element) => element.id == matrixRoomList[index].id);
        RoomAdmin? admin = matrixRoom.roomAdmins!
            .firstWhereOrNull((element) => element.id == matrixUser.id);
        if (admin != null) {
          powerLevel = admin.powerLevel;
        }
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {
              //- TO-DO: change missed class function
              //- like _changeMissedClassHermannpupilPage
            },
            onLongPress: () async {},
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      matrixRoom.name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(5),
                    powerLevel > 99
                        ? const Icon(Icons.star, color: Colors.yellow, size: 20)
                        : powerLevel > 49
                            ? const Icon(Icons.chat,
                                color: Colors.orange, size: 20)
                            : powerLevel > 29
                                ? const Icon(Icons.remove_red_eye_outlined,
                                    color: groupColor, size: 20)
                                : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ];
}
