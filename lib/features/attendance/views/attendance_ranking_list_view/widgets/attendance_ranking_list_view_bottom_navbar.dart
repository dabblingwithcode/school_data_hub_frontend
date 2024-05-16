import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/widgets/attendance_ranking_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_personal_data_manager.dart';

class AttendanceRankingListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  const AttendanceRankingListPageBottomNavBar(
      {required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
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
                // IconButton(
                //   tooltip: 'Search',
                //   icon: const Icon(Icons.search),
                //   onPressed: () {},
                // ),
                IconButton(
                  tooltip: 'Scan Kinder-IDs',
                  icon: const Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 30,
                  ),
                  onPressed: () {
                    locator<PupilPersonalDataManager>()
                        .scanNewPupilBase(context);
                  },
                ),
                const Gap(30),
                InkWell(
                  onTap: () => showAttendanceRankingFilterBottomSheet(context),
                  onLongPress: () =>
                      locator<PupilFilterManager>().resetFilters(),
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
      ),
    );
  }
}
