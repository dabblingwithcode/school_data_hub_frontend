import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_badges.dart';

Widget attendanceStats(Pupil pupil) {
  return Row(
    children: [
      excusedBadge(false),
      const Gap(3),
      Text(
        missedclassSum(pupil).toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(5),
      excusedBadge(true),
      const Gap(3),
      Text(
        missedclassUnexcusedSum(pupil).toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(5),
      missedTypeBadge('late'),
      const Gap(3),
      Text(
        lateUnexcusedSum(pupil).toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(5),
      contactedBadge(1),
      const Gap(3),
      Text(
        contactedSum(pupil).toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ],
  );
}
