import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';

enrollmentListTiles(context, StatisticsController controller) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: [
            const Text(
              'Unterjährige Anmeldungen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Gap(10),
            Text(
              controller
                  .pupilsNotEnrolledOnDate(controller.pupils)
                  .length
                  .toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        children: [
          Row(
            children: [
              const Text(
                'im laufenden Schulahr:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              Text(
                controller
                    .pupilsEnrolledAfterDate(
                        DateFormat('yyy-MM-dd').parse('2023-08-01'))
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'im letzten Schulahr:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              Text(
                controller
                    .pupilsEnrolledBetweenDates(
                        DateFormat('yyy-MM-dd').parse('2022-08-02'),
                        DateFormat('yyy-MM-dd').parse('2023-07-31'))
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          // ListView.builder(
          //   padding: EdgeInsets.only(left: 10, top: 5, bottom: 15),
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: sortedLanguageOccurrences.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     final entry = sortedLanguageOccurrences[index];
          //     final language = entry.key;
          //     final occurrences = entry.value;
          //     return Padding(
          //       padding: const EdgeInsets.all(5.0),
          //       child: GestureDetector(
          //         onTap: () {
          //           //- TO-DO: change missed class function
          //           //- like _changeMissedClassHermannpupilPage
          //         },
          //         onLongPress: () async {},
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Row(
          //             children: [
          //               Text(
          //                 "$language:",
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Gap(10),
          //               Text(
          //                 "$occurrences",
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ]),
  );
}
