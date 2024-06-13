import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_helper_functions.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';
import 'package:schuldaten_hub/features/matrix/pages/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';

class NewMatrixUserView extends StatefulWidget {
  const NewMatrixUserView({super.key});

  @override
  NewMatrixUserViewState createState() => NewMatrixUserViewState();
}

class NewMatrixUserViewState extends State<NewMatrixUserView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  Set<String> roomIds = {};
  //Set<int> pupilIds = {};
  void postNewMatrixUser() async {
    String matrixId = '@${textField1Controller.text}:hermannschule.de';
    String displayName = textField2Controller.text;
    List<String> roomIdsList = roomIds.toList();
    await locator<MatrixPolicyManager>()
        .createNewMatrixUser(matrixId, displayName);

    await locator<MatrixPolicyManager>()
        .addMatrixUserToRooms(matrixId, roomIdsList);
    // await locator<SchoolListManager>()
    //     .postSchoolListWithGroup(text1, text2, pupilIds.toList(), listType);
  }

  @override
  Widget build(BuildContext context) {
    List<MatrixRoom> roomsFromIds = roomsFromRoomIds(roomIds.toList());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Neues Matrix-Konto',
              style: appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Add this
                  children: <Widget>[
                    const Text(
                      '@',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: textField1Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: backgroundColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: backgroundColor, width: 2),
                          ),
                          labelStyle: TextStyle(color: backgroundColor),
                          labelText: 'Matrix-Id',
                        ),
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      ':hermannschule.de',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor, width: 2),
                    ),
                    labelStyle: TextStyle(color: backgroundColor),
                    labelText: 'Anzeigename',
                  ),
                ),
                const Gap(10),
                locator<SessionManager>().isAdmin.value == true
                    ? const Row(
                        children: [
                          Text(
                            'Öffentliche Liste:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Gap(10),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    const Text(
                      'Ausgewählte Räume:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      roomsFromIds.length.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('aus Liste',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: interactiveColor)),
                    ),
                  ],
                ),
                if (roomIds.isEmpty) const Gap(30),
                roomIds.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 15),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: roomsFromIds.length,
                                itemBuilder: (context, int index) {
                                  MatrixRoom listedRoom = roomsFromIds[index];
                                  return Column(
                                    children: [
                                      const Gap(5),
                                      InkWell(
                                        onLongPress: () {
                                          setState(() {
                                            roomIds.remove(listedRoom.id);
                                          });
                                        },
                                        onTap: () {},
                                        child: Card(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  listedRoom.name!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Gap(10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Keine Räume ausgewählt!',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 91, 91, 91),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                if (roomIds.isEmpty) const Spacer(),
                ElevatedButton(
                  style: actionButtonStyle,
                  onPressed: () async {
                    final List<String> selectedRoomIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SelectMatrixRoomsList(
                                  restOfRooms(roomIds.toList())),
                            )) ??
                            [];
                    if (selectedRoomIds.isNotEmpty) {
                      setState(() {
                        roomIds.addAll(selectedRoomIds.toSet());
                      });
                    }
                  },
                  child: const Text(
                    'RÄUME AUSWÄHLEN',
                    style: buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: successButtonStyle,
                  onPressed: () async {
                    postNewMatrixUser();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SENDEN',
                    style: buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
