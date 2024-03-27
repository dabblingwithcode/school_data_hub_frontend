import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportFilterBottomSheet extends WatchingWidget {
  const LearningSupportFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    bool valueSpecialNeeds = activeFilters[PupilFilter.specialNeeds]!;
    bool valueDevelopmentPlan1 = activeFilters[PupilFilter.developmentPlan1]!;
    bool valueDevelopmentPlan2 = activeFilters[PupilFilter.developmentPlan2]!;
    bool valueDevelopmentPlan3 = activeFilters[PupilFilter.developmentPlan3]!;
    bool valueMigrationSupport = activeFilters[PupilFilter.migrationSupport]!;
    bool valueSupportAreaMotorics =
        activeFilters[PupilFilter.supportAreaMotorics]!;
    bool valueSupportAreaEmotions =
        activeFilters[PupilFilter.supportAreaEmotions]!;
    bool valueSupportAreaMath = activeFilters[PupilFilter.supportAreaMath]!;
    bool valueSupportAreaLearning =
        activeFilters[PupilFilter.supportAreaLearning]!;
    bool valueSupportAreaGerman = activeFilters[PupilFilter.supportAreaGerman]!;
    bool valueSupportAreaLanguage =
        activeFilters[PupilFilter.supportAreaLanguage]!;
    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
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
                      'Förderebene',
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
                        'Ebene 1',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueDevelopmentPlan1,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.developmentPlan1, val);

                        valueDevelopmentPlan1 = filterLocator
                            .filterState.value[PupilFilter.developmentPlan1]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Ebene 2',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueDevelopmentPlan2,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.developmentPlan2, val);

                        valueDevelopmentPlan2 = filterLocator
                            .filterState.value[PupilFilter.developmentPlan2]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Ebene 3',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueDevelopmentPlan3,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.developmentPlan3, val);

                        valueDevelopmentPlan3 = filterLocator
                            .filterState.value[PupilFilter.developmentPlan3]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'AO-SF',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSpecialNeeds,
                      onSelected: (val) {
                        filterLocator.setFilter(PupilFilter.specialNeeds, val);

                        valueSpecialNeeds = filterLocator
                            .filterState.value[PupilFilter.specialNeeds]!;
                      },
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Förderbereich',
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
                        'Motorik',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaMotorics,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaMotorics, val);

                        valueSupportAreaMotorics = filterLocator.filterState
                            .value[PupilFilter.supportAreaMotorics]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'ES',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaEmotions,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaEmotions, val);

                        valueSupportAreaEmotions = filterLocator.filterState
                            .value[PupilFilter.supportAreaEmotions]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Mathe',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaMath,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaMath, val);

                        valueSupportAreaMath = filterLocator
                            .filterState.value[PupilFilter.supportAreaMath]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Lernen',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaLearning,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaLearning, val);

                        valueSupportAreaLearning = filterLocator.filterState
                            .value[PupilFilter.supportAreaLearning]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Deutsch',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaGerman,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaGerman, val);

                        valueSupportAreaGerman = filterLocator
                            .filterState.value[PupilFilter.supportAreaGerman]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'Sprache',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueSupportAreaLanguage,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.supportAreaLanguage, val);

                        valueSupportAreaLanguage = filterLocator.filterState
                            .value[PupilFilter.supportAreaLanguage]!;
                      },
                    ),
                    FilterChip(
                      selectedColor: filterChipSelectedColor,
                      checkmarkColor: filterChipSelectedCheckColor,
                      backgroundColor: filterChipUnselectedColor,
                      label: const Text(
                        'EF',
                        style: filterItemsTextStyle,
                      ),
                      selected: valueMigrationSupport,
                      onSelected: (val) {
                        filterLocator.setFilter(
                            PupilFilter.migrationSupport, val);

                        valueMigrationSupport = filterLocator
                            .filterState.value[PupilFilter.migrationSupport]!;
                      },
                    ),
                  ],
                ),
                const Gap(20),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

showLearningSupportFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const LearningSupportFilterBottomSheet(),
  );
}
