import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/books/models/pupil_book.dart';
import 'package:schuldaten_hub/features/competence/models/competence_check.dart';
import 'package:schuldaten_hub/features/competence/models/competence_goal.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_personal_data.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';

class PupilProxy with ChangeNotifier {
  PupilProxy(
      {required Pupil pupil, required PupilPersonalData pupilDataFromSchild})
      : _pupil = pupil,
        _pupilPersonalData = pupilDataFromSchild;

  Pupil _pupil;
  PupilPersonalData _pupilPersonalData;

  bool pupilIsDirty = false;

  void updatePupil(Pupil pupil) {
    _pupil = pupil;
    pupilIsDirty = false;
    notifyListeners();
  }

  /// TODO not sure if it can happen that the personal data changes
  void updateDataFromSchild(PupilPersonalData personalData) {
    _pupilPersonalData = personalData;
    notifyListeners();
  }

  void clearAvtar() {
    _avatarUrlOverride = null;
    pupilIsDirty = true;
    notifyListeners();
  }

  String get firstName => _pupilPersonalData.name;
  String get lastName => _pupilPersonalData.lastName;
  String get group => _pupilPersonalData.group;
  String get schoolyear => _pupilPersonalData.schoolyear;
  String? get specialNeeds => _pupilPersonalData.specialNeeds;
  String get gender => _pupilPersonalData.gender;
  String get language => _pupilPersonalData.language;
  String? get family => _pupilPersonalData.family;
  DateTime get birthday => _pupilPersonalData.birthday;
  DateTime? get migrationSupportEnds => _pupilPersonalData.migrationSupportEnds;
  DateTime get pupilSince => _pupilPersonalData.pupilSince;

  String? _avatarUrlOverride;
  String? get avatarUrl => _avatarUrlOverride ?? _pupil.avatarUrl;

  String? get communicationPupil => _pupil.communicationPupil;
  String? get communicationTutor1 => _pupil.communicationTutor1;
  String? get communicationTutor2 => _pupil.communicationTutor2;
  String? get contact => _pupil.contact;
  String? get parentsContact => _pupil.parentsContact;
  int get credit => _pupil.credit;
  int get creditEarned => _pupil.creditEarned;
  String? get fiveYears => _pupil.fiveYears;
  int get individualDevelopmentPlan => _pupil.individualDevelopmentPlan;
  int get internalId => _pupil.internalId;
  bool get ogs => _pupil.ogs;
  String? get ogsInfo => _pupil.ogsInfo;
  String? get pickUpTime => _pupil.pickUpTime;
  int? get preschoolRevision => _pupil.preschoolRevision;
  String? get specialInformation => _pupil.specialInformation;
  List<CompetenceCheck>? get competenceChecks => _pupil.competenceChecks;
  List<PupilCategoryStatus>? get pupilCategoryStatuses =>
      _pupil.pupilCategoryStatuses;
  List<Admonition>? get pupilAdmonitions => _pupil.pupilAdmonitions;
  List<PupilBook>? get pupilBooks => _pupil.pupilBooks;
  List<PupilList>? get pupilLists => _pupil.pupilLists;
  List<PupilGoal>? get pupilGoals => _pupil.pupilGoals;
  List<MissedClass>? get pupilMissedClasses => _pupil.pupilMissedClasses;
  List<PupilWorkbook>? get pupilWorkbooks => _pupil.pupilWorkbooks;
  List<PupilAuthorization>? get authorizations => _pupil.authorizations;
  List<CreditHistoryLog>? get creditHistoryLogs => _pupil.creditHistoryLogs;
  List<CompetenceGoal>? get competenceGoals => _pupil.competenceGoals;
}
