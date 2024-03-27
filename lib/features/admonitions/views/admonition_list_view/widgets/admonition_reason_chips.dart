import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Chip admonitionReasonChipWidget(String reason) {
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
List<Widget> admonitionReasonChip(String reason) {
  List<Widget> chips = [];
  if (reason.contains('gm')) {
    chips.add(admonitionReasonChipWidget('🤜🤕'));
  }
  if (reason.contains('gl')) {
    chips.add(admonitionReasonChipWidget('🤜🎓️'));
  }
  if (reason.contains('gs')) {
    chips.add(admonitionReasonChipWidget('🤜🏫'));
  }
  if (reason.contains('ab')) {
    chips.add(admonitionReasonChipWidget('🤬💔'));
  }
  if (reason.contains('gv')) {
    chips.add(admonitionReasonChipWidget('🚨😱'));
  }
  if (reason.contains('äa')) {
    chips.add(admonitionReasonChipWidget('😈😖'));
  }
  if (reason.contains('il')) {
    chips.add(admonitionReasonChipWidget('🎓️🙉'));
  }
  if (reason.contains('us')) {
    chips.add(admonitionReasonChipWidget('🛑🎓️'));
  }
  if (reason.contains('ss')) {
    chips.add(admonitionReasonChipWidget('📝'));
  }
  return chips;
}
