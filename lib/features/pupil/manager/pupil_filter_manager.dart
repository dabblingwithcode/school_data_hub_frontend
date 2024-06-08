import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';

// ? this is an old class and the rests being used should be migrated to PupilsFilterImplementation

class PupilFilterManager {
  ValueListenable<bool> get filtersOn => _filtersOn;
  ValueListenable<String> get searchText => _searchText;
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;
  ValueListenable<Map<PupilFilter, bool>> get filterState => _filterState;
  ValueListenable<Map<PupilSortMode, bool>> get sortMode => _sortMode;

  final _filtersOn = ValueNotifier<bool>(false);
  final _searchText = ValueNotifier<String>('');
  final _filteredPupils =
      ValueNotifier<List<PupilProxy>>(locator<PupilManager>().allPupils);
  final _filterState =
      ValueNotifier<Map<PupilFilter, bool>>(initialFilterValues);
  final _sortMode =
      ValueNotifier<Map<PupilSortMode, bool>>(initialSortModeValues);

  PupilFilterManager() {
    logger.i('PupilFilterManager constructor called');
  }

  void filtersOnSwitch(bool value) {
    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = value;
    }
  }

  resetFilters() {
    _filterState.value = {...initialFilterValues};
    locator<SearchManager>().searchController.value.clear();
    locator<SearchManager>().changeSearchState(false);
    locator<SchooldayEventFilterManager>().resetFilters();
    _searchText.value = '';
    _sortMode.value = {...initialSortModeValues};
    _filtersOn.value = false;
    // rebuildFilteredPupils();
  }

  // Set modified filter value
  void setFilter(PupilFilter filter, bool isActive) {
    _filterState.value = {
      ..._filterState.value,
      filter: isActive,
    };
    locator<PupilsFilter>().refreshs();
  }

  List<PupilProxy> filteredPupilsFromList(List<PupilProxy> pupilsFromList) {
    List<PupilProxy> filteredPupilsFromList = [];
    for (PupilProxy pupil in pupilsFromList) {
      PupilProxy filteredPupil = _filteredPupils.value
          .where((element) => element.internalId == pupil.internalId)
          .single;
      filteredPupilsFromList.add(filteredPupil);
    }
    return filteredPupilsFromList;
  }

  // setSearchText(String? text) {
  //   if (text!.isEmpty) {
  //     _filteredPupils.value = locator<PupilManager>().allPupils;
  //     _searchText.value = '';
  //     _filtersOn.value = false;
  //     return;
  //   }
  //   _searchText.value = text;
  //   _filtersOn.value = true;
  //   List<PupilProxy> filteredPupils = [];
  //   List<PupilProxy> filteredPupilsState = List.from(_filteredPupils.value);
  //   filteredPupils = filteredPupilsState
  //       .where((PupilProxy pupil) =>
  //           pupil.internalId.toString().contains(text) ||
  //           pupil.firstName.toLowerCase().contains(text.toLowerCase()) ||
  //           pupil.lastName.toLowerCase().contains(text.toLowerCase()))
  //       .toList();
  //   _filteredPupils.value = filteredPupils;
  // }

  filterPupils() {
    _filtersOn.value = false;

    final pupils = locator<PupilManager>().allPupils;
    final activeFilters = _filterState.value;

    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = false;
      _filteredPupils.value = pupils;
    }

    List<PupilProxy> filteredPupils = [];
    for (PupilProxy pupil in pupils) {
      bool isMatching = true;

      //- OGS filters -//
      // Filter ogs
      if (activeFilters[PupilFilter.ogs]! && pupil.ogs != true) {
        _filtersOn.value = true;
        continue;
      }

      //- Filter not ogs
      if (activeFilters[PupilFilter.notOgs]! &&
          pupil.ogs == false &&
          isMatching == true) {
        isMatching = true;
      } else if (activeFilters[PupilFilter.notOgs] == false &&
          isMatching == true) {
        isMatching = true;
      } else {
        _filtersOn.value = true;
        isMatching = false;
      }
      //- Special Infomation filter - //
      if (activeFilters[PupilFilter.specialInfo]! &&
          pupil.specialInformation != null &&
          isMatching == true) {
        isMatching = true;
      } else if (activeFilters[PupilFilter.specialInfo] == false &&
          isMatching == true) {
        isMatching = true;
      } else {
        _filtersOn.value = true;
        isMatching = false;
      }

      // Filter boys
      if (activeFilters[PupilFilter.justBoys]! &&
          pupil.gender == 'm' &&
          isMatching == true) {
        setFilter(PupilFilter.justGirls, false);
        isMatching = true;
      } else if (activeFilters[PupilFilter.justBoys] == false &&
          isMatching == true) {
        isMatching = true;
      } else {
        _filtersOn.value = true;
        isMatching = false;
      }

      //- Filter girls
      if (activeFilters[PupilFilter.justGirls]! &&
          pupil.gender == 'm' &&
          isMatching == true) {
        setFilter(PupilFilter.justBoys, false);
        isMatching = true;
      } else if (activeFilters[PupilFilter.justGirls] == false &&
          isMatching == true) {
        isMatching = true;
      } else {
        _filtersOn.value = true;
        isMatching = false;
      }

      // We're done with filtering - let's add the filtered pupils to the list
      if (isMatching == true) {
        filteredPupils.add(pupil);
      }
    }
    // Now write it in the manager
    _filteredPupils.value = filteredPupils;
  }

  int comparePupilsByAdmonishedDate(PupilProxy a, PupilProxy b) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastAdmonishedDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int comparePupilsByLastNonProcessedSchooldayEvent(
      PupilProxy a, PupilProxy b) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastAdmonishedDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int compareLastAdmonishedDates(PupilProxy a, PupilProxy b) {
    // Ensure non-empty lists before accessing elements
    if (a.schooldayEvents!.isNotEmpty && b.schooldayEvents!.isNotEmpty) {
      final admonishedDateA = a.schooldayEvents!.last.schooldayEventDate;
      final admonishedDateB = b.schooldayEvents!.last.schooldayEventDate;
      return admonishedDateB
          .compareTo(admonishedDateA); // Reversed for descending order
    } else {
      // Handle cases where one or both lists are empty
      return 0; // Consider them equal, or apply other logic
    }
  }
}
