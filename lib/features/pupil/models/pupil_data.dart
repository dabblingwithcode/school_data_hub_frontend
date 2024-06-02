// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/books/models/pupil_book.dart';
import 'package:schuldaten_hub/features/competence/models/competence_check.dart';
import 'package:schuldaten_hub/features/competence/models/competence_goal.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';

part 'pupil_data.g.dart';

@JsonSerializable()
class PupilData {
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'communication_pupil')
  final String? communicationPupil;
  @JsonKey(name: 'communication_tutor1')
  final String? communicationTutor1;
  @JsonKey(name: 'communication_tutor2')
  final String? communicationTutor2;
  @JsonKey(name: 'contact')
  final String? contact;
  @JsonKey(name: 'parents_contact')
  final String? parentsContact;
  final int credit;
  @JsonKey(name: 'credit_earned')
  final int creditEarned;
  @JsonKey(name: 'five_years')
  final String? fiveYears;
  @JsonKey(name: 'individual_development_plan')
  final int individualDevelopmentPlan;
  @JsonKey(name: 'internal_id')
  final int internalId;
  final bool ogs;
  @JsonKey(name: 'ogs_info')
  final String? ogsInfo;
  @JsonKey(name: 'pick_up_time')
  final String? pickUpTime;
  @JsonKey(name: 'preschool_revision')
  int? preschoolRevision;
  @JsonKey(name: 'special_information')
  final String? specialInformation;
  @JsonKey(name: 'competence_checks')
  List<CompetenceCheck> competenceChecks;
  @JsonKey(name: 'pupil_category_statuses')
  final List<PupilCategoryStatus> pupilCategoryStatuses;
  @JsonKey(name: 'pupil_admonitions')
  final List<SchooldayEvent> schooldayEvents;
  @JsonKey(name: 'pupil_books')
  final List<PupilBook> pupilBooks;
  @JsonKey(name: 'pupil_lists')
  final List<PupilList> pupilLists;
  @JsonKey(name: 'pupil_goals')
  final List<PupilGoal> pupilGoals;
  @JsonKey(name: 'pupil_missed_classes')
  final List<MissedClass> pupilMissedClasses;
  @JsonKey(name: 'pupil_workbooks')
  final List<PupilWorkbook> pupilWorkbooks;
  final List<PupilAuthorization> authorizations;
  @JsonKey(name: "credit_history_logs")
  final List<CreditHistoryLog> creditHistoryLogs;
  @JsonKey(name: "competence_goals")
  final List<CompetenceGoal> competenceGoals;

  factory PupilData.fromJson(Map<String, dynamic> json) =>
      _$PupilFromJson(json);

  Map<String, dynamic> toJson() => _$PupilToJson(this);

  PupilData({
    required this.avatarUrl,
    required this.communicationPupil,
    required this.communicationTutor1,
    required this.communicationTutor2,
    required this.contact,
    required this.parentsContact,
    required this.credit,
    required this.creditEarned,
    required this.fiveYears,
    required this.individualDevelopmentPlan,
    required this.internalId,
    required this.ogs,
    required this.ogsInfo,
    required this.pickUpTime,
    required this.specialInformation,
    required this.pupilCategoryStatuses,
    required this.schooldayEvents,
    required this.pupilBooks,
    required this.pupilLists,
    required this.pupilGoals,
    required this.pupilMissedClasses,
    required this.pupilWorkbooks,
    required this.authorizations,
    required this.creditHistoryLogs,
    required this.competenceGoals,
    required this.competenceChecks,
  });
}
