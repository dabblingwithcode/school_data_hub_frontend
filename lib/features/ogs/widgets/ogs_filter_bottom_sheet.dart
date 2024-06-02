import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class OgsFilterBottomSheet extends WatchingWidget {
  const OgsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          FilterHeading(),
          CommonPupilFiltersWidget(),
          Row(
            children: [
              Text(
                'OGS-Filter',
                style: subtitle,
              )
            ],
          ),
        ],
      ),
    );
  }
}

showOgsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const OgsFilterBottomSheet(),
  );
}
