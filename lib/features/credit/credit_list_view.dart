import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/credit/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/credit/widgets/credit_list_card.dart';
import 'package:schuldaten_hub/features/credit/widgets/credit_list_searchbar.dart';
import 'package:schuldaten_hub/features/credit/widgets/credit_list_view_bottom_navbar.dart';

import 'package:watch_it/watch_it.dart';

class CreditListView extends WatchingWidget {
  final CreditListController controller;
  final int userCredit;
  final bool filtersOn;
  final List<PupilProxy> pupils;
  const CreditListView(
      this.controller, this.userCredit, this.filtersOn, this.pupils,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debug.info('Widget Build started!');

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.credit_card,
              size: 25,
              color: Colors.white,
            ),
            const Gap(10),
            Text(
              'Guthaben: $userCredit',
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
                    title: creditListSearchBar(
                        context, pupils, controller, filtersOn),
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
                            return CreditListCard(controller, pupils[index]);
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
      bottomNavigationBar: creditListViewBottomNavBar(context, filtersOn),
    );
  }
}
