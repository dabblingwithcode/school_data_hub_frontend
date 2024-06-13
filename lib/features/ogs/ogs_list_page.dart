import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_app_bar.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_search_app_bar.dart';
import 'package:schuldaten_hub/features/ogs/widgets/ogs_list_card.dart';
import 'package:schuldaten_hub/features/ogs/widgets/ogs_list_search_bar.dart';
import 'package:schuldaten_hub/features/ogs/widgets/ogs_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

List<PupilProxy> ogsFilter(List<PupilProxy> pupils) {
  List<PupilProxy> filteredPupils = [];
  for (PupilProxy pupil in pupils) {
    if (!pupil.ogs == true) {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    filteredPupils.add(pupil);
  }
  return filteredPupils;
}

class OgsListPage extends WatchingWidget {
  const OgsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    List<PupilProxy> ogsPupils = ogsFilter(pupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.restaurant_menu_rounded, title: 'OGS Infos'),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<PupilManager>().updatePupilList(ogsPupils),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverSearchAppBar(
                  height: 110,
                  title:
                      OgsListSearchBar(pupils: ogsPupils, filtersOn: filtersOn),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: ogsPupils,
                    itemBuilder: (_, pupil) => OgsCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: OgsListPageBottomNavBar(filtersOn: filtersOn),
    );
  }
}
