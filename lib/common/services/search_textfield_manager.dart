import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filters_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_filter_manager.dart';

class SearchManager {
  ValueListenable<bool> get searchState => _searchState;
  ValueListenable<TextEditingController> get searchController =>
      _searchController;
  ValueListenable<SearchType> get searchType => _searchType;
  final _searchType = ValueNotifier<SearchType>(SearchType.pupil);
  final _searchState = ValueNotifier<bool>(false);
  final _searchController =
      ValueNotifier<TextEditingController>(TextEditingController());

  SearchManager() {
    _searchState.value = false;
    _searchController.value = TextEditingController();
  }

  void setSearchType(SearchType searchType) {
    _searchType.value = searchType;
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    _searchState.value = true;
    if (_searchType.value == SearchType.pupil) {
      locator<PupilFilterManager>().setSearchText(text);
    }
    if (_searchType.value == SearchType.room) {
      locator<MatrixPolicyFilterManager>().filterRoomsWithSearchText(text);
    }
    if (_searchType.value == SearchType.matrixUser) {
      locator<MatrixPolicyFilterManager>().filterUsersWithSearchText(text);
    }
    if (_searchType.value == SearchType.list) {
      locator<SchoolListFilterManager>().onSearchEnter(text);
    }
    if (_searchType.value == SearchType.workbook) {}
  }

  void changeSearchState(bool value) {
    _searchState.value = value;
  }

  void cancelSearch({bool unfocus = true}) {
    _searchController.value.clear();
    _searchState.value = false;
    if (_searchType.value == SearchType.pupil) {
      locator<PupilFilterManager>().resetFilters();
    }
    if (_searchType.value == SearchType.room) {
      locator<MatrixPolicyFilterManager>().filterRoomsWithSearchText('');
    }
    if (_searchType.value == SearchType.matrixUser) {
      locator<MatrixPolicyFilterManager>().filterUsersWithSearchText('');
    }
    if (_searchType.value == SearchType.list) {
      locator<SchoolListFilterManager>().onSearchEnter('');
    }
    if (_searchType.value == SearchType.workbook) {}

    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }
}
