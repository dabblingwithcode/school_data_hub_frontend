import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

abstract class FilteredPupils {
  ValueListenable<bool> get filtersOn;
  ValueListenable<List<PupilProxy>> get filteredPupils;

  ValueListenable<Map<PupilFilter, bool>> get filterState;
  ValueListenable<Map<PupilSortMode, bool>> get sortMode;

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
