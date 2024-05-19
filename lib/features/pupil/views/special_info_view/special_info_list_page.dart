import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/widgets/special_info_card.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/widgets/special_info_list_search_bar.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/widgets/special_info_list_page_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoListPage extends WatchingWidget {
  const SpecialInfoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<PupilProxy> pupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);

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
