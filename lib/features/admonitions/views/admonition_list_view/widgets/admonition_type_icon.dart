import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Widget admonitionTypeIcon(String category) {
  switch (category) {
    case 'Eg':
      return const Row(
        children: [
          Icon(
            Icons.group_rounded,
            color: accentColor,
          ),
          Gap(5),
          Icon(Icons.message, color: backgroundColor),
        ],
      );
    case 'rk':
      return const Icon(
        Icons.sim_card_alert_rounded,
        color: Colors.red,
      );
    case 'rkogs':
      return const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          Icons.sim_card_alert_rounded,
          color: Colors.red,
        ),
        Gap(5),
        Text('OGS',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ]);
    case 'other':
      return const Icon(Icons.assignment_rounded, color: backgroundColor);
    case 'choose':
      return Image.asset('assets/choose.png');
    case 'rkabh':
      return const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          Icons.sim_card_alert_rounded,
          color: Colors.red,
        ),
        Gap(5),
        Icon(
          Icons.home,
          color: accentColor,
        )
      ]);
    default:
      return const Icon(Icons.local_offer_rounded, color: Colors.black);
  }
}
