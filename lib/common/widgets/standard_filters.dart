import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter_impl.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
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
              locator<PupilsFilterImplementation>().resetFilters();
              //Navigator.pop(context);
            },
            icon: const Icon(Icons.restart_alt_rounded)),
      ],
    );
  }
}

class StandardFilters extends WatchingWidget {
  const StandardFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = watchIt<PupilsFilterImplementation>();
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
            for (final stufe in Jahrgangsstufe.values)
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: Text(
                  stufe.value,
                  style: filterItemsTextStyle,
                ),
                selected: filter.jahrgangsstufeState(stufe),
                onSelected: (val) {
                  filter.toggleJahrgangsstufe(stufe);
                },
              ),
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
            for (final groupId in GroupId.values)
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: Text(
                  groupId.value,
                  style: filterItemsTextStyle,
                ),
                selected: filter.groupIdState(groupId),
                onSelected: (val) {
                  filter.toggleGroupId(groupId);
                },
              ),
          ],
        ),
      ],
    );
  }
}
