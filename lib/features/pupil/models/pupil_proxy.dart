// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/books/models/pupil_book.dart';
import 'package:schuldaten_hub/features/competence/models/competence_check.dart';
import 'package:schuldaten_hub/features/competence/models/competence_goal.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_data.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_identity.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';

enum SchoolGrade {
  E1('E1'),
  E2('E2'),
  E3('E3'),
  S3('S3'),
  S4('S4');

  static const stringToValue = {
    'E1': SchoolGrade.E1,
    'E2': SchoolGrade.E2,
    'E3': SchoolGrade.E3,
    'S3': SchoolGrade.S3,
    'S4': SchoolGrade.S4,
  };
  final String value;
  const SchoolGrade(this.value);
}

enum GroupId {
  A1('A1'),
  A2('A2'),
  A3('A3'),
  B1('B1'),
  B2('B2'),
  B3('B3'),
  B4('B4'),
  C1('C1'),
  C2('C2'),
  C3('C3');

  static const stringToValue = {
    'A1': GroupId.A1,
    'A2': GroupId.A2,
    'A3': GroupId.A3,
    'B1': GroupId.B1,
    'B2': GroupId.B2,
    'B3': GroupId.B3,
    'B4': GroupId.B4,
    'C1': GroupId.C1,
    'C2': GroupId.C2,
    'C3': GroupId.C3,
  };

  final String value;
  const GroupId(this.value);
}

class SchoolGradeFilter extends SelectorFilter<PupilProxy, SchoolGrade> {
  SchoolGradeFilter(SchoolGrade schoolGrade)
      : super(name: schoolGrade.value, selector: (proxy) => proxy.schoolGrade);

  @override
  bool matches(PupilProxy item) {
    return selector(item).value == name;
  }
}

class GroupFilter extends SelectorFilter<PupilProxy, GroupId> {
  GroupFilter(GroupId group)
      : super(name: group.value, selector: (proxy) => proxy.groupId);

  @override
  bool matches(PupilProxy item) {
    //debugger();
    return selector(item).value == name;
  }
}

class PupilProxy with ChangeNotifier {
  PupilProxy(
      {required PupilData pupilData, required PupilIdentity pupilIdentity})
      : _pupilIdentity = pupilIdentity {
    updatePupil(pupilData);
  }

  static List<GroupFilter> groupFilters = [
    GroupFilter(GroupId.A1),
    GroupFilter(GroupId.A2),
    GroupFilter(GroupId.A3),
    GroupFilter(GroupId.B1),
    GroupFilter(GroupId.B2),
    GroupFilter(GroupId.B3),
    GroupFilter(GroupId.B4),
    GroupFilter(GroupId.C1),
    GroupFilter(GroupId.C2),
    GroupFilter(GroupId.C3),
  ];
  static List<SchoolGradeFilter> schoolGradeFilters = [
    SchoolGradeFilter(SchoolGrade.E1),
    SchoolGradeFilter(SchoolGrade.E2),
    SchoolGradeFilter(SchoolGrade.E3),
    SchoolGradeFilter(SchoolGrade.S3),
    SchoolGradeFilter(SchoolGrade.S4),
  ];

  late PupilData _pupilData;
  PupilIdentity _pupilIdentity;

  bool pupilIsDirty = false;

  void updatePupil(PupilData pupilData) {
    //if (pupilData == _pupilData) return;
    _pupilData = pupilData;
    // ignore: prefer_for_elements_to_map_fromiterable
    _missedClasses = Map.fromIterable(pupilData.pupilMissedClasses,
        key: (e) => e.missedDay, value: (e) => e);

    pupilIsDirty = false;
    notifyListeners();
  }

  void updatePupilIdentityFromSchoolDatabase(PupilIdentity pupilIdentity) {
    _pupilIdentity = pupilIdentity;
    notifyListeners();
  }

  void clearAvatar() {
    _avatarIdOverride = null;
    _avatarUpdated = true;
    pupilIsDirty = true;
    notifyListeners();
  }

  void updateFromMissedClassesOnASchoolday(List<MissedClass> allMissedClasses) {
    pupilIsDirty = false;

    for (final missedClass in allMissedClasses) {
      // if the missed class is for this pupil

      if (missedClass.missedPupilId == _pupilData.internalId) {
        // if the missed class is not already in the missed classes
        // or if the missed class is different from the one in the missed classes

        if (!_missedClasses.containsKey(missedClass.missedDay) ||
            !(_missedClasses[missedClass.missedDay] == missedClass)) {
          _missedClasses[missedClass.missedDay] = missedClass;
          pupilIsDirty = true;
        }
      }
    }
    var missedClassesValues = List.from(_missedClasses.values);

    /// remove missed classes that are no longer [allMissedClasses]
    for (final pupilMissedClass in missedClassesValues) {
      if (!allMissedClasses.contains(pupilMissedClass)) {
        _missedClasses.remove(pupilMissedClass.missedDay);
        pupilIsDirty = true;
      }
    }
    if (pupilIsDirty) {
      notifyListeners();
    }
  }

  String get firstName => _pupilIdentity.firstName;
  String get lastName => _pupilIdentity.lastName;

  String get group => _pupilIdentity.group;
  GroupId get groupId => GroupId.stringToValue[_pupilIdentity.group]!;

  SchoolGrade get schoolGrade =>
      SchoolGrade.stringToValue[_pupilIdentity.schoolGrade]!;

  String get schoolyear => _pupilIdentity.schoolGrade;
  String? get specialNeeds => _pupilIdentity.specialNeeds;
  String get gender => _pupilIdentity.gender;
  String get language => _pupilIdentity.language;
  String? get family => _pupilIdentity.family;
  DateTime get birthday => _pupilIdentity.birthday;
  DateTime? get migrationSupportEnds => _pupilIdentity.migrationSupportEnds;
  DateTime get pupilSince => _pupilIdentity.pupilSince;

  String? _avatarIdOverride;
  bool _avatarUpdated = false;
  String? get avatarId =>
      _avatarUpdated ? _avatarIdOverride : _pupilData.avatarId;

  String? get communicationPupil => _pupilData.communicationPupil;
  String? get communicationTutor1 => _pupilData.communicationTutor1;
  String? get communicationTutor2 => _pupilData.communicationTutor2;
  String? get contact => _pupilData.contact;
  String? get parentsContact => _pupilData.parentsContact;
  int get credit => _pupilData.credit;
  int get creditEarned => _pupilData.creditEarned;
  String? get fiveYears => _pupilData.fiveYears;
  int get individualDevelopmentPlan => _pupilData.individualDevelopmentPlan;
  int get internalId => _pupilData.internalId;
  bool get ogs => _pupilData.ogs;
  String? get ogsInfo => _pupilData.ogsInfo;
  String? get pickUpTime => _pupilData.pickUpTime;
  int? get preschoolRevision => _pupilData.preschoolRevision;
  String? get specialInformation => _pupilData.specialInformation;
  bool? get emergencyCare => _pupilData.emergencyCare;
  List<CompetenceCheck>? get competenceChecks => _pupilData.competenceChecks;
  List<PupilCategoryStatus>? get pupilCategoryStatuses =>
      _pupilData.pupilCategoryStatuses;
  List<SchooldayEvent>? get schooldayEvents => _pupilData.schooldayEvents;
  List<PupilBook>? get pupilBooks => _pupilData.pupilBooks;
  List<PupilGoal>? get pupilGoals => _pupilData.pupilGoals;

  List<MissedClass>? get pupilMissedClasses => _missedClasses.values.toList();
  Map<DateTime, MissedClass> _missedClasses = {};

  List<PupilWorkbook>? get pupilWorkbooks => _pupilData.pupilWorkbooks;
  List<CreditHistoryLog>? get creditHistoryLogs => _pupilData.creditHistoryLogs;
  List<CompetenceGoal>? get competenceGoals => _pupilData.competenceGoals;
}
