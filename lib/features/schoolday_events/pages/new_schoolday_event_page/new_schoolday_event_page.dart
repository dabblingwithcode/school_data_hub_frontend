import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class NewSchooldayEventPage extends StatefulWidget {
  final int pupilId;

  const NewSchooldayEventPage({
    super.key,
    required this.pupilId,
  });

  @override
  NewSchooldayEventPageState createState() => NewSchooldayEventPageState();
}

class NewSchooldayEventPageState extends State<NewSchooldayEventPage> {
  String schooldayEventTypeDropdown = 'choose';
  bool violenceAgainstPupils = false;
  bool violenceAgainstTeacher = false;
  bool violenceAgainstThings = false;
  bool insultOthers = false;
  bool annoyOthers = false;
  bool imminentDanger = false;
  bool ignoreTeacherInstructions = false;
  bool disturbLesson = false;
  bool parentTalk = false;
  bool other = false;

  DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  String _getDropdownItemText(String value) {
    switch (value) {
      case 'choose':
        return 'bitte wählen';
      case 'rk':
        return 'rote Karte';
      case 'rkogs':
        return 'rote Karte - OGS';
      case 'rkabh':
        return 'rote Karte + abholen';
      case 'Eg':
        return 'Elterngespräch';
      case 'other':
        return 'sonstiges';
      default:
        return '';
    }
  }

  void postSchooldayEvent(BuildContext context) async {
    Set<String> schooldayEventReason = {};
    String schooldayEventReasons = '';
    if (violenceAgainstPupils == true) {
      schooldayEventReason.add(AdmonitionReason.violenceAgainstPupils.value);
    }
    if (violenceAgainstTeacher == true) {
      schooldayEventReason.add(AdmonitionReason.violenceAgainstTeachers.value);
    }
    if (violenceAgainstThings == true) {
      schooldayEventReason.add(AdmonitionReason.violenceAgainstThings.value);
    }
    if (imminentDanger == true) {
      schooldayEventReason.add(AdmonitionReason.dangerousBehaviour.value);
    }
    if (insultOthers == true) {
      schooldayEventReason.add(AdmonitionReason.insultOthers.value);
    }
    if (annoyOthers == true) {
      schooldayEventReason.add(AdmonitionReason.annoyOthers.value);
    }
    if (ignoreTeacherInstructions == true) {
      schooldayEventReason.add(AdmonitionReason.ignoreInstructions.value);
    }
    if (disturbLesson == true) {
      schooldayEventReason.add(AdmonitionReason.disturbLesson.value);
    }
    if (parentTalk == true) {
      schooldayEventReasons = '${schooldayEventReason}Eg*';
    }
    if (other == true) {
      schooldayEventReason.add(AdmonitionReason.other.value);
    }

    for (final reason in schooldayEventReason) {
      schooldayEventReasons = '$schooldayEventReasons$reason*';
    }
    await locator<SchooldayEventManager>().postSchooldayEvent(widget.pupilId,
        thisDate, schooldayEventTypeDropdown, schooldayEventReasons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: const Text('Neues Ereignis', style: appBarTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ereignis',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                DropdownButton<String>(
                  isDense: true,
                  underline: Container(),
                  style: subtitle,
                  value: schooldayEventTypeDropdown,
                  onChanged: (String? newValue) {
                    setState(() {
                      schooldayEventTypeDropdown = newValue!;
                    });
                  },
                  items: <String>[
                    'choose',
                    'rk',
                    'rkogs',
                    'rkabh',
                    'Eg',
                    'other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        _getDropdownItemText(value),
                        style: TextStyle(
                            color: value == 'choose'
                                ? Colors.red
                                : backgroundColor,
                            fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
                const Gap(10),
                Row(
                  children: [
                    const Text('am', style: subtitle),
                    const Gap(5),
                    IconButton(
                      onPressed: () async {
                        final DateTime? newDate =
                            await selectDate(context, thisDate);
                        if (newDate != null) {
                          setState(() {
                            thisDate = newDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today_rounded,
                          color: backgroundColor),
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? newDate =
                            await selectDate(context, thisDate);
                        if (newDate != null) {
                          setState(() {
                            thisDate = newDate;
                          });
                        }
                      },
                      child: Text(
                        thisDate.formatForUser(),
                        style: title,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Text(
                  'Grund',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '🤜🤕',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Gewalt gegen Menschen',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: violenceAgainstPupils,
                                onSelected: (value) {
                                  setState(() {
                                    violenceAgainstPupils = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  selectedColor:
                                      schooldayEventReasonChipSelectedColor,
                                  checkmarkColor:
                                      schooldayEventReasonChipSelectedCheckColor,
                                  backgroundColor:
                                      schooldayEventReasonChipUnselectedColor,
                                  label: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '🤜🎓️',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      Gap(5),
                                      Text(
                                        'Gewalt gegen Erwachsene',
                                        style: filterItemsTextStyle,
                                      ),
                                    ],
                                  ),
                                  selected: violenceAgainstTeacher,
                                  onSelected: (value) {
                                    setState(() {
                                      violenceAgainstTeacher = value;
                                    });
                                  }),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '🤜🏫',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Gewalt gegen Sachen',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: violenceAgainstThings,
                                onSelected: (value) {
                                  setState(() {
                                    violenceAgainstThings = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '🤬💔',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Beleidigen',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: insultOthers,
                                onSelected: (value) {
                                  setState(() {
                                    insultOthers = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '😈😖',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Ärgern',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: annoyOthers,
                                onSelected: (value) {
                                  setState(() {
                                    annoyOthers = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '🚨😱',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Gefahr für sich/andere',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: imminentDanger,
                                onSelected: (value) {
                                  setState(() {
                                    imminentDanger = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '🎓️🙉',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Anweisungen ignoriert',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: ignoreTeacherInstructions,
                                onSelected: (value) {
                                  setState(() {
                                    ignoreTeacherInstructions = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '🛑🎓️',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Stören von Unterricht',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: disturbLesson,
                                onSelected: (value) {
                                  setState(() {
                                    disturbLesson = value;
                                  });
                                },
                              ),
                              const Gap(5),
                              FilterChip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                selectedColor:
                                    schooldayEventReasonChipSelectedColor,
                                checkmarkColor:
                                    schooldayEventReasonChipSelectedCheckColor,
                                backgroundColor:
                                    schooldayEventReasonChipUnselectedColor,
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(5),
                                    Text(
                                      '📝 ',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Sonstiges',
                                      style: filterItemsTextStyle,
                                    ),
                                  ],
                                ),
                                selected: other,
                                onSelected: (value) {
                                  setState(() {
                                    other = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                ElevatedButton(
                  style: successButtonStyle,
                  onPressed: () {
                    if (schooldayEventTypeDropdown == 'choose') {
                      informationDialog(context, 'Kein Ereignis ausgewählt',
                          'Bitte eine Ereignis-Art auswählen!');
                      return;
                    }
                    if (violenceAgainstPupils == false &&
                        violenceAgainstTeacher == false &&
                        violenceAgainstThings == false &&
                        insultOthers == false &&
                        annoyOthers == false &&
                        imminentDanger == false &&
                        ignoreTeacherInstructions == false &&
                        disturbLesson == false &&
                        other == false) {
                      informationDialog(context, 'Kein Grund ausgewählt',
                          'Bitte mindestens einen Grund auswählen!');
                      return;
                    }
                    postSchooldayEvent(context);
                    Navigator.pop(context);
                  },
                  child: const Text('SENDEN', style: buttonTextStyle),
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

    super.dispose();
  }
}
