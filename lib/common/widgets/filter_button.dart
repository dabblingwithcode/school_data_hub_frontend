import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class FilterButton extends WatchingWidget {
  final bool isSearchBar;
  final Function showBottomSheetFunction;
  const FilterButton(
      {required this.isSearchBar,
      required this.showBottomSheetFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    final oldPupilFilterIsOn =
        watchValue((PupilFilterManager x) => x.filtersOn);
    final schoolListFilterIsOn =
        watchValue((SchoolListFilterManager x) => x.filterState);

    return InkWell(
      onTap: () => showBottomSheetFunction(context),
      onLongPress: () {
        locator<PupilsFilter>().resetFilters();

        locator<PupilFilterManager>().filtersOnSwitch(false);
      },
      child: Icon(
        Icons.filter_list,
        color: filtersOn || oldPupilFilterIsOn || schoolListFilterIsOn
            ? Colors.deepOrange
            : isSearchBar
                ? Colors.grey
                : Colors.white,
        size: 30,
      ),
    );
  }
}
