import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/attendance_ranking_list_page.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/attendance_list_page.dart';
import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_view/learning_support_list_page.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:schuldaten_hub/features/credit/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_view/controller/room_list_controller.dart';
import 'package:schuldaten_hub/features/ogs/controller/ogs_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/controller/special_info_controller.dart';

double buttonSize = 150;
List<Widget> pupilListButtons(
    BuildContext context, double screenWidth, bool matrixSessionConfigured) {
  return [
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const SchooldayEventPage(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Ereignisse',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const AttendanceRankingListPage(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Fehlzeiten',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const AttendanceListPage(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_available_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Anwesenheit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const CreditList(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Konto',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (ctx) => CategoryList(),
              // ));
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lightbulb,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Lernen',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const LearningSupportListPage(),
              ));
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.support_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Fördern',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const SpecialInfoList(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emergency_rounded,
                  size: 50,
                  color: gridViewColor,
                ),
                Gap(10),
                Text(
                  'Besondere Infos',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const OgsList(),
          ));
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OGS',
                  style: TextStyle(
                      fontSize: 35,
                      color: gridViewColor,
                      fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Text(
                  'OGS',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    if (matrixSessionConfigured)
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const RoomList(),
            ));
          },
          child: SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_rounded,
                    size: 50,
                    color: gridViewColor,
                  ),
                  Gap(10),
                  Text(
                    'Matrix-Räume',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
  ];
}
