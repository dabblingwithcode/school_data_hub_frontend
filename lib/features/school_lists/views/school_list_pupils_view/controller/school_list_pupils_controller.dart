import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/school_list_pupils_view.dart';

class SchoolListPupils extends StatefulWidget {
  final SchoolList schoolList;

  const SchoolListPupils(
    this.schoolList, {
    Key? key,
  }) : super(key: key);

  @override
  SchoolListPupilsController createState() => SchoolListPupilsController();
}

class SchoolListPupilsController extends State<SchoolListPupils> {
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  final filterLocator = locator<PupilFilterManager>();
  @override
  void initState() {
    //locator<PupilFilterManager>().refreshFilteredPupils();
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

  List<PupilProxy> addPupilListFiltersToFilteredPupils(
      List<PupilProxy> pupils) {
    List<PupilProxy> filteredPupils = [];
    for (PupilProxy pupil in pupils) {
      bool toList = true;
      final PupilList? pupilList = pupil.pupilLists!.firstWhereOrNull(
          (pupilList) => pupilList.originList == widget.schoolList.listId);
      if (pupilList == null) {
        continue;
      }
      if (filterLocator.filterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilList.pupilListStatus == true) {
        toList = true;
      } else if (!filterLocator
          .filterState.value[PupilFilter.schoolListYesResponse]!) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator.filterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilList.pupilListStatus == false) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListNoResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilList.pupilListStatus == null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilList.pupilListComment != null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (toList) {
        filteredPupils.add(pupil);
      }
    }
    return filteredPupils;
  }

  @override
  Widget build(BuildContext context) {
    return SchoolListPupilsView(this, widget.schoolList);
  }
}
