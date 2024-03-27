import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_filter_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_list_card.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_list_search_bar.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionListView extends WatchingWidget {
  final AdmonitionListController controller;
  const AdmonitionListView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    bool admonitionFiltersOn =
        watchValue((AdmonitionFilterManager x) => x.admonitionsFiltersOn);
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Ereignisse',
              style: appBarTextStyle,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
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
                  collapsedHeight: 110,
                  expandedHeight: 110.0,
                  stretch: false,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    collapseMode: CollapseMode.none,
                    title: admonitionListSearchBar(
                        context, pupils, controller, filtersOn),
                  ),
                ),
                pupils.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Text('Keine Ergebnisse'),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return AdmonitionListCard(
                                controller, pupils[index]);
                          },
                          childCount: pupils.length,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: admonitionListViewBottomNavBar(
          context, (filtersOn || admonitionFiltersOn) ? true : false),
    );
  }
}
