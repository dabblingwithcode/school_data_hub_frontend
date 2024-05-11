import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> languageDialog(
    BuildContext context, Pupil pupil, String type, String? value) async {
  String languageValue = value ?? '000';

  return await showDialog(
      context: context,
      builder: (context) {
        String dropdownUnderstandValue = languageValue.substring(0, 1);
        String dropdownSpeakValue = languageValue.substring(1, 2);
        String dropdownReadValue = languageValue.substring(2, 3);

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: SizedBox(
                width: 700,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.hearing),
                              Gap(5),
                              Text(
                                "Versteht: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    },
                                    value: dropdownUnderstandValue,
                                    items: const [
                                      DropdownMenuItem(
                                          value: '0',
                                          child: Center(
                                            child: Text("nicht",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '1',
                                          child: Center(
                                            child: Text("einfache Anliegen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '2',
                                          child: Center(
                                            child: Text(
                                                "komplexere Informationen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '3',
                                          child: Center(
                                            child: Text("ohne Probleme",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '4',
                                          child: Center(
                                            child: Text("unbekannt",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                    ],
                                    onChanged: (newvalue) {
                                      setState(() {
                                        dropdownUnderstandValue = newvalue!;
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.chat_bubble_outline_rounded),
                              Gap(5),
                              Text("spricht: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    },
                                    value: dropdownSpeakValue,
                                    items: const [
                                      DropdownMenuItem(
                                          value: '0',
                                          child: Center(
                                            child: Text("nicht",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '1',
                                          child: Center(
                                            child: Text("einfache Anliegen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '2',
                                          child: Center(
                                            child: Text(
                                                "komplexere Informationen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '3',
                                          child: Center(
                                            child: Text("ohne Probleme",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '4',
                                          child: Center(
                                            child: Text("unbekannt",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                    ],
                                    onChanged: (newvalue) {
                                      setState(() {
                                        dropdownSpeakValue = newvalue!;
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.book),
                              Gap(5),
                              Text("liest: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              Gap(5),
                            ],
                          ),
                          Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    },
                                    value: dropdownReadValue,
                                    items: const [
                                      DropdownMenuItem(
                                          value: '0',
                                          child: Center(
                                            child: Text("nicht",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '1',
                                          child: Center(
                                            child: Text("einfache Anliegen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '2',
                                          child: Center(
                                            child: Text(
                                                "komplexere Informationen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '3',
                                          child: Center(
                                            child: Text("ohne Probleme",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                      DropdownMenuItem(
                                          value: '4',
                                          child: Center(
                                            child: Text("unbekannt",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: interactiveColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                          )),
                                    ],
                                    onChanged: (newvalue) {
                                      setState(() {
                                        dropdownReadValue = newvalue!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            title: const Text('Kommunikation auf Deutsch'),
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
                    final String communicationValue = dropdownUnderstandValue +
                        dropdownSpeakValue +
                        dropdownReadValue;
                    locator<PupilManager>()
                        .patchPupil(pupil.internalId, type, communicationValue);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
