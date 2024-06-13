import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

class SchoolListFilterManager {
  ValueListenable<bool> get filterState => _filterState;
  ValueListenable<List<SchoolList>> get filteredSchoolLists =>
      _filteredSchoolLists;
  final _filterState = ValueNotifier<bool>(false);
  final _filteredSchoolLists = ValueNotifier<List<SchoolList>>([]);

  SchoolListFilterManager();

  void updateFilteredSchoolLists(List<SchoolList> schoolLists) {
    _filteredSchoolLists.value = schoolLists;
  }

  void resetFilters() {
    locator<SearchManager>().cancelSearch();
    _filterState.value = false;
    _filteredSchoolLists.value = locator<SchoolListManager>().schoolLists.value;
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      _filteredSchoolLists.value =
          locator<SchoolListManager>().schoolLists.value;
      return;
    }
    _filterState.value = true;
    _filteredSchoolLists.value = locator<SchoolListManager>()
        .schoolLists
        .value
        .where((element) => element.listName.contains(text))
        .toList();
  }

  final oldFilterManager = locator<PupilFilterManager>();

  List<PupilList> addPupilListFiltersToFilteredPupils(
      List<PupilList> pupilLists) {
    List<PupilList> filteredPupilLists = [];
    bool filterIsOn = false;
    for (PupilList pupilList in pupilLists) {
      if (oldFilterManager
              .filterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilList.pupilListStatus != true) {
        filterIsOn = true;
        continue;
      }
      if (oldFilterManager
              .filterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilList.pupilListStatus != false) {
        filterIsOn = true;
        continue;
      }
      if (oldFilterManager
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilList.pupilListStatus != null) {
        filterIsOn = true;
        continue;
      }
      if (oldFilterManager
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilList.pupilListComment == null) {
        filterIsOn = true;
        continue;
      }
      filteredPupilLists.add(pupilList);
    }
    //- TODO: Implement filterState, FlutterError (setState() or markNeedsBuild() called during build.
    // if (filterIsOn) {
    //   _filterState.value = true;
    // } else {
    //   _filterState.value = false;
    // }

    return filteredPupilLists;
  }
}
