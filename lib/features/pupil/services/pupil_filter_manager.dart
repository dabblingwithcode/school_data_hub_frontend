import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_helper_functions.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_filters.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/learning_support/services/learning_support_filters.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

class PupilFilterManager {
  ValueListenable<bool> get filtersOn => _filtersOn;
  ValueListenable<String> get searchText => _searchText;
  ValueListenable<List<Pupil>> get filteredPupils => _filteredPupils;
  ValueListenable<Map<PupilFilter, bool>> get filterState => _filterState;
  ValueListenable<Map<PupilSortMode, bool>> get sortMode => _sortMode;

  ValueListenable<bool> get isRunning => _isRunning;

  final _filtersOn = ValueNotifier<bool>(false);
  final _searchText = ValueNotifier<String>('');
  final _filteredPupils =
      ValueNotifier<List<Pupil>>(locator<PupilManager>().pupils.value);
  final _filterState =
      ValueNotifier<Map<PupilFilter, bool>>(initialFilterValues);
  final _sortMode =
      ValueNotifier<Map<PupilSortMode, bool>>(initialSortModeValues);

  final _isRunning = ValueNotifier<bool>(false);

  PupilFilterManager() {
    debug.warning('PupilFilterManager says hello!');
  }
  isRunningSwitch(bool value) {
    _isRunning.value = value;
  }

  filtersOnSwitch(value) {
    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = value;
    }
  }

  deleteFilteredPupils() {
    _filteredPupils.value = [];
  }

  restoreFilterValues(Map<PupilFilter, bool> inheritedFilters) {
    _filterState.value = {...inheritedFilters};
  }

  refreshFilteredPupils() {
    final List<Pupil> filteredPupils = List.from(_filteredPupils.value);
    final List<Pupil> pupils = locator<PupilManager>().pupils.value;

    Map<int, Pupil> pupilMap = {
      for (Pupil pupil in pupils) pupil.internalId: pupil
    };

    // Update each element in filteredPupils with matching pupil from pupils
    for (int i = 0; i < filteredPupils.length; i++) {
      Pupil pupil = filteredPupils[i];
      if (pupilMap.containsKey(pupil.internalId)) {
        pupil = pupilMap[pupil.internalId]!;
      } else {
        // Remove the pupil from filteredPupils if it's not in pupils
        filteredPupils.removeAt(i);
        i--; // Decrement i to account for the removed element
      }
    }

    _filteredPupils.value = filteredPupils;
  }

  cloneToFilteredPupil(Pupil pupil) {
    List<Pupil> filteredPupils = _filteredPupils.value;
    List<Pupil> updatedPupils = List<Pupil>.from(filteredPupils);
    int index = updatedPupils
        .indexWhere((element) => element.internalId == pupil.internalId);
    updatedPupils[index] = pupil;
    _filteredPupils.value = updatedPupils;
  }

  rebuildFilteredPupils() {
    // List<Pupil> pupils = locator<PupilManager>().pupils.value;
    _filteredPupils.value = locator<PupilManager>().pupils.value;
    filterPupils();
    sortPupils();
    //setSearchText(_searchText.value);
  }

  resetFilters() {
    _filterState.value = {...initialFilterValues};
    locator<SearchManager>().searchController.value.clear();
    locator<SearchManager>().changeSearchState(false);
    _searchText.value = '';
    _sortMode.value = {...initialSortModeValues};
    _filtersOn.value = false;
    rebuildFilteredPupils();
  }

  // Set modified filter value
  void setFilter(PupilFilter filter, bool isActive) {
    _filterState.value = {
      ..._filterState.value,
      filter: isActive,
    };
    filterPupils();
  }

  List<Pupil> filteredPupilsFromList(List<Pupil> pupilsFromList) {
    List<Pupil> filteredPupilsFromList = [];
    for (Pupil pupil in pupilsFromList) {
      Pupil filteredPupil = _filteredPupils.value
          .where((element) => element.internalId == pupil.internalId)
          .single;
      filteredPupilsFromList.add(filteredPupil);
    }
    return filteredPupilsFromList;
  }

  void setSortMode(PupilSortMode sortMode, bool isActive) {
    if (sortMode == PupilSortMode.sortByName || isActive == false) {
      _sortMode.value = initialSortModeValues;
    } else {
      _sortMode.value = initialSortModeValues;
      _sortMode.value = {
        ..._sortMode.value,
        PupilSortMode.sortByName: false,
        sortMode: isActive,
      };
    }
    sortPupils();
  }

  setSearchText(String? text) {
    if (text!.isEmpty) {
      _filteredPupils.value = locator<PupilManager>().pupils.value;
      _searchText.value = '';
      _filtersOn.value = false;
      return;
    }
    _searchText.value = text;
    _filtersOn.value = true;
    List<Pupil> filteredPupils = [];
    List<Pupil> filteredPupilsState = List.from(_filteredPupils.value);
    filteredPupils = filteredPupilsState
        .where((Pupil pupil) =>
            pupil.internalId.toString().contains(text) ||
            pupil.firstName!.toLowerCase().contains(text.toLowerCase()) ||
            pupil.lastName!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    _filteredPupils.value = filteredPupils;
  }

  filterPupils() {
    _filtersOn.value = false;

    final pupils = locator<PupilManager>().pupils.value;
    final activeFilters = _filterState.value;

    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = false;
      _filteredPupils.value = pupils;
    }

    List<Pupil> filteredPupils = [];
    for (Pupil pupil in pupils) {
      bool toList = true;
      // first we make sure that common group and schoolyear filters work
      if (((activeFilters[PupilFilter.E1]! && pupil.schoolyear == 'E1') ||
              (activeFilters[PupilFilter.E2]! && pupil.schoolyear == 'E2') ||
              (activeFilters[PupilFilter.E3]! && pupil.schoolyear == 'E3') ||
              (activeFilters[PupilFilter.S3]! && pupil.schoolyear == 'S3') ||
              (activeFilters[PupilFilter.S4]! && pupil.schoolyear == 'S4') ||
              (!activeFilters[PupilFilter.E1]! &&
                  !activeFilters[PupilFilter.E2]! &&
                  !activeFilters[PupilFilter.E3]! &&
                  !activeFilters[PupilFilter.S3]! &&
                  !activeFilters[PupilFilter.S4]!)) &&
          ((activeFilters[PupilFilter.A1]! && pupil.group == 'A1') ||
              (activeFilters[PupilFilter.A2]! && pupil.group == 'A2') ||
              (activeFilters[PupilFilter.A3]! && pupil.group == 'A3') ||
              (activeFilters[PupilFilter.B1]! && pupil.group == 'B1') ||
              (activeFilters[PupilFilter.B2]! && pupil.group == 'B2') ||
              (activeFilters[PupilFilter.B3]! && pupil.group == 'B3') ||
              (activeFilters[PupilFilter.B4]! && pupil.group == 'B4') ||
              (activeFilters[PupilFilter.C1]! && pupil.group == 'C1') ||
              (activeFilters[PupilFilter.C2]! && pupil.group == 'C2') ||
              (activeFilters[PupilFilter.C3]! && pupil.group == 'C3') ||
              (activeFilters[PupilFilter.A1] == false &&
                  activeFilters[PupilFilter.A2] == false &&
                  activeFilters[PupilFilter.A3] == false &&
                  activeFilters[PupilFilter.B1] == false &&
                  activeFilters[PupilFilter.B2] == false &&
                  activeFilters[PupilFilter.B3] == false &&
                  activeFilters[PupilFilter.B4] == false &&
                  activeFilters[PupilFilter.C1] == false &&
                  activeFilters[PupilFilter.C2] == false &&
                  activeFilters[PupilFilter.C3] == false))) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      // Now apply the rest of the filters!

      //- Attendance filters -//

      toList = attendanceFilter(pupil, toList);
      toList = learningSupportFilter(pupil, toList);

      //- OGS filters -//
      // Filter ogs
      if (activeFilters[PupilFilter.ogs]! &&
          pupil.ogs == true &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.ogs] == false && toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      //- Filter not ogs
      if (activeFilters[PupilFilter.notOgs]! &&
          pupil.ogs == false &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.notOgs] == false && toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      //- Special Infomation filter - //
      if (activeFilters[PupilFilter.specialInfo]! &&
          pupil.specialInformation != null &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.specialInfo] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      //- Development filters -//
      // Filter development plan 1

      // Filter boys
      if (activeFilters[PupilFilter.justBoys]! &&
          pupil.gender == 'm' &&
          toList == true) {
        setFilter(PupilFilter.justGirls, false);
        toList = true;
      } else if (activeFilters[PupilFilter.justBoys] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      //- Filter girls
      if (activeFilters[PupilFilter.justGirls]! &&
          pupil.gender == 'm' &&
          toList == true) {
        setFilter(PupilFilter.justBoys, false);
        toList = true;
      } else if (activeFilters[PupilFilter.justGirls] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // We're done with filtering - let's add the filtered pupils to the list
      if (toList == true) {
        filteredPupils.add(pupil);
      }
    }
    // Now write it in the manager
    _filteredPupils.value = filteredPupils;

    if (_searchText.value.isNotEmpty) {
      setSearchText(_searchText.value);
    }
  }

  sortPupils() {
    List<Pupil> filteredPupils = List.from(_filteredPupils.value);
    final sortMode = _sortMode.value;

    // Sort by first Name
    if (sortMode[PupilSortMode.sortByName] == true) {
      filteredPupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    }
    // Sort by credit
    if (sortMode[PupilSortMode.sortByCredit] == true) {
      filteredPupils.sort((b, a) => a.credit.compareTo(b.credit));
    }
    // Sort by credit earned
    if (sortMode[PupilSortMode.sortByCreditEarned] == true) {
      filteredPupils.sort((b, a) => a.creditEarned.compareTo(b.creditEarned));
    }
    // Sort by missed excused
    if (sortMode[PupilSortMode.sortByMissedExcused] == true) {
      filteredPupils
          .sort((a, b) => missedclassSum(b).compareTo(missedclassSum(a)));
    }
    // Sort by missed unexcused
    if (sortMode[PupilSortMode.sortByMissedUnexcused] == true) {
      filteredPupils.sort((a, b) =>
          missedclassUnexcusedSum(b).compareTo(missedclassUnexcusedSum(a)));
    }
    // Sort by late
    if (sortMode[PupilSortMode.sortByLate] == true) {
      filteredPupils
          .sort((a, b) => lateUnexcusedSum(b).compareTo(lateUnexcusedSum(a)));
    }
    // Sort by contacted
    if (sortMode[PupilSortMode.sortByContacted] == true) {
      filteredPupils.sort((a, b) => contactedSum(b).compareTo(contactedSum(a)));
    }
    // Sort by admonitions
    if (sortMode[PupilSortMode.sortByAdmonitions] == true) {
      filteredPupils.sort((a, b) => SchoolEventHelper.admonitionSum(b)!
          .compareTo(SchoolEventHelper.admonitionSum(a)!));
    }
    // Sort by last admonition
    if (sortMode[PupilSortMode.sortByLastAdmonition] == true) {
      filteredPupils.sort(comparePupilsByAdmonishedDate);
    }

    _filteredPupils.value = filteredPupils;
  }

  int comparePupilsByAdmonishedDate(Pupil a, Pupil b) {
    // Handle potential null cases with null-aware operators
    return (a.pupilAdmonitions?.isEmpty ?? true) ==
            (b.pupilAdmonitions?.isEmpty ?? true)
        ? compareLastAdmonishedDates(a, b) // Handle empty or both empty
        : (a.pupilAdmonitions?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int comparePupilsByLastNonProcessedAdmonition(Pupil a, Pupil b) {
    // Handle potential null cases with null-aware operators
    return (a.pupilAdmonitions?.isEmpty ?? true) ==
            (b.pupilAdmonitions?.isEmpty ?? true)
        ? compareLastAdmonishedDates(a, b) // Handle empty or both empty
        : (a.pupilAdmonitions?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int compareLastAdmonishedDates(Pupil a, Pupil b) {
    // Ensure non-empty lists before accessing elements
    if (a.pupilAdmonitions!.isNotEmpty && b.pupilAdmonitions!.isNotEmpty) {
      final admonishedDateA = a.pupilAdmonitions!.last.admonishedDay;
      final admonishedDateB = b.pupilAdmonitions!.last.admonishedDay;
      return admonishedDateB
          .compareTo(admonishedDateA); // Reversed for descending order
    } else {
      // Handle cases where one or both lists are empty (optional, adjust logic as needed)
      return 0; // Consider them equal, or apply other logic based on your requirements
    }
  }
}
