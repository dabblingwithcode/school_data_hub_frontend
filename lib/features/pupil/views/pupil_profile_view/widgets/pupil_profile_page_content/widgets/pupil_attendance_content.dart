import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_page/controller/attendance_ranking_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_badges.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_stats_pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilAttendanceContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilAttendanceContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    List<MissedClass> missedClasses = List.from(pupil.pupilMissedClasses!);
    // sort by missedDay
    missedClasses.sort((b, a) => a.missedDay.compareTo(b.missedDay));
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(
              Icons.calendar_month_rounded,
              color: Colors.grey[700],
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AttendanceRankingList(),
                ));
              },
              child: const Text('Fehlzeiten',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            )
          ]),
          const Gap(15),
          attendanceStats(pupil),
          const Gap(10),
          ListView.builder(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: missedClasses.length,
            itemBuilder: (BuildContext context, int index) {
              // pupil.pupilMissedClasses.sort(
              //     (a, b) => a.missedDay.compareTo(b.missedDay));

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: cardInCardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      //- TO-DO: change missed class function
                    },
                    onLongPress: () async {
                      bool? confirm = await confirmationDialog(context,
                          'Fehlzeit löschen', 'Die Fehlzeit löschen?');
                      if (confirm != true) return;
                      await locator<AttendanceManager>().deleteMissedClass(
                          pupil.internalId, missedClasses[index].missedDay);

                      locator<NotificationManager>().showSnackBar(
                          NotificationType.success, 'Fehlzeit gelöscht!');
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd.MM.yyyy')
                                  .format(missedClasses[index].missedDay)
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const Gap(5),
                            missedTypeBadge(missedClasses[index].missedType),
                            const Gap(3),
                            excusedBadge(missedClasses[index].excused),
                            const Gap(3),
                            contactedDayBadge(missedClasses[index].contacted),
                            const Gap(3),
                            returnedBadge(missedClasses[index].returned),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (missedClasses[index].missedType == 'late')
                              Row(
                                children: [
                                  const Text('Verspätung:'),
                                  const Gap(5),
                                  Text(
                                      '${missedClasses[index].minutesLate ?? 0} min',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            const Gap(10),
                            if (missedClasses[index].returned == true)
                              RichText(
                                  text: TextSpan(
                                text: 'abgeholt um: ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: missedClasses[index].returnedAt,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('erstellt von:'),
                            const Gap(5),
                            Text(
                              missedClasses[index].createdBy,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            if (missedClasses[index].modifiedBy != null)
                              const Text('zuletzt geändert von: '),
                            if (missedClasses[index].modifiedBy != null)
                              Text(
                                missedClasses[index].createdBy,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

List<Widget> pupilAttendanceContentList(PupilProxy pupil, context) {
  List<MissedClass> missedClasses = List.from(pupil.pupilMissedClasses!);
  // sort by missedDay
  missedClasses.sort((b, a) => a.missedDay.compareTo(b.missedDay));
  return [
    ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missedClasses.length,
      itemBuilder: (BuildContext context, int index) {
        // pupil.pupilMissedClasses.sort(
        //     (a, b) => a.missedDay.compareTo(b.missedDay));

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: cardInCardColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                //- TO-DO: change missed class function
              },
              onLongPress: () async {
                bool? confirm = await confirmationDialog(
                    context, 'Fehlzeit löschen', 'Die Fehlzeit löschen?');
                if (confirm != true) return;
                await locator<AttendanceManager>().deleteMissedClass(
                    pupil.internalId, missedClasses[index].missedDay);

                locator<NotificationManager>().showSnackBar(
                    NotificationType.success, 'Fehlzeit gelöscht!');
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy')
                            .format(missedClasses[index].missedDay)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(5),
                      missedTypeBadge(missedClasses[index].missedType),
                      const Gap(3),
                      excusedBadge(missedClasses[index].excused),
                      const Gap(3),
                      contactedDayBadge(missedClasses[index].contacted),
                      const Gap(3),
                      returnedBadge(missedClasses[index].returned),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (missedClasses[index].missedType == 'late')
                        Row(
                          children: [
                            const Text('Verspätung:'),
                            const Gap(5),
                            Text('${missedClasses[index].minutesLate ?? 0} min',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      const Gap(10),
                      if (missedClasses[index].returned == true)
                        RichText(
                            text: TextSpan(
                          text: 'abgeholt um: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: missedClasses[index].returnedAt,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('erstellt von:'),
                      const Gap(5),
                      Text(
                        missedClasses[index].createdBy,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (missedClasses[index].modifiedBy != null)
                        const Text('zuletzt geändert von: '),
                      if (missedClasses[index].modifiedBy != null)
                        Text(
                          missedClasses[index].createdBy,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  ];
}