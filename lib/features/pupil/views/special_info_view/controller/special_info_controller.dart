import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/special_info_list_view.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoList extends WatchingStatefulWidget {
  const SpecialInfoList({Key? key}) : super(key: key);
  @override
  SpecialInfoListController createState() => SpecialInfoListController();
}

class SpecialInfoListController extends State<SpecialInfoList> {
  @override
  void initState() {
    locator<PupilFilterManager>().setFilter(PupilFilter.specialInfo, true);
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  String pickUpValue(String? value) {
    return pickupTimePredicate(value);
  }

  void cancelSearch({bool unfocus = true}) {
    if (locator<PupilFilterManager>().filterState.value ==
        initialFilterValues) {
      locator<PupilFilterManager>().filtersOnSwitch(false);
      locator<PupilFilterManager>().refreshFilteredPupils();
    }
    setState(() {
      searchController.clear();
      isSearchMode = false;
      isSearching = false;
    });
    locator<PupilFilterManager>().setSearchText('');
    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSearchEnter(String text) {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;

    locator<PupilFilterManager>().setSearchText(text);
  }

  @override
  void dispose() {
    locator<PupilFilterManager>().setFilter(PupilFilter.specialInfo, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpecialInfoListView(this);
  }
}
