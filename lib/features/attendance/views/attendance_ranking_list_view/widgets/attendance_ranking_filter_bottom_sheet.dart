import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingFilterBottomSheet extends WatchingWidget {
  const AttendanceRankingFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;

    bool valueSortByMissedExcused =
        sortMode[PupilSortMode.sortByMissedExcused]!;
    bool valueSortByMissedUnexcused =
        sortMode[PupilSortMode.sortByMissedUnexcused]!;
    bool valueSortByContacted = sortMode[PupilSortMode.sortByContacted]!;
    bool valueSortByLate = sortMode[PupilSortMode.sortByLate]!;

    final filterLocator = locator<PupilFilterManager>();
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
                    selected: valueSortByName,
                    onSelected: (val) {
                      filterLocator.setSortMode(PupilSortMode.sortByName, val);
                      valueSortByMissedExcused = filterLocator
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
                      'entschuldigt',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByMissedExcused,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByMissedExcused, val);
                      valueSortByMissedExcused = filterLocator
                          .sortMode.value[PupilSortMode.sortByMissedExcused]!;
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
                      'unentschuldigt',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByMissedUnexcused,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByMissedUnexcused, val);
                      valueSortByMissedUnexcused = filterLocator
                          .sortMode.value[PupilSortMode.sortByMissedExcused]!;
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
                      'verspätet',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByLate,
                    onSelected: (val) {
                      filterLocator.setSortMode(PupilSortMode.sortByLate, val);
                      valueSortByLate = filterLocator
                          .sortMode.value[PupilSortMode.sortByLate]!;
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
                      'kontaktiert',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByContacted,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByContacted, val);
                      valueSortByContacted = filterLocator
                          .sortMode.value[PupilSortMode.sortByContacted]!;
                      filterLocator.sortPupils();
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

showAttendanceRankingFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) => const AttendanceRankingFilterBottomSheet(),
  );
}
