import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> pickUpTimeDialog(
    BuildContext context, Pupil pupil, String? value) async {
  return await showDialog(
      context: context,
      builder: (context) {
        int dialogDropdownValue = value != null ? int.parse(value) : 0;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        value: dialogDropdownValue,
                        items: const [
                          DropdownMenuItem(
                              value: 0,
                              child: Center(
                                child: Text("kein Eintrag",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 1,
                              child: Center(
                                child: Text("14:00 Uhr",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 2,
                              child: Center(
                                child: Text("15:00 Uhr",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 3,
                              child: Center(
                                child: Text("16:00 Uhr",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            dialogDropdownValue = newvalue!;
                          });
                        }),
                  ),
                ),
              ],
            )),
            title: const Text('OGS-Abholzeit'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    locator<PupilManager>().patchPupil(pupil.internalId,
                        'pick_up_time', dialogDropdownValue.toString());
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
