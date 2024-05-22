import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilTextFilter extends Filter<PupilProxy> {
  PupilTextFilter({
    required super.name,
  });

  String _text = '';
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
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
    PupilManager pupilsManager, {
    Map<PupilSortMode, bool>? sortMode,
  })  : _sortMode = sortMode ?? {},
        _pupilsManager = pupilsManager {
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
  Map<PupilSortMode, bool> get sortMode => _sortMode;
  final Map<PupilSortMode, bool> _sortMode;

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
    final List<PupilProxy> matching = [];

    final allPupils = _pupilsManager.allPupils;

    if (!allFilters.any((x) => x.isActive)) {
      _filteredPupils.value = allPupils;
      _filtersOn.value = false;
      return;
    }
    for (final pupil in allPupils) {
      for (final filter in allFilters) {
        if (filter.isActive && filter.matches(pupil)) {
          matching.add(pupil);
          break;
        }
      }

      _filteredPupils.value = matching;

      _filtersOn.value = true;
    }
  }

  // reset the filters to its initial state
  @override
  void resetFilters() {
    for (final filter in allFilters) {
      filter.reset();
    }
  }

  // Set modified filter value

  @override
  void setSortMode(PupilSortMode sortMode, bool isActive,
      {bool refresh = true}) {
    _sortMode[sortMode] = isActive;
    if (refresh) {
      refreshs();
    }
    notifyListeners();
  }

  @override
  void setTextFilter(String? text, {bool refresh = true}) {
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
