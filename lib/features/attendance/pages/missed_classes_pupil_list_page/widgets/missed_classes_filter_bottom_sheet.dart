import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/common_pupil_filters.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class MissedClassesFilterBottomSheet extends WatchingWidget {
  const MissedClassesFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    PupilSortMode sortMode = watchValue((PupilsFilter x) => x.sortMode);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const FilterHeading(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CommonPupilFiltersWidget(),
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
                            avatar: const SizedBox(
                              width: 10,
                            ),
                            checkmarkColor: filterChipSelectedCheckColor,
                            backgroundColor: filterChipUnselectedColor,
                            label: const Text(
                              'A-Z',
                              style: filterItemsTextStyle,
                            ),
                            selected: sortMode == PupilSortMode.sortByName,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByName) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>()
                                  .setSortMode(PupilSortMode.sortByName);
                            },
                          ),
                          FilterChip(
                            padding: filterChipPadding,
                            labelPadding: filterChipLabelPadding,
                            shape: filterChipShape,
                            selectedColor: filterChipSelectedColor,
                            avatar: const SizedBox(
                              width: 10,
                            ),
                            checkmarkColor: filterChipSelectedCheckColor,
                            backgroundColor: filterChipUnselectedColor,
                            label: const Text(
                              'entschuldigt',
                              style: filterItemsTextStyle,
                            ),
                            selected:
                                sortMode == PupilSortMode.sortByMissedExcused,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByMissedExcused) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>().setSortMode(
                                  PupilSortMode.sortByMissedExcused);
                            },
                          ),
                          FilterChip(
                            padding: filterChipPadding,
                            labelPadding: filterChipLabelPadding,
                            shape: filterChipShape,
                            selectedColor: filterChipSelectedColor,
                            avatar: const SizedBox(
                              width: 10,
                            ),
                            checkmarkColor: filterChipSelectedCheckColor,
                            backgroundColor: filterChipUnselectedColor,
                            label: const Text(
                              'unentschuldigt',
                              style: filterItemsTextStyle,
                            ),
                            selected:
                                sortMode == PupilSortMode.sortByMissedUnexcused,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByMissedUnexcused) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>().setSortMode(
                                  PupilSortMode.sortByMissedUnexcused);
                            },
                          ),
                          FilterChip(
                            padding: filterChipPadding,
                            labelPadding: filterChipLabelPadding,
                            shape: filterChipShape,
                            selectedColor: filterChipSelectedColor,
                            avatar: const SizedBox(
                              width: 10,
                            ),
                            checkmarkColor: filterChipSelectedCheckColor,
                            backgroundColor: filterChipUnselectedColor,
                            label: const Text(
                              'verspätet',
                              style: filterItemsTextStyle,
                            ),
                            selected: sortMode == PupilSortMode.sortByLate,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByLate) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>()
                                  .setSortMode(PupilSortMode.sortByLate);
                            },
                          ),
                          FilterChip(
                            padding: filterChipPadding,
                            labelPadding: filterChipLabelPadding,
                            shape: filterChipShape,
                            selectedColor: filterChipSelectedColor,
                            avatar: const SizedBox(
                              width: 10,
                            ),
                            checkmarkColor: filterChipSelectedCheckColor,
                            backgroundColor: filterChipUnselectedColor,
                            label: const Text(
                              'kontaktiert',
                              style: filterItemsTextStyle,
                            ),
                            selected: sortMode == PupilSortMode.sortByContacted,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByContacted) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>()
                                  .setSortMode(PupilSortMode.sortByContacted);
                            },
                          ),
                        ],
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAttendanceRankingFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) => const MissedClassesFilterBottomSheet(),
  );
}
