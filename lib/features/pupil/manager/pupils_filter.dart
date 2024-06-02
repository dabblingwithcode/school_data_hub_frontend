// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

enum PupilProperties {
  specialNeeds,
  ogs,
  notOgs,
  specialInfo,
  migrationSupport,

  preSchoolRevision0,
  preSchoolRevision1,
  preSchoolRevision2,
  preSchoolRevision3,
  developmentPlan1,
  developmentPlan2,
  developmentPlan3,
  fiveYears,
  communicationPupil,
  communicationTutor1,
  communicationTutor2,
  justGirls,
  justBoys,
  schoolListYesResponse,
  schoolListNoResponse,
  schoolListNullResponse,
  schoolListCommentResponse,
  authorizationYesResponse,
  authorizationNoResponse,
  authorizationNullResponse,
  authorizationCommentResponse,
  supportAreaMotorics,
  supportAreaLanguage,
  supportAreaMath,
  supportAreaGerman,
  supportAreaEmotions,
  supportAreaLearning,
}

class RadioButtonFilter extends Filter<PupilProxy> {
  RadioButtonFilter({required super.name});

  bool _isActive1 = false;
  bool _isActive2 = false;

  bool get isActive1 => _isActive1;
  bool get isActive2 => _isActive2;

  void toggle1() {
    if (_isActive1) {
      _isActive1 = false;
    } else {
      _isActive1 = true;
      _isActive2 = false;
    }

    notifyListeners();
  }

  void toggle2() {
    if (_isActive2) {
      _isActive2 = false;
    } else {
      _isActive2 = true;
      _isActive1 = false;
    }

    notifyListeners();
  }

  @override
  void reset() {
    _isActive1 = false;
    _isActive2 = false;
    notifyListeners();
  }

  @override
  bool matches(PupilProxy item) {
    // TODO: implement matches
    throw UnimplementedError();
  }
}

abstract class PupilsFilter implements Listenable {
  ValueListenable<bool> get filtersOn;
  ValueListenable<List<PupilProxy>> get filteredPupils;

  List<Filter> get groupFilters;
  List<Filter> get schoolGradeFilters;
  ValueListenable<PupilSortMode> get sortMode;

  /// must be called when this object is no longer needed
  void dispose();

  // updates the filtered pupils with current filters
  // and sort mode
  void refreshs();

  // reset the filters to its initial state
  void resetFilters();

  // for now, we need to access the switch from outside
  // because additional filters outside are still used
  void setFiltersOn(bool value);

  void setSortMode(PupilSortMode sortMode);
  void sortPupils();
  void setTextFilter(String? text, {bool refresh = true});
}
