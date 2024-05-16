// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

enum AttendanceStatus {
  late('late'),
  missed('missed'),
  home('home'),
  unexcused('unexcused'),
  contacted('contacted'),
  goneHome('goneHome'),
  present('present'),
  notPresent('notPresent');

  final String value;
  const AttendanceStatus(this.value);
}

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

abstract class PupilsFilter implements Listenable {
  ValueListenable<bool> get filtersOn;
  ValueListenable<List<PupilProxy>> get filteredPupils;

  void toggleJahrgangsstufe(Jahrgangsstufe stufe);
  void toggleGroupId(GroupId group);

  bool jahrgangsstufeState(Jahrgangsstufe stufe);
  bool groupIdState(GroupId group);

  /// must be called when this object is no longer needed
  void dispose();

  // updates the filtered pupils with current filters
  // and sort mode
  void refreshs();

  // reset the filters to its initial state
  void resetFilters();

  void setSortMode(PupilSortMode sortMode, bool isActive,
      {bool refresh = true});

  void setTextFilter(String? text, {bool refresh = true});
}
