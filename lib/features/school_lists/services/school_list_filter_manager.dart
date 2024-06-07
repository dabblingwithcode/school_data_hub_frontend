import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

class SchoolListFilterManager {
  ValueListenable<bool> get filterState => _filterState;
  ValueListenable<List<SchoolList>> get filteredSchoolLists =>
      _filteredSchoolLists;
  final _filterState = ValueNotifier<bool>(false);
  final _filteredSchoolLists = ValueNotifier<List<SchoolList>>(
      locator<SchoolListManager>().schoolLists.value);

  SchoolListFilterManager();

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

  void resetFilters() {
    locator<SearchManager>().cancelSearch();
    _filterState.value = false;
    _filteredSchoolLists.value = locator<SchoolListManager>().schoolLists.value;
  }

  final filterLocator = locator<PupilFilterManager>();
  List<PupilProxy> addPupilListFiltersToFilteredPupils(
      List<PupilProxy> pupils, String schoolListId) {
    List<PupilProxy> filteredPupils = [];
    for (PupilProxy pupil in pupils) {
      final PupilList? pupilList = pupil.pupilLists!.firstWhereOrNull(
          (pupilList) => pupilList.originList == schoolListId);
      if (pupilList == null) {
        continue;
      }
      if (filterLocator.filterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilList.pupilListStatus != true) {
        continue;
      }
      if (filterLocator.filterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilList.pupilListStatus != false) {
        continue;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilList.pupilListStatus != null) {
        continue;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilList.pupilListComment == null) {
        continue;
      }

      filteredPupils.add(pupil);
    }
    return filteredPupils;
  }
}
