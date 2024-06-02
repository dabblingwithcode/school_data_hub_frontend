import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoFilterBottomSheet extends WatchingWidget {
  const SpecialInfoFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //final filterLocator = locator<PupilFilterManager>();

    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          FilterHeading(),
          CommonPupilFiltersWidget(),
        ],
      ),
    );
  }
}

showSpecialInfoFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (_) => const SpecialInfoFilterBottomSheet(),
  );
}
