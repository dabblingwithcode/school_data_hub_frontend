import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_app_bar.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_page/widgets/attendance_ranking_list_card.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_page/widgets/attendance_ranking_list_searchbar.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_page/widgets/attendance_ranking_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListPage extends WatchingWidget {
  const AttendanceRankingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.calendar_month_rounded, title: 'Fehlzeiten'),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverSearchAppBar(
                  height: 110,
                  title: AttendanceRankingListSearchbar(
                      pupils: pupils, filtersOn: filtersOn),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) =>
                        AttendanceRankingListCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          AttendanceRankingListPageBottomNavBar(filtersOn: filtersOn),
    );
  }
}
