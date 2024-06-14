import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event_enums.dart';
import 'package:schuldaten_hub/features/schoolday_events/pages/new_schoolday_event_page/widgets/schoolday_event_filter_chip.dart';
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
  SchooldayEventType schooldayEventTypeDropdown = SchooldayEventType.notSet;
  bool violenceAgainstPupils = false;
  bool violenceAgainstTeacher = false;
  bool violenceAgainstThings = false;
  bool insultOthers = false;
  bool annoyOthers = false;
  bool imminentDanger = false;
  bool ignoreTeacherInstructions = false;
  bool disturbLesson = false;
  bool other = false;
  bool learningDevelopmentInfo = false;
  bool learningSupportInfo = false;
  bool admonitionInfo = false;

  DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  String _getDropdownItemText(SchooldayEventType reason) {
    switch (reason) {
      case SchooldayEventType.notSet:
        return 'bitte wählen';
      case SchooldayEventType.admonition:
        return 'rote Karte';
      case SchooldayEventType.afternoonCareAdmonition:
        return 'rote Karte - OGS';
      case SchooldayEventType.admonitionAndBanned:
        return 'rote Karte + abholen';
      case SchooldayEventType.parentsMeeting:
        return 'Elterngespräch';
      case SchooldayEventType.otherEvent:
        return 'sonstiges';
      default:
        return '';
    }
  }

  Future<void> postSchooldayEvent() async {
    Set<String> schooldayEventReason = {};
    String schooldayEventReasons = '';
    if (violenceAgainstPupils == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstPupils.value);
    }
    if (violenceAgainstTeacher == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstTeachers.value);
    }
    if (violenceAgainstThings == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstThings.value);
    }
    if (imminentDanger == true) {
      schooldayEventReason.add(SchooldayEventReason.dangerousBehaviour.value);
    }
    if (insultOthers == true) {
      schooldayEventReason.add(SchooldayEventReason.insultOthers.value);
    }
    if (annoyOthers == true) {
      schooldayEventReason.add(SchooldayEventReason.annoyOthers.value);
    }
    if (ignoreTeacherInstructions == true) {
      schooldayEventReason.add(SchooldayEventReason.ignoreInstructions.value);
    }
    if (disturbLesson == true) {
      schooldayEventReason.add(SchooldayEventReason.disturbLesson.value);
    }
    if (learningDevelopmentInfo == true) {
      schooldayEventReason
          .add(SchooldayEventReason.learningDevelopmentInfo.value);
    }
    if (learningSupportInfo == true) {
      schooldayEventReason.add(SchooldayEventReason.learningSupportInfo.value);
    }
    if (admonitionInfo == true) {
      schooldayEventReason.add(SchooldayEventReason.admonitionInfo.value);
    }
    if (other == true) {
      schooldayEventReason.add(SchooldayEventReason.other.value);
    }

    for (final reason in schooldayEventReason) {
      schooldayEventReasons = '$schooldayEventReasons$reason*';
    }
    await locator<SchooldayEventManager>().postSchooldayEvent(widget.pupilId,
        thisDate, schooldayEventTypeDropdown.value, schooldayEventReasons);
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
                DropdownButton<SchooldayEventType>(
                  isDense: true,
                  underline: Container(),
                  style: subtitle,
                  value: schooldayEventTypeDropdown,
                  onChanged: (SchooldayEventType? newValue) {
                    setState(() {
                      schooldayEventTypeDropdown = newValue!;
                    });
                  },
                  items: SchooldayEventType.values
                      .map<DropdownMenuItem<SchooldayEventType>>(
                          (SchooldayEventType value) {
                    return DropdownMenuItem<SchooldayEventType>(
                      value: value,
                      child: Text(
                        _getDropdownItemText(value),
                        style: TextStyle(
                            color: value == SchooldayEventType.notSet
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
                            await selectSchooldayDate(context, thisDate);
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
                            await selectSchooldayDate(context, thisDate);
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
                  child: schooldayEventTypeDropdown == SchooldayEventType.notSet
                      ? const Center(
                          child: Text(
                          'Bitte eine Ereignis-Art auswählen!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))
                      : schooldayEventTypeDropdown ==
                              SchooldayEventType.parentsMeeting
                          ? SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: learningDevelopmentInfo,
                                    onSelected: (value) {
                                      setState(() {
                                        learningDevelopmentInfo = value;
                                      });
                                    },
                                    emojis: '💡🧠',
                                    text: 'Lernentwicklungsgespräch',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: learningSupportInfo,
                                    onSelected: (value) {
                                      setState(() {
                                        learningSupportInfo = value;
                                      });
                                    },
                                    emojis: '🛟🧠',
                                    text: 'Fördergespräch',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: admonitionInfo,
                                    onSelected: (value) {
                                      setState(() {
                                        admonitionInfo = value;
                                      });
                                    },
                                    emojis: '⚠️ℹ️',
                                    text: 'Regelverstoß',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: other,
                                    onSelected: (value) {
                                      setState(() {
                                        other = value;
                                      });
                                    },
                                    emojis: '📝',
                                    text: 'Sonstiges',
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: violenceAgainstPupils,
                                    onSelected: (value) {
                                      setState(() {
                                        violenceAgainstPupils = value;
                                      });
                                    },
                                    emojis: '🤜🤕',
                                    text: 'Gewalt gegen Kinder',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: violenceAgainstTeacher,
                                    onSelected: (value) {
                                      setState(() {
                                        violenceAgainstTeacher = value;
                                      });
                                    },
                                    emojis: '🤜🎓️',
                                    text: 'Gewalt gegen Erwachsene',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: violenceAgainstThings,
                                    onSelected: (value) {
                                      setState(() {
                                        violenceAgainstThings = value;
                                      });
                                    },
                                    emojis: '🤜🏫',
                                    text: 'Gewalt gegen Sachen',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: insultOthers,
                                    onSelected: (value) {
                                      setState(() {
                                        insultOthers = value;
                                      });
                                    },
                                    emojis: '🤬💔',
                                    text: 'Beleidigen',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: annoyOthers,
                                    onSelected: (value) {
                                      setState(() {
                                        annoyOthers = value;
                                      });
                                    },
                                    emojis: '😈😖',
                                    text: 'Ärgern',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: imminentDanger,
                                    onSelected: (value) {
                                      setState(() {
                                        imminentDanger = value;
                                      });
                                    },
                                    emojis: '🚨😱',
                                    text: 'Gefahr für sich/andere',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: ignoreTeacherInstructions,
                                    onSelected: (value) {
                                      setState(() {
                                        ignoreTeacherInstructions = value;
                                      });
                                    },
                                    emojis: '🎓️🙉',
                                    text: 'Anweisungen ignorieren',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: disturbLesson,
                                    onSelected: (value) {
                                      setState(() {
                                        disturbLesson = value;
                                      });
                                    },
                                    emojis: '🛑🎓️',
                                    text: 'Unterricht stören',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: other,
                                    onSelected: (value) {
                                      setState(() {
                                        other = value;
                                      });
                                    },
                                    emojis: '📝',
                                    text: 'Sonstiges',
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ),
                ),
                const Gap(10),
                ElevatedButton(
                  style: successButtonStyle,
                  onPressed: () async {
                    if (schooldayEventTypeDropdown ==
                        SchooldayEventType.notSet) {
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
                        learningDevelopmentInfo == false &&
                        learningSupportInfo == false &&
                        admonitionInfo == false &&
                        other == false) {
                      informationDialog(context, 'Kein Grund ausgewählt',
                          'Bitte mindestens einen Grund auswählen!');
                      return;
                    }
                    unawaited(postSchooldayEvent());
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
