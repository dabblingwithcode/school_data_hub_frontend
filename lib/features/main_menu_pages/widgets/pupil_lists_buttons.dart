import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schuldaten_hub/features/attendance/pages/attendance_page/attendance_list_page.dart';
import 'package:schuldaten_hub/features/attendance/pages/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:schuldaten_hub/features/credit/credit_list_page/credit_list_page.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/main_menu_button.dart';
import 'package:schuldaten_hub/features/learning_support/pages/learning_support_list_page/learning_support_list_page.dart';
import 'package:schuldaten_hub/features/matrix/pages/room_list_page/room_list_page.dart';
import 'package:schuldaten_hub/features/ogs/ogs_list_page.dart';
import 'package:schuldaten_hub/features/pupil/pages/special_info_page/special_info_list_page.dart';
import 'package:schuldaten_hub/features/schoolday_events/pages/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:watch_it/watch_it.dart';

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
        MainMenuButton(
            destinationPage: const SchooldayEventListPage(),
            buttonIcon: const Icon(
              Icons.warning_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.schooldayEvents),
        MainMenuButton(
            destinationPage: const MissedClassesPupilListPage(),
            buttonIcon: const Icon(
              Icons.calendar_month_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.missedClasses),
        MainMenuButton(
            destinationPage: const AttendanceListPage(),
            buttonIcon: const Icon(
              Icons.event_available_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.attendance),
        MainMenuButton(
            destinationPage: const CreditListPage(),
            buttonIcon: const Icon(
              Icons.attach_money_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.pupilCredit),
        MainMenuButton(
            // destinationPage: const CategoryList(),
            buttonIcon: const Icon(
              Icons.lightbulb,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.learningLists),
        MainMenuButton(
            destinationPage: const LearningSupportListPage(),
            buttonIcon: const Icon(
              Icons.support_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.supportLists),
        MainMenuButton(
            destinationPage: const SpecialInfoListPage(),
            buttonIcon: const Icon(
              Icons.emergency_rounded,
              size: 50,
              color: gridViewColor,
            ),
            buttonText: locale.specialInfo),
        MainMenuButton(
            destinationPage: const OgsListPage(),
            buttonIcon: Text(
              locale.allDayCare,
              style: const TextStyle(
                  fontSize: 35,
                  color: gridViewColor,
                  fontWeight: FontWeight.bold),
            ),
            buttonText: locale.allDayCare),
        if (matrixSessionConfigured)
          MainMenuButton(
              destinationPage: const RoomListPage(),
              buttonIcon: const Icon(
                Icons.chat_rounded,
                size: 50,
                color: gridViewColor,
              ),
              buttonText: locale.matrixRooms),
      ],
    );
  }
}
