import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_search_app_bar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_page/widgets/special_info_card.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_page/widgets/special_info_list_search_bar.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_page/widgets/special_info_list_page_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

List<PupilProxy> specialInfoFilter(List<PupilProxy> pupils) {
  List<PupilProxy> filteredPupils = [];
  for (PupilProxy pupil in pupils) {
    if (pupil.specialInformation == null || pupil.specialInformation!.isEmpty) {
      locator<PupilsFilter>().setFiltersOnValue(true);
      continue;
    }
    filteredPupils.add(pupil);
  }
  return filteredPupils;
}

class SpecialInfoListPage extends WatchingWidget {
  const SpecialInfoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    List<PupilProxy> filteredPupils =
        watchValue((PupilsFilter x) => x.filteredPupils);
    List<PupilProxy> pupils = specialInfoFilter(filteredPupils);
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emergency_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Besondere Infos',
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
                SliverSearchAppBar(
                  height: 110,
                  title: SpecialInfoListSearchBar(
                      pupils: pupils, filtersOn: filtersOn),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => SpecialInfoCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          SpecialInfoListPageBottomNavBar(filtersOn: filtersOn),
    );
  }
}
