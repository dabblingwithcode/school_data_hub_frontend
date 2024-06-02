import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceFilterBottomSheet extends WatchingWidget {
  const CompetenceFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<CompetenceFilter, bool> activeFilters =
        watchValue((CompetenceFilterManager x) => x.filterState);
    bool valueE1 = activeFilters[CompetenceFilter.E1]!;
    bool valueE2 = activeFilters[CompetenceFilter.E2]!;
    bool valueS3 = activeFilters[CompetenceFilter.S3]!;
    bool valueS4 = activeFilters[CompetenceFilter.S4]!;
    final filterLocator = locator<CompetenceFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Filter',
                    style: title,
                  ),
                  const Spacer(),
                  IconButton.filled(
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () {
                        locator<PupilsFilter>().resetFilters();

                        //Navigator.pop(context);
                      },
                      icon: const Icon(Icons.restart_alt_rounded)),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Jahrgang',
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
                      'E1',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueE1,
                    onSelected: (val) {
                      filterLocator.setFilter(CompetenceFilter.E1, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'E2',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueE2,
                    onSelected: (val) {
                      filterLocator.setFilter(CompetenceFilter.E2, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'S3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueS3,
                    onSelected: (val) {
                      filterLocator.setFilter(CompetenceFilter.S3, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'S4',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueS4,
                    onSelected: (val) {
                      filterLocator.setFilter(CompetenceFilter.S4, val);
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

showCompetenceFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const CompetenceFilterBottomSheet(),
  );
}
