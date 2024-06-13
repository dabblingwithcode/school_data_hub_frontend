import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/filter_button.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/schoolday_events/filters/schoolday_event_filter_manager.dart';

import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_helper_functions.dart';
import 'package:schuldaten_hub/features/schoolday_events/pages/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventListSearchBar extends WatchingWidget {
  const SchooldayEventListSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    //- TODO: these are not used, but somehow it seems we need them there to trigger a rebuild when they change
    // ignore: unused_local_variable
    final filtersOn = watchValue((PupilsFilter f) => f.filtersOn);
    // ignore: unused_local_variable
    final schooldayEventsFilter = watchValue(
        (SchooldayEventFilterManager x) => x.schooldayEventsFilterState);

    // Let's get the total numbers for the schoolday events variants
    final SchooldayEventsCount schooldayEventsCount =
        SchoolDayEventHelper.getSchooldayEventsCount(pupils);

    return Container(
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.00),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_alt_rounded,
                      color: backgroundColor,
                    ),
                    const Gap(5),
                    Text(
                      pupils.length.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text('🗂️'),
                    const Gap(5),
                    Text(
                      schooldayEventsCount.totalSchooldayEvents.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Icon(
                      Icons.school_rounded,
                      color: Colors.red,
                    ),
                    const Gap(5),
                    Text(
                      schooldayEventsCount.totalLessonSchooldayEvents
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'OGS',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(5),
                    Text(
                        schooldayEventsCount.totalOgsSchooldayEvents.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Gap(10),
                    const Icon(
                      Icons.home_rounded,
                      color: Colors.red,
                    ),
                    const Gap(5),
                    Text(
                        schooldayEventsCount.totalSentHomeSchooldayEvents
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Gap(10),
                    const Text(
                      '👪️',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Gap(5),
                    Text(
                        schooldayEventsCount.totalParentsMeetingSchooldayEvents
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                    child: SearchTextField(
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: locator<PupilsFilter>().refreshs)),
                const FilterButton(
                    isSearchBar: true,
                    showBottomSheetFunction:
                        showSchooldayEventFilterBottomSheet),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
