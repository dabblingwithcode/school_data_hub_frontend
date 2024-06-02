import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';

import 'package:watch_it/watch_it.dart';

class FilterHeading extends StatelessWidget {
  const FilterHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Filter',
          style: title,
        ),
        const Spacer(),
        IconButton(
            iconSize: 35,
            color: interactiveColor,
            onPressed: () {
              locator<PupilsFilter>().resetFilters();
              //Navigator.pop(context);
            },
            icon: const Icon(Icons.restart_alt_rounded)),
      ],
    );
  }
}

class CommonPupilFiltersWidget extends WatchingWidget {
  const CommonPupilFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolGradeFilters = locator<PupilsFilter>().schoolGradeFilters;
    final groupFilters = locator<PupilsFilter>().groupFilters;

    return Column(
      children: [
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
            for (final schoolGradeFilter in schoolGradeFilters)
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: Text(
                  schoolGradeFilter.displayName,
                  style: filterItemsTextStyle,
                ),
                selected: watch(schoolGradeFilter).isActive,
                onSelected: (val) {
                  schoolGradeFilter.toggle(val);
                },
              ),
            // just an example how it could be done with radio buttons
            // if (filter is RadioButtonsFilter)
            //   RadioButtonWidget(
            //     value: stufenFilter,
            //     groupValue: filter.selectedStufeFilter,
            //     onChanged: (val) {
            //       filter.selectedStufeFilter = stufenFilter;
            //     },
            //   )
          ],
        ),
        const Row(
          children: [
            Text(
              'Klasse',
              style: subtitle,
            )
          ],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final groupFilter in groupFilters)
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: Text(
                  groupFilter.displayName,
                  style: filterItemsTextStyle,
                ),
                selected: watch(groupFilter).isActive,
                onSelected: (val) {
                  groupFilter.toggle(val);
                },
              ),
          ],
        ),
      ],
    );
  }
}
