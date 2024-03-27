import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/ogs/ogs_list_view.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:watch_it/watch_it.dart';

class OgsList extends WatchingStatefulWidget {
  const OgsList({Key? key}) : super(key: key);
  @override
  OgsListController createState() => OgsListController();
}

class OgsListController extends State<OgsList> {
  @override
  void initState() {
    locator<PupilFilterManager>().setFilter(PupilFilter.ogs, true);
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
    locator<PupilFilterManager>().setFilter(PupilFilter.ogs, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OgsListView(this);
  }
}
