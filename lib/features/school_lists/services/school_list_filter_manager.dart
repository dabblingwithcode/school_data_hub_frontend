import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
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
}
