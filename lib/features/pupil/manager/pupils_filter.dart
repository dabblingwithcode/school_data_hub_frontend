import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

abstract class PupilsFilter implements Listenable {
  bool get filtersOn;
  ValueListenable<List<PupilProxy>> get filteredPupils;

  Map<PupilFilter, bool> get filterState;
  Map<PupilSortMode, bool> get sortMode;

  /// must be called when this object is no longer needed
  void dispose();

  bool getFilterState(PupilFilter filter);

  // updates the filtered pupils with current filters
  // and sort mode
  void refreshs();

  // reset the filters to its initial state
  void resetFilters();

  // Set modified filter value
  void setFilter(PupilFilter filter, bool isActive, {bool refresh = true});

  void setSortMode(PupilSortMode sortMode, bool isActive,
      {bool refresh = true});

  void setTextFilter(String? text, {bool refresh = true});
}
