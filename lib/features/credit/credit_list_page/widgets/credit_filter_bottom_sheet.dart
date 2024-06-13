import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/common_pupil_filters.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class CreditFilterBottomSheet extends WatchingWidget {
  const CreditFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sortModeValue = watch(locator<PupilsFilter>().sortMode).value;
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
                            selected: sortModeValue == PupilSortMode.sortByName
                                ? true
                                : false,
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
                              'nach Guthaben',
                              style: filterItemsTextStyle,
                            ),
                            selected:
                                sortModeValue == PupilSortMode.sortByCredit
                                    ? true
                                    : false,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByCredit) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>().setSortMode(
                                PupilSortMode.sortByCredit,
                              );
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
                              'nach Verdienst',
                              style: filterItemsTextStyle,
                            ),
                            selected: sortModeValue ==
                                    PupilSortMode.sortByCreditEarned
                                ? true
                                : false,
                            onSelected: (val) {
                              // if the filter is already selected, do nothing
                              if (locator<PupilsFilter>().sortMode.value ==
                                  PupilSortMode.sortByCreditEarned) {
                                return;
                              }
                              // set the filter
                              locator<PupilsFilter>().setSortMode(
                                PupilSortMode.sortByCreditEarned,
                              );
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

showCreditFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const CreditFilterBottomSheet(),
  );
}
