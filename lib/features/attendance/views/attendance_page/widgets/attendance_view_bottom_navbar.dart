import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_page/widgets/attendance_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_personal_data_manager.dart';

class AttendanceListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  final DateTime thisDate;
  const AttendanceListPageBottomNavBar(
      {required this.filtersOn, required this.thisDate, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Scan Kinder-IDs',
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 30,
                ),
                onPressed: () {
                  locator<PupilPersonalDataManager>().scanNewPupilBase(context);
                },
              ),
              const Gap(30),
              InkWell(
                onTap: () async {
                  final DateTime? newDate = await selectDate(context, thisDate);
                  if (newDate != null) {
                    locator<SchooldayManager>().setThisDate(newDate);
                  }
                },
                onLongPress: () => locator<SchooldayManager>().getThisDate(),
                child: const Icon(
                  Icons.today_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Gap(30),
              InkWell(
                onTap: () => showAttendanceFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(10)
            ],
          ),
        ),
      ),
    );
  }
}
