import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class OgsFilterBottomSheet extends WatchingWidget {
  const OgsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);

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
          standardFilters(activeFilters),
          const Row(
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
