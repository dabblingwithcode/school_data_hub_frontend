import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

final GlobalKey<FormState> _missedDatesformKey = GlobalKey<FormState>();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> createMissedClassList(
    BuildContext context, PupilProxy pupil) async {
  final DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  return await showDialog(
      context: context,
      builder: (context) {
        // final schooldayManager = locator<SchooldayManager>();
        // schooldayManager.setStartDate(thisDate);
        // schooldayManager.setEndDate(thisDate);
        String dialogdropdownValue = 'missed';
        DateTime startDate = thisDate;
        DateTime endDate = thisDate;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _missedDatesformKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            value: dialogdropdownValue,
                            items: [
                              DropdownMenuItem(
                                  value: 'missed',
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text("F",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          )),
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: 'home',
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text("H",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          )),
                                    ),
                                  )),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dialogdropdownValue = newvalue!;
                              });
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () async {
                            final date = await selectDate(context, thisDate);
                            setState(() {
                              startDate = date;
                            });
                          },
                          child: Text(
                            'von ${startDate.formatForUser()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () async {
                            final date = await selectDate(context, thisDate);
                            setState(() {
                              endDate = date;
                            });
                          },
                          child: Text(
                            'bis ${endDate.formatForUser()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )),
                    ),
                  ],
                )),
            title: const Text('Mehrere Einträge'),
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
                  onTap: () {
                    if (_missedDatesformKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
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
                    if (_missedDatesformKey.currentState!.validate()) {
                      locator<AttendanceManager>().createManyMissedClasses(
                          pupil.internalId,
                          startDate,
                          endDate,
                          dialogdropdownValue);
                      _missedDatesformKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          );
        });
      });
}
