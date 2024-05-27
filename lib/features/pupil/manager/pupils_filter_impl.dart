import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_helper_functions.dart';

class PupilTextFilter extends Filter<PupilProxy> {
  PupilTextFilter({
    required super.name,
  });

  String _text = '';
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
    toggle(isActive);
    notifyListeners();
  }

  @override
  void reset() {
    _text = '';
    super.reset();
  }

  @override
  bool matches(PupilProxy item) {
    return item.internalId.toString().contains(text) ||
        item.firstName.toLowerCase().contains(text.toLowerCase()) ||
        item.lastName.toLowerCase().contains(text.toLowerCase());
  }
}

class PupilsFilterImplementation with ChangeNotifier implements PupilsFilter {
  PupilsFilterImplementation(
    PupilManager pupilsManager,
    //   {
    //  PupilSortMode? sortMode,
    // }
  ) : _pupilsManager = pupilsManager {
    debug.info('PupilsFilterImplementation created');
    refreshs();
    _pupilsManager.addListener(refreshs);
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
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;
  final ValueNotifier<List<PupilProxy>> _filteredPupils = ValueNotifier([]);

  @override
  ValueListenable<PupilSortMode> get sortMode => _sortMode;
  final _sortMode = ValueNotifier<PupilSortMode>(PupilSortMode.sortByName);

  final PupilTextFilter _textFilter = PupilTextFilter(name: 'Text Filter');

  late List<Filter> allFilters = [
    ...stufenFilters,
    ...groupFilters,
    _textFilter,
  ];

  // updates the filtered pupils with current filters
  // and sort mode
  @override
  void refreshs() {
    final allPupils = _pupilsManager.allPupils;

    // If no filters are active, just sort
    if (!allFilters.any((x) => x.isActive)) {
      _filteredPupils.value = allPupils;
      _filtersOn.value = false;
      sortPupils();
      return;
    }

    List<PupilProxy> thisFilteredPupils = [];

    bool isAnyGroupFilterActive = groupFilters.any((filter) => filter.isActive);

    bool isAnyStufenFilterActive =
        stufenFilters.any((filter) => filter.isActive);

    for (final pupil in allPupils) {
      bool toList = false;

      // matches if no group filter is active or if the group matches the pupil's group
      bool isMatchedByGroupFilter = !isAnyGroupFilterActive ||
          groupFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      // matches if no stufen filter is active or if the stufen matches the pupil's stufe
      bool isMatchedByStufenFilter = !isAnyStufenFilterActive ||
          stufenFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      // If a pupil matches both groupFilter and stufenFilter conditions, add it to the list
      if (isMatchedByGroupFilter && isMatchedByStufenFilter) {
        toList = true;
      }

      // If the text filter is active, check if the pupil matches the text filter
      if (toList == true && _textFilter.isActive) {
        toList = toList && _textFilter.matches(pupil);
      }

      if (toList) {
        thisFilteredPupils.add(pupil);
      }
    }

    if (isAnyStufenFilterActive || isAnyGroupFilterActive) {
      _filtersOn.value = true;
    }
    _filteredPupils.value = thisFilteredPupils;
    sortPupils();
  }

  // reset the filters to its initial state
  @override
  void resetFilters() {
    for (final filter in allFilters) {
      filter.reset();
    }
    _filteredPupils.value = _pupilsManager.allPupils;
    sortPupils();
    _filtersOn.value = false;
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
        thisFilteredPupils.sort(comparePupilsByAdmonishedDate);
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
  List<Filter> get stufenFilters => PupilProxy.jahrgangsStufenFilters;
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

int comparePupilsByLastNonProcessedSchooldayEvent(PupilProxy a, PupilProxy b) {
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
    // Handle cases where one or both lists are empty (optional, adjust logic as needed)
    return 0; // Consider them equal, or apply other logic based on your requirements
  }
}
