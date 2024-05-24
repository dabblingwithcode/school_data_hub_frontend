import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_app_bar.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter_impl.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: This is not working
    // pushScope(
    //     init: (locator) => locator
    //         .registerSingleton(locator<PupilManager>().getPupilFilter()));

    bool schooldayEventFiltersOn = watchValue(
        (SchooldayEventFilterManager x) => x.schooldayEventsFiltersOn);

    List<PupilProxy> pupils =
        watchValue((PupilsFilterImplementation x) => x.filteredPupils);
    bool filtersOn = watchValue((PupilsFilterImplementation f) => f.filtersOn);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.warning_amber_rounded, title: 'Ereignisse'),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                const SliverSearchAppBar(
                  height: 110,
                  title: SchooldayEventListSearchBar(),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => SchooldayEventListCard(pupil)),
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
