// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

import 'package:schuldaten_hub/features/competence/models/competence_check.dart';
import 'package:schuldaten_hub/features/competence/models/competence_goal.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/books/models/pupil_book.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';
import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';

@JsonSerializable()
class Pupil with _$Pupil {
  factory Pupil({
    String? firstName,
    String? lastName,
    String? group,
    String? schoolyear,
    String? specialNeeds,
    String? gender,
    String? language,
    String? family,
    DateTime? birthday,
    DateTime? migrationSupportEnds,
    DateTime? pupilSince,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'communication_pupil') String? communicationPupil,
    @JsonKey(name: 'communication_tutor1') String? communicationTutor1,
    @JsonKey(name: 'communication_tutor2') String? communicationTutor2,
    @JsonKey(name: 'contact') String? contact,
    @JsonKey(name: 'parents_contact') String? parentsContact,
    required int credit,
    @JsonKey(name: 'credit_earned') required int creditEarned,
    @JsonKey(name: 'five_years') String? fiveYears,
    @JsonKey(name: 'individual_development_plan')
    required int individualDevelopmentPlan,
    @JsonKey(name: 'internal_id') required int internalId,
    required bool ogs,
    @JsonKey(name: 'ogs_info') String? ogsInfo,
    @JsonKey(name: 'pick_up_time') String? pickUpTime,
    @JsonKey(name: 'preschool_revision') int? preschoolRevision,
    @JsonKey(name: 'special_information') String? specialInformation,
    @JsonKey(name: 'competence_checks') List<CompetenceCheck>? competenceChecks,
    @JsonKey(name: 'pupil_category_statuses')
    List<PupilCategoryStatus>? pupilCategoryStatuses,
    @JsonKey(name: 'pupil_admonitions') List<Admonition>? pupilAdmonitions,
    @JsonKey(name: 'pupil_books') List<PupilBook>? pupilBooks,
    @JsonKey(name: 'pupil_lists') List<PupilList>? pupilLists,
    @JsonKey(name: 'pupil_goals') List<PupilGoal>? pupilGoals,
    @JsonKey(name: 'pupil_missed_classes')
    List<MissedClass>? pupilMissedClasses,
    @JsonKey(name: 'pupil_workbooks') List<PupilWorkbook>? pupilWorkbooks,
    List<PupilAuthorization>? authorizations,
    @JsonKey(name: "credit_history_logs")
    List<CreditHistoryLog>? creditHistoryLogs,
    @JsonKey(name: "competence_goals") List<CompetenceGoal>? competenceGoals,
  }) = _Pupil;

  factory Pupil.fromJson(Map<String, dynamic> json) => _$PupilFromJson(json);
}
