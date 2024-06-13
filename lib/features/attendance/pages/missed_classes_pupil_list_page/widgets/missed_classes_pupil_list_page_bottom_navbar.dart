import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/attendance/pages/missed_classes_pupil_list_page/widgets/missed_classes_badges_info_dialog.dart';
import 'package:schuldaten_hub/features/attendance/pages/missed_classes_pupil_list_page/widgets/missed_classes_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListPageBottomNavBar extends WatchingWidget {
  const AttendanceRankingListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
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
                  tooltip: 'Info',
                  icon: const Icon(Icons.info, size: 30),
                  onPressed: () async {
                    missedClassesBadgesInformationDialog(context: context);
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
                    locator<PupilIdentityManager>()
                        .scanNewPupilIdentities(context);
                  },
                ),
                const Gap(30),
                InkWell(
                  onTap: () => showAttendanceRankingFilterBottomSheet(context),
                  onLongPress: () => locator<PupilsFilter>().resetFilters(),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
                const Gap(15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
