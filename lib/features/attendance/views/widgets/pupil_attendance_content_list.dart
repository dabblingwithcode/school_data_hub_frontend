import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_badges.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

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

                locator<SnackBarManager>()
                    .showSnackBar(SnackBarType.success, 'Fehlzeit gelöscht!');
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
