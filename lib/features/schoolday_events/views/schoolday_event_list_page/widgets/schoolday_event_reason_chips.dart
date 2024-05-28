import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

class SchooldayEventReasonChip extends StatelessWidget {
  final String reason;
  const SchooldayEventReasonChip({required this.reason, super.key});

  @override
  Widget build(BuildContext context) {
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
}

const double emojiSize = 20;
List<Widget> schooldayEventReasonChips(String reason) {
  List<Widget> chips = [];
  if (reason.contains('gm')) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🤕'));
  }
  if (reason.contains('gl')) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🎓️'));
  }
  if (reason.contains('gs')) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🏫'));
  }
  if (reason.contains('ab')) {
    chips.add(const SchooldayEventReasonChip(reason: '🤬💔'));
  }
  if (reason.contains('gv')) {
    chips.add(const SchooldayEventReasonChip(reason: '🚨😱'));
  }
  if (reason.contains('äa')) {
    chips.add(const SchooldayEventReasonChip(reason: '😈😖'));
  }
  if (reason.contains('il')) {
    chips.add(const SchooldayEventReasonChip(reason: '🎓️🙉'));
  }
  if (reason.contains('us')) {
    chips.add(const SchooldayEventReasonChip(reason: '🛑🎓️'));
  }
  if (reason.contains('ss')) {
    chips.add(const SchooldayEventReasonChip(reason: '📝'));
  }
  return chips;
}
