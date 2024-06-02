import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/common_pupil_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingFilterBottomSheet extends WatchingWidget {
  const AttendanceRankingFilterBottomSheet({super.key});

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
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'A-Z',
                      style: filterItemsTextStyle,
                    ),
                    selected: sortMode == PupilSortMode.sortByName,
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
                      'entschuldigt',
                      style: filterItemsTextStyle,
                    ),
                    selected: sortMode == PupilSortMode.sortByMissedExcused,
                    onSelected: (val) {
                      locator<PupilsFilter>()
                          .setSortMode(PupilSortMode.sortByMissedExcused);
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
                    selected: sortMode == PupilSortMode.sortByMissedUnexcused,
                    onSelected: (val) {
                      locator<PupilsFilter>()
                          .setSortMode(PupilSortMode.sortByMissedUnexcused);
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
                    selected: sortMode == PupilSortMode.sortByLate,
                    onSelected: (val) {
                      locator<PupilsFilter>()
                          .setSortMode(PupilSortMode.sortByLate);
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
                    selected: sortMode == PupilSortMode.sortByContacted,
                    onSelected: (val) {
                      locator<PupilsFilter>()
                          .setSortMode(PupilSortMode.sortByContacted);
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
