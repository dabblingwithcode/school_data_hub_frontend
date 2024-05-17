import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/services/pupil_goal_filters.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_list_card.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_list_search_bar.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportListPage extends WatchingWidget {
  const LearningSupportListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    // These come from the PupilFilterManager
    List<PupilProxy> filteredPupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    // We want them to go through the learning support filters first
    final List<PupilProxy> pupils = categoryGoalFilteredPupils(filteredPupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Förderung',
              style: appBarTextStyle,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().updatePupilList(pupils),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  scrolledUnderElevation: null,
                  automaticallyImplyLeading: false,
                  leading: const SizedBox.shrink(),
                  backgroundColor: Colors.transparent,
                  collapsedHeight: 120,
                  expandedHeight: 120.0,
                  stretch: false,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    collapseMode: CollapseMode.none,
                    title: LearningSupportListSearchBar(
                        pupils: pupils, filtersOn: filtersOn),
                  ),
                ),
                pupils.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Keine Ergebnisse',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Your list view items go here
                            return LearningSupportCard(pupils[index]);
                          },
                          childCount:
                              pupils.length, // Adjust this based on your data
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          LearningSupportListPageBottomNavBar(filtersOn: filtersOn),
    );
  }
}