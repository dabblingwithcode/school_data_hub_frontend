import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Chip schooldayEventReasonChipWidget(String reason) {
  return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: filterChipUnselectedColor,
      label: Text(
        reason,
        style: const TextStyle(fontSize: emojiSize),
      ));
}

const double emojiSize = 20;
List<Widget> schooldayEventReasonChip(String reason) {
  List<Widget> chips = [];
  if (reason.contains('gm')) {
    chips.add(schooldayEventReasonChipWidget('🤜🤕'));
  }
  if (reason.contains('gl')) {
    chips.add(schooldayEventReasonChipWidget('🤜🎓️'));
  }
  if (reason.contains('gs')) {
    chips.add(schooldayEventReasonChipWidget('🤜🏫'));
  }
  if (reason.contains('ab')) {
    chips.add(schooldayEventReasonChipWidget('🤬💔'));
  }
  if (reason.contains('gv')) {
    chips.add(schooldayEventReasonChipWidget('🚨😱'));
  }
  if (reason.contains('äa')) {
    chips.add(schooldayEventReasonChipWidget('😈😖'));
  }
  if (reason.contains('il')) {
    chips.add(schooldayEventReasonChipWidget('🎓️🙉'));
  }
  if (reason.contains('us')) {
    chips.add(schooldayEventReasonChipWidget('🛑🎓️'));
  }
  if (reason.contains('ss')) {
    chips.add(schooldayEventReasonChipWidget('📝'));
  }
  return chips;
}
