import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_page/attendance_list_page.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_page/attendance_ranking_list_page.dart';
import 'package:schuldaten_hub/features/credit/credit_list_page/credit_list_page.dart';
import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_page/learning_support_list_page.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_page/room_list_page.dart';
import 'package:schuldaten_hub/features/ogs/ogs_list_page.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_page/special_info_list_page.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:watch_it/watch_it.dart';

double buttonSize = 150;

class PupilListButtons extends WatchingWidget {
  final double screenWidth;
  const PupilListButtons({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    bool matrixSessionConfigured = watchValue(
        (SessionManager x) => x.matrixPolicyManagerRegistrationStatus);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const SchooldayEventListPage(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.schooldayEvents,
                      style: const TextStyle(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.missedClasses,
                      style: const TextStyle(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.event_available_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.attendance,
                      style: const TextStyle(
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
                builder: (ctx) => const CreditListPage(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_money_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.pupilCredit,
                      style: const TextStyle(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lightbulb,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.learningLists,
                      style: const TextStyle(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.support_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.supportLists,
                      style: const TextStyle(
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
                builder: (ctx) => const SpecialInfoListPage(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emergency_rounded,
                      size: 50,
                      color: gridViewColor,
                    ),
                    const Gap(10),
                    Text(
                      locale.specialInfo,
                      style: const TextStyle(
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
                builder: (ctx) => const OgsListPage(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      locale.allDayCare,
                      style: const TextStyle(
                          fontSize: 35,
                          color: gridViewColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      locale.allDayCare,
                      style: const TextStyle(
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
                  builder: (ctx) => const RoomListPage(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_rounded,
                        size: 50,
                        color: gridViewColor,
                      ),
                      const Gap(10),
                      Text(
                        locale.matrixRooms,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
