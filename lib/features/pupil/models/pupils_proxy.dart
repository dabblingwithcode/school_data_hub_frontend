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
import 'package:schuldaten_hub/features/pupil/models/pupil_data_schild.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';

class PupilProxy with ChangeNotifier {
  PupilProxy _pupil;
  PupilDataFromSchild _pupilDataFromSchild;

  void updatePupil(PupilProxy pupil) {
    _pupil = pupil;
    notifyListeners();
  }

  void updateDataFromSchild(PupilDataFromSchild pupilDataFromSchild) {
    _pupilDataFromSchild = pupilDataFromSchild;
    notifyListeners();
  }

  PupilProxy(
      {required PupilProxy pupil,
      required PupilDataFromSchild pupilDataFromSchild})
      : _pupil = pupil,
        _pupilDataFromSchild = pupilDataFromSchild;

  String get firstName => _pupilDataFromSchild.name;
  String get lastName => _pupilDataFromSchild.lastName;
  String get group => _pupilDataFromSchild.group;
  String get schoolyear => _pupilDataFromSchild.schoolyear;
  String? get specialNeeds => _pupilDataFromSchild.specialNeeds;
  String get gender => _pupilDataFromSchild.gender;
  String get language => _pupilDataFromSchild.language;
  String? get family => _pupilDataFromSchild.family;
  DateTime get birthday => _pupilDataFromSchild.birthday;
  DateTime? get migrationSupportEnds =>
      _pupilDataFromSchild.migrationSupportEnds;
  DateTime get pupilSince => _pupilDataFromSchild.pupilSince;
  String? avatarUrl;
  String? communicationPupil;
  String? communicationTutor1;
  String? communicationTutor2;
  String? contact;
  String? parentsContact;
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
