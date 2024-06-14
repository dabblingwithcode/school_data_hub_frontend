import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

class SchooldayEventReasonFilterChip extends StatelessWidget {
  final bool isReason;
  final Function(bool) onSelected;
  final String emojis;
  final String text;
  const SchooldayEventReasonFilterChip(
      {required this.isReason,
      required this.onSelected,
      required this.emojis,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      selectedColor: schooldayEventReasonChipSelectedColor,
      checkmarkColor: schooldayEventReasonChipSelectedCheckColor,
      backgroundColor: schooldayEventReasonChipUnselectedColor,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emojis,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          const Gap(5),
          Text(
            text,
            style: filterItemsTextStyle,
          ),
        ],
      ),
      selected: isReason,
      onSelected: onSelected,
    );
  }
}
