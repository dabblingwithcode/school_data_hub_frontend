import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilsFilterImplementation with ChangeNotifier implements PupilsFilter {
  PupilsFilterImplementation(
    PupilManager pupilsManager, {
    Map<PupilFilter, bool>? filterState,
    Map<PupilSortMode, bool>? sortMode,
  })  : _filterState = filterState ?? {},
        _sortMode = sortMode ?? {},
        _pupilsManager = pupilsManager {
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
  bool get filtersOn => _filtersOn;
  final _filtersOn = false;

  @override
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;
  final ValueNotifier<List<PupilProxy>> _filteredPupils = ValueNotifier([]);

  @override
  Map<PupilFilter, bool> get filterState => _filterState;
  final Map<PupilFilter, bool> _filterState;

  @override
  Map<PupilSortMode, bool> get sortMode => _sortMode;
  final Map<PupilSortMode, bool> _sortMode;

  @override
  bool getFilterState(PupilFilter filter) {
    assert(_filterState.containsKey(filter));
    return _filterState[filter] ?? false;
  }

  // updates the filtered pupils with current filters
  // and sort mode
  @override
  void refreshs() {
    throw UnimplementedError();
  }

  // reset the filters to its initial state
  @override
  void resetFilters() {
    throw UnimplementedError();
  }

  // Set modified filter value
  @override
  void setFilter(PupilFilter filter, bool isActive, {bool refresh = true}) {
    _filterState[filter] = isActive;
    if (refresh) {
      refreshs();
    }
    notifyListeners();
  }

  @override
  void setSortMode(PupilSortMode sortMode, bool isActive,
      {bool refresh = true}) {
    _sortMode[sortMode] = isActive;
    if (refresh) {
      refreshs();
    }
    notifyListeners();
  }

  void setTextFilter(String? text, {bool refresh = true}) {
    throw UnimplementedError();
  }
}
