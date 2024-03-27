import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionFilterBottomSheet extends WatchingWidget {
  const AdmonitionFilterBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
    final Map<AdmonitionFilter, bool> activeAdmonitionFilters =
        watchValue((AdmonitionFilterManager x) => x.admonitionsFilterState);
    bool valueLastSevenDays =
        activeAdmonitionFilters[AdmonitionFilter.sevenDays]!;
    // event type
    bool valueProcessed = activeAdmonitionFilters[AdmonitionFilter.processed]!;
    bool valueRedCard = activeAdmonitionFilters[AdmonitionFilter.redCard]!;
    bool valueRedCardOgs =
        activeAdmonitionFilters[AdmonitionFilter.redCardOgs]!;
    bool valueRedCardSentHome =
        activeAdmonitionFilters[AdmonitionFilter.redCardsentHome]!;
    bool valueParentsMeeting =
        activeAdmonitionFilters[AdmonitionFilter.parentsMeeting]!;
    bool valueOtherEvents =
        activeAdmonitionFilters[AdmonitionFilter.otherEvent]!;

    // sort mode
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;
    bool valueSortByAdmonitions = sortMode[PupilSortMode.sortByAdmonitions]!;
    bool valueSortByLastAdmonition =
        sortMode[PupilSortMode.sortByLastAdmonition]!;
    final filterLocator = locator<PupilFilterManager>();
    final admonitionFilterLocator = locator<AdmonitionFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Spacer(),
                  IconButton.filled(
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () {
                        locator<PupilFilterManager>().resetFilters();

                        //Navigator.pop(context);
                      },
                      icon: const Icon(Icons.restart_alt_rounded)),
                ],
              ),
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
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            '7 Tage',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueLastSevenDays,
                          onSelected: (val) {
                            admonitionFilterLocator.setFilter(
                                AdmonitionFilter.sevenDays, val);
                            valueLastSevenDays = admonitionFilterLocator
                                .admonitionsFilterState
                                .value[AdmonitionFilter.sevenDays]!;
                            // valueLastSevenDays =  admonitionFilterLocator.
                            //     .sortMode.value[PupilSortMode.sortByName]!;
                            // filterLocator.sortPupils();
                          },
                        ),
                        FilterChip(
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'nicht bearbeitet',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueProcessed,
                          onSelected: (val) {
                            admonitionFilterLocator.setFilter(
                                AdmonitionFilter.processed, val);
                            valueProcessed = admonitionFilterLocator
                                .admonitionsFilterState
                                .value[AdmonitionFilter.processed]!;
                          },
                        ),
                        FilterChip(
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Icon(Icons.rectangle_rounded,
                              color: Colors.red),
                          selected: valueRedCard,
                          onSelected: (val) {
                            admonitionFilterLocator.setFilter(
                                AdmonitionFilter.redCard, val);
                            valueRedCard = admonitionFilterLocator
                                .admonitionsFilterState
                                .value[AdmonitionFilter.redCard]!;
                          },
                        ),
                        FilterChip(
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
                            admonitionFilterLocator.setFilter(
                                AdmonitionFilter.redCardOgs, val);
                            valueRedCardOgs = admonitionFilterLocator
                                .admonitionsFilterState
                                .value[AdmonitionFilter.redCardOgs]!;
                          },
                        ),
                        FilterChip(
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
                            admonitionFilterLocator.setFilter(
                                AdmonitionFilter.redCardsentHome, val);
                            valueRedCardOgs = admonitionFilterLocator
                                .admonitionsFilterState
                                .value[AdmonitionFilter.redCardsentHome]!;
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
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'Anzahl',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueSortByAdmonitions,
                          onSelected: (val) {
                            filterLocator.setSortMode(
                                PupilSortMode.sortByAdmonitions, val);
                            valueSortByAdmonitions = filterLocator.sortMode
                                .value[PupilSortMode.sortByAdmonitions]!;
                            filterLocator.sortPupils();
                          },
                        ),
                        FilterChip(
                          selectedColor: filterChipSelectedColor,
                          checkmarkColor: filterChipSelectedCheckColor,
                          backgroundColor: filterChipUnselectedColor,
                          label: const Text(
                            'zuletzt',
                            style: filterItemsTextStyle,
                          ),
                          selected: valueSortByLastAdmonition,
                          onSelected: (val) {
                            filterLocator.setSortMode(
                                PupilSortMode.sortByLastAdmonition, val);
                            valueSortByAdmonitions = filterLocator.sortMode
                                .value[PupilSortMode.sortByLastAdmonition]!;
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

showAdmonitionFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const AdmonitionFilterBottomSheet(),
  );
}
