import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_app_bar.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/learning_support/services/pupil_goal_filters.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_list_card.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_list_search_bar.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportListPage extends WatchingWidget {
  const LearningSupportListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    // These come from the PupilFilterManager
    List<PupilProxy> filteredPupils =
        watchValue((PupilsFilter x) => x.filteredPupils);
    // We want them to go through the learning support filters first
    final List<PupilProxy> pupils = categoryGoalFilteredPupils(filteredPupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.support_rounded, title: 'Förderung'),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().updatePupilList(pupils),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverSearchAppBar(
                  height: 110,
                  title: LearningSupportListSearchBar(
                      pupils: pupils, filtersOn: filtersOn),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => LearningSupportCard(pupil)),
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
