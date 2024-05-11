import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> preschoolRevisionDialog(
    BuildContext context, PupilProxy pupil, int value) async {
  return await showDialog(
      context: context,
      builder: (context) {
        int dialogdropdownValue = value;

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
                        value: dialogdropdownValue,
                        items: const [
                          DropdownMenuItem(
                              value: 0,
                              child: Center(
                                child: Text("nicht vorhanden",
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
                                child: Text("unauffällig",
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
                                child: Text("Förderbedarf",
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
                                child: Text("AO-SF prüfen",
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
                            dialogdropdownValue = newvalue!;
                          });
                        }),
                  ),
                ),
              ],
            )),
            title: const Text('Eingangsuntersuchung'),
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
                  onTap: () async {
                    locator<PupilManager>().patchPupil(pupil.internalId,
                        'preschool_revision', dialogdropdownValue);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
