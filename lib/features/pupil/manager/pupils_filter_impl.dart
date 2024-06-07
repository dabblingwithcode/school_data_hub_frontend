import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filters.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_objects_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_helper_functions.dart';

class PupilsFilterImplementation with ChangeNotifier implements PupilsFilter {
  PupilsFilterImplementation(
    PupilManager pupilsManager,
    //   {
    //  PupilSortMode? sortMode,
    // }
  ) : _pupilsManager = pupilsManager {
    logger.i('PupilsFilterImplementation created');
    refreshs();
    _pupilsManager.addListener(refreshs);
  }

  @override
  void setFiltersOnValue(bool value) {
    _filtersOn.value = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _pupilsManager.removeListener(refreshs);
    _filteredPupils.dispose();

    super.dispose();
  }

  final PupilManager _pupilsManager;

  @override
  ValueListenable<bool> get filtersOn => _filtersOn;
  final _filtersOn = ValueNotifier<bool>(false);

  @override
  void switchAttendanceFilters(bool value) {
    _attendanceFiltersOn.value = value;
    notifyListeners();
  }

  ValueListenable<bool> get attendanceFiltersOn => _attendanceFiltersOn;
  final _attendanceFiltersOn = ValueNotifier<bool>(false);

  @override
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;
  final ValueNotifier<List<PupilProxy>> _filteredPupils = ValueNotifier([]);

  @override
  ValueListenable<List<int>> get filteredPupilIds => _filteredPupilIds;
  final ValueNotifier<List<int>> _filteredPupilIds = ValueNotifier([]);
  @override
  ValueListenable<PupilSortMode> get sortMode => _sortMode;
  final _sortMode = ValueNotifier<PupilSortMode>(PupilSortMode.sortByName);

  final PupilTextFilter _textFilter = PupilTextFilter(name: 'Text Filter');

  late List<Filter> allFilters = [
    ...schoolGradeFilters,
    ...groupFilters,
    _textFilter,
  ];

  // reset the filters to its initial state
  @override
  void resetFilters() {
    for (final filter in allFilters) {
      filter.reset();
    }
    _filteredPupils.value = _pupilsManager.allPupils;
    _filteredPupilIds.value =
        _pupilsManager.allPupils.map((e) => e.internalId).toList();
    locator<PupilFilterManager>().resetFilters();
    sortPupils();
    _filtersOn.value = false;
  }

  // updates the filtered pupils with current filters
  // and sort mode
  @override
  void refreshs() {
    final allPupils = _pupilsManager.allPupils;

    // checks if any not yet migrated filters are active
    final bool specificFiltersOn = locator<PupilFilterManager>()
            .filterState
            .value
            .values
            .any((x) => x == true) ||
        locator<SchooldayEventFilterManager>()
            .schooldayEventsFilterState
            .value
            .values
            .any((x) => x == true);

    // If no filters are active, just sort
    if (!allFilters.any((x) => x.isActive == true) &&
        specificFiltersOn == false) {
      _filteredPupils.value = allPupils;
      _filteredPupilIds.value = allPupils.map((e) => e.internalId).toList();
      _filtersOn.value = false;
      sortPupils();
      return;
    }

    List<PupilProxy> thisFilteredPupils = [];

    bool isAnyGroupFilterActive = groupFilters.any((filter) => filter.isActive);

    bool isAnySchoolGradeFilterActive =
        schoolGradeFilters.any((filter) => filter.isActive);

    for (final pupil in allPupils) {
      // matches if no group filter is active or if the group matches the pupil's group
      bool isMatchedByGroupFilter = !isAnyGroupFilterActive ||
          groupFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      // matches if no stufen filter is active or if the stufen matches the pupil's stufe
      bool isMatchedBySchoolGradeFilter = !isAnySchoolGradeFilterActive ||
          schoolGradeFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      // if the pupil is not matched by any group or stufen filter, skip the pupil
      if (!isMatchedByGroupFilter || !isMatchedBySchoolGradeFilter) {
        continue;
      }

      if (_textFilter.isActive && !_textFilter.matches(pupil)) {
        _filtersOn.value = true;
        continue;
      }
      if (_attendanceFiltersOn.value) {
        if (!attendanceFilters(pupil)) {
          _filtersOn.value = true;
          continue;
        }
      }

      thisFilteredPupils.add(pupil);
    }

    _filteredPupils.value = thisFilteredPupils;
    _filteredPupilIds.value =
        thisFilteredPupils.map((e) => e.internalId).toList();
    sortPupils();
  }

  // Set modified filter value
  @override
  void setSortMode(PupilSortMode sortMode) {
    _sortMode.value = sortMode;
    refreshs();
    notifyListeners();
  }

  @override
  void sortPupils() {
    PupilSortMode sortMode = _sortMode.value;
    List<PupilProxy> thisFilteredPupils = _filteredPupils.value;
    switch (sortMode) {
      case PupilSortMode.sortByName:
        thisFilteredPupils.sort((a, b) => a.firstName.compareTo(b.firstName));
      case PupilSortMode.sortByCredit:
        thisFilteredPupils.sort((b, a) => a.credit.compareTo(b.credit));
      case PupilSortMode.sortByCreditEarned:
        thisFilteredPupils
            .sort((b, a) => a.creditEarned.compareTo(b.creditEarned));
      case PupilSortMode.sortBySchooldayEvents:
        thisFilteredPupils.sort((a, b) => SchoolEventHelper.schooldayEventSum(b)
            .compareTo(SchoolEventHelper.schooldayEventSum(a)));
      case PupilSortMode.sortByLastSchooldayEvent:
        thisFilteredPupils.sort(comparePupilsBySchooldayEventDate);
      case PupilSortMode.sortByLastNonProcessedSchooldayEvent:
        thisFilteredPupils.sort(comparePupilsByLastNonProcessedSchooldayEvent);
      case PupilSortMode.sortByMissedUnexcused:
        thisFilteredPupils.sort((a, b) =>
            missedclassUnexcusedSum(b).compareTo(missedclassUnexcusedSum(a)));
      case PupilSortMode.sortByMissedExcused:
        thisFilteredPupils
            .sort((a, b) => missedclassSum(b).compareTo(missedclassSum(a)));
      case PupilSortMode.sortByLate:
        thisFilteredPupils
            .sort((a, b) => lateUnexcusedSum(b).compareTo(lateUnexcusedSum(a)));
      case PupilSortMode.sortByContacted:
        thisFilteredPupils
            .sort((a, b) => contactedSum(b).compareTo(contactedSum(a)));

      default:
        PupilSortMode.sortByName;
    }
    _filteredPupils.value = thisFilteredPupils;
    _filteredPupilIds.value =
        thisFilteredPupils.map((e) => e.internalId).toList();
    notifyListeners();
  }

  @override
  void setTextFilter(String? text, {bool refresh = true}) {
    if (text != null && text.isNotEmpty) {
      _filtersOn.value = true;
    } else {
      _filtersOn.value = false;
    }
    notifyListeners();
    _textFilter.setFilterText(text ?? '');
    if (refresh) {
      refreshs();
    }
  }

  @override
  List<Filter> get groupFilters => PupilProxy.groupFilters;

  @override
  List<Filter> get schoolGradeFilters => PupilProxy.schoolGradeFilters;
}

int comparePupilsBySchooldayEventDate(PupilProxy a, PupilProxy b) {
  // Handle potential null cases with null-aware operators
  return (a.schooldayEvents?.isEmpty ?? true) ==
          (b.schooldayEvents?.isEmpty ?? true)
      ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
      : (a.schooldayEvents?.isEmpty ?? true)
          ? 1
          : -1; // Place empty after non-empty
}

int comparePupilsByLastNonProcessedSchooldayEvent(PupilProxy a, PupilProxy b) {
  // Handle potential null cases with null-aware operators
  return (a.schooldayEvents?.isEmpty ?? true) ==
          (b.schooldayEvents?.isEmpty ?? true)
      ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
      : (a.schooldayEvents?.isEmpty ?? true)
          ? 1
          : -1; // Place empty after non-empty
}

int compareLastSchooldayEventDates(PupilProxy a, PupilProxy b) {
  // Ensure non-empty lists before accessing elements
  if (a.schooldayEvents!.isNotEmpty && b.schooldayEvents!.isNotEmpty) {
    final schooldayEventA = a.schooldayEvents!.last.schooldayEventDate;
    final schooldayEventB = b.schooldayEvents!.last.schooldayEventDate;
    return schooldayEventB
        .compareTo(schooldayEventA); // Reversed for descending order
  } else {
    // Handle cases where one or both lists are empty (optional, adjust logic as needed)
    return 0; // Consider them equal, or apply other logic based on your requirements
  }
}
