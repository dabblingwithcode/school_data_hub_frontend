import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_list_card.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_list_page_bottom_navbar.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_list_page_search_bar.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventPage extends WatchingStatefulWidget {
  const SchooldayEventPage({Key? key}) : super(key: key);

  @override
  State<SchooldayEventPage> createState() => _SchooldayEventPageState();
}

class _SchooldayEventPageState extends State<SchooldayEventPage> {
  late final pupilsFilter = locator<PupilManager>().getPupilFilter();

  @override
  Widget build(BuildContext context) {
    bool schooldayEventFiltersOn = watchValue(
        (SchooldayEventFilterManager x) => x.schooldayEventsFiltersOn);

    List<PupilProxy> pupils = watch(pupilsFilter.filteredPupils).value;
    bool filtersOn =
        watchPropertyValue((f) => f.filtersOn, target: pupilsFilter);

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
                      title: SchooldayEventListSearchBar(pupilsFilter)),
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
                            return SchooldayEventListCard(pupils[index]);
                          },
                          childCount: pupils.length,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SchooldayEventListPageBottomNavBar(
          filtersOn: (filtersOn || schooldayEventFiltersOn) ? true : false),
    );
  }
}
