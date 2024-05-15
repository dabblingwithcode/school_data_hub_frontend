import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventFilterBottomSheet extends WatchingWidget {
  const SchooldayEventFilterBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
    final Map<SchooldayEventFilter, bool> activeSchooldayEventFilters =
        watchValue(
            (SchooldayEventFilterManager x) => x.schooldayEventsFilterState);
    bool valueLastSevenDays =
        activeSchooldayEventFilters[SchooldayEventFilter.sevenDays]!;
    // event type
    bool valueProcessed =
        activeSchooldayEventFilters[SchooldayEventFilter.processed]!;
    bool valueRedCard =
        activeSchooldayEventFilters[SchooldayEventFilter.redCard]!;
    bool valueRedCardOgs =
        activeSchooldayEventFilters[SchooldayEventFilter.redCardOgs]!;
    bool valueRedCardSentHome =
        activeSchooldayEventFilters[SchooldayEventFilter.redCardsentHome]!;
    bool valueParentsMeeting =
        activeSchooldayEventFilters[SchooldayEventFilter.parentsMeeting]!;
    bool valueOtherEvents =
        activeSchooldayEventFilters[SchooldayEventFilter.otherEvent]!;

    // sort mode
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;
    bool valueSortBySchooldayEvents =
        sortMode[PupilSortMode.sortBySchooldayEvents]!;
    bool valueSortByLastSchooldayEvent =
        sortMode[PupilSortMode.sortByLastSchooldayEvent]!;
    final filterLocator = locator<PupilFilterManager>();
    final schooldayEventFilterLocator = locator<SchooldayEventFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              filterHeading(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    standardFilters(activeFilters),
                    const Row(
                      children: [
                        Text(
                          'Ereignisse',
                          style: subtitle,
                        )
                      ],
                    ),
                    const Gap(5),
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            '7 Tage',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueLastSevenDays,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                SchooldayEventFilter.sevenDays, val);
                            valueLastSevenDays = schooldayEventFilterLocator
                                .schooldayEventsFilterState
                                .value[SchooldayEventFilter.sevenDays]!;
                            // valueLastSevenDays =  schooldayEventFilterLocator.
                            //     .sortMode.value[PupilSortMode.sortByName]!;
                            // filterLocator.sortPupils();
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'nicht bearbeitet',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueProcessed,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                SchooldayEventFilter.processed, val);
                            valueProcessed = schooldayEventFilterLocator
                                .schooldayEventsFilterState
                                .value[SchooldayEventFilter.processed]!;
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Icon(Icons.rectangle_rounded,
                              color: Colors.red),
                          selected: valueRedCard,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                SchooldayEventFilter.redCard, val);
                            valueRedCard = schooldayEventFilterLocator
                                .schooldayEventsFilterState
                                .value[SchooldayEventFilter.redCard]!;
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.rectangle_rounded, color: Colors.red),
                              Gap(5),
                              Text('OGS', style: filterItemsTextStyle),
                            ],
                          ),
                          selected: valueRedCardOgs,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                SchooldayEventFilter.redCardOgs, val);
                            valueRedCardOgs = schooldayEventFilterLocator
                                .schooldayEventsFilterState
                                .value[SchooldayEventFilter.redCardOgs]!;
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.rectangle_rounded, color: Colors.red),
                              Gap(5),
                              Icon(Icons.home, color: Colors.white),
                            ],
                          ),
                          selected: valueRedCardSentHome,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                SchooldayEventFilter.redCardsentHome, val);
                            valueRedCardOgs = schooldayEventFilterLocator
                                .schooldayEventsFilterState
                                .value[SchooldayEventFilter.redCardsentHome]!;
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    const Row(
                      children: [
                        Text(
                          'Sortieren',
                          style: subtitle,
                        )
                      ],
                    ),
                    const Gap(5),
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'A-Z',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueSortByName,
                          onSelected: (val) {
                            filterLocator.setSortMode(
                                PupilSortMode.sortByName, val);
                            valueSortByName = filterLocator
                                .sortMode.value[PupilSortMode.sortByName]!;
                            filterLocator.sortPupils();
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'Anzahl',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueSortBySchooldayEvents,
                          onSelected: (val) {
                            filterLocator.setSortMode(
                                PupilSortMode.sortBySchooldayEvents, val);
                            valueSortBySchooldayEvents = filterLocator.sortMode
                                .value[PupilSortMode.sortBySchooldayEvents]!;
                            filterLocator.sortPupils();
                          },
                        ),
                        FilterChip(
                          padding: filterChipPadding,
                          labelPadding: filterChipLabelPadding,
                          shape: filterChipShape,
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'zuletzt',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueSortByLastSchooldayEvent,
                          onSelected: (val) {
                            filterLocator.setSortMode(
                                PupilSortMode.sortByLastSchooldayEvent, val);
                            valueSortBySchooldayEvents = filterLocator.sortMode
                                .value[PupilSortMode.sortByLastSchooldayEvent]!;
                            filterLocator.sortPupils();
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSchooldayEventFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const SchooldayEventFilterBottomSheet(),
  );
}
