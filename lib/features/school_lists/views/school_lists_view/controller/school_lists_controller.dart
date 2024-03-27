import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_lists_view/school_lists_view.dart';

class SchoolLists extends StatefulWidget {
  const SchoolLists({
    Key? key,
  }) : super(key: key);

  @override
  SchoolListsController createState() => SchoolListsController();
}

class SchoolListsController extends State<SchoolLists> {
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;

  @override
  void initState() {
    locator<SchoolListManager>().fetchSchoolLists();
    super.initState();
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
  Widget build(BuildContext context) {
    return SchoolListsView(this);
  }
}
