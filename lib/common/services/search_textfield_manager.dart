import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

class SearchManager {
  ValueListenable<bool> get searchState => _searchState;
  ValueListenable<TextEditingController> get searchController =>
      _searchController;
  final _searchState = ValueNotifier<bool>(false);
  final _searchController =
      ValueNotifier<TextEditingController>(TextEditingController());

  SearchManager() {
    _searchState.value = false;
    _searchController.value = TextEditingController();
  }
  void onSearchEnter(String text) {
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    _searchState.value = true;
    locator<PupilFilterManager>().setSearchText(text);
  }

  void changeSearchState(bool value) {
    _searchState.value = value;
  }

  void cancelSearch({bool unfocus = true}) {
    _searchController.value.clear();
    _searchState.value = false;
    locator<PupilFilterManager>().resetFilters();

    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }
}
