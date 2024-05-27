import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class CreditFilterBottomSheet extends WatchingWidget {
  const CreditFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<PupilFilter, bool> activeFilters =
    //     watchValue((PupilFilterManager x) => x.filterState);
    // Map<PupilSortMode, bool> sortMode =
    //     watchValue((PupilFilterManager x) => x.sortMode);
    // bool valueSortByName = sortMode[PupilSortMode.sortByName]!;
    // bool valueSortByCredit = sortMode[PupilSortMode.sortByCredit]!;
    // bool valueSortByCreditEarned = sortMode[PupilSortMode.sortByCreditEarned]!;

    final filterLocator = locator<PupilFilterManager>();
    final sortModeValue = watch(locator<PupilsFilter>().sortMode).value;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const FilterHeading(),
              const StandardFilters(),
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
                      'alphabetisch',
                      style: filterItemsTextStyle,
                    ),
                    selected: sortModeValue == PupilSortMode.sortByName
                        ? true
                        : false,
                    onSelected: (val) {
                      locator<PupilsFilter>()
                          .setSortMode(PupilSortMode.sortByName);
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
                      'nach Guthaben',
                      style: filterItemsTextStyle,
                    ),
                    selected: sortModeValue == PupilSortMode.sortByCredit
                        ? true
                        : false,
                    onSelected: (val) {
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
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'nach Verdienst',
                      style: filterItemsTextStyle,
                    ),
                    selected: sortModeValue == PupilSortMode.sortByCreditEarned
                        ? true
                        : false,
                    onSelected: (val) {
                      locator<PupilsFilter>().setSortMode(
                        PupilSortMode.sortByCreditEarned,
                      );
                    },
                  ),
                ],
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
