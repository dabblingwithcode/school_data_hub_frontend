import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';

List<Widget> usersInRoomList(
    List<MatrixUser> matrixUsers, BuildContext context) {
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
            "BERECHTIGUNGEN ÄNDERN",
            style: buttonTextStyle,
          ),
        ),
      ),
    ),
    const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   'Räume:',
        //   style: TextStyle(fontSize: 18.0),
        //   textAlign: TextAlign.left,
        // ),
        Gap(5),
        // Text(pupil.creditEarned.toString(),
        //     style:
        //         const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Konten:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
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
      itemCount: matrixUsers.length,
      itemBuilder: (BuildContext context, int index) {
        final List<MatrixUser> matrixUserList = List.from(matrixUsers);
        MatrixUser matrixUser = matrixUserList[index];
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {},
            onLongPress: () async {},
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      matrixUser.displayName!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
