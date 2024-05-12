// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pupil _$PupilFromJson(Map<String, dynamic> json) => Pupil(
      avatarUrl: json['avatar_url'] as String?,
      communicationPupil: json['communication_pupil'] as String?,
      communicationTutor1: json['communication_tutor1'] as String?,
      communicationTutor2: json['communication_tutor2'] as String?,
      contact: json['contact'] as String?,
      parentsContact: json['parents_contact'] as String?,
      credit: json['credit'] as int,
      creditEarned: json['credit_earned'] as int,
      fiveYears: json['five_years'] as String?,
      individualDevelopmentPlan: json['individual_development_plan'] as int,
      internalId: json['internal_id'] as int,
      ogs: json['ogs'] as bool,
      ogsInfo: json['ogs_info'] as String?,
      pickUpTime: json['pick_up_time'] as String?,
      specialInformation: json['special_information'] as String?,
      pupilCategoryStatuses: (json['pupil_category_statuses'] as List<dynamic>)
          .map((e) => PupilCategoryStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilAdmonitions: (json['pupil_admonitions'] as List<dynamic>)
          .map((e) => Admonition.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilBooks: (json['pupil_books'] as List<dynamic>)
          .map((e) => PupilBook.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilLists: (json['pupil_lists'] as List<dynamic>)
          .map((e) => PupilList.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilGoals: (json['pupil_goals'] as List<dynamic>)
          .map((e) => PupilGoal.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilMissedClasses: (json['pupil_missed_classes'] as List<dynamic>)
          .map((e) => MissedClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilWorkbooks: (json['pupil_workbooks'] as List<dynamic>)
          .map((e) => PupilWorkbook.fromJson(e as Map<String, dynamic>))
          .toList(),
      authorizations: (json['authorizations'] as List<dynamic>)
          .map((e) => PupilAuthorization.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditHistoryLogs: (json['credit_history_logs'] as List<dynamic>)
          .map((e) => CreditHistoryLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      competenceGoals: (json['competence_goals'] as List<dynamic>)
          .map((e) => CompetenceGoal.fromJson(e as Map<String, dynamic>))
          .toList(),
      competenceChecks: (json['competence_checks'] as List<dynamic>)
          .map((e) => CompetenceCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..preschoolRevision = json['preschool_revision'] as int?;

Map<String, dynamic> _$PupilToJson(Pupil instance) => <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'communication_pupil': instance.communicationPupil,
      'communication_tutor1': instance.communicationTutor1,
      'communication_tutor2': instance.communicationTutor2,
      'contact': instance.contact,
      'parents_contact': instance.parentsContact,
      'credit': instance.credit,
      'credit_earned': instance.creditEarned,
      'five_years': instance.fiveYears,
      'individual_development_plan': instance.individualDevelopmentPlan,
      'internal_id': instance.internalId,
      'ogs': instance.ogs,
      'ogs_info': instance.ogsInfo,
      'pick_up_time': instance.pickUpTime,
      'preschool_revision': instance.preschoolRevision,
      'special_information': instance.specialInformation,
      'competence_checks': instance.competenceChecks,
      'pupil_category_statuses': instance.pupilCategoryStatuses,
      'pupil_admonitions': instance.pupilAdmonitions,
      'pupil_books': instance.pupilBooks,
      'pupil_lists': instance.pupilLists,
      'pupil_goals': instance.pupilGoals,
      'pupil_missed_classes': instance.pupilMissedClasses,
      'pupil_workbooks': instance.pupilWorkbooks,
      'authorizations': instance.authorizations,
      'credit_history_logs': instance.creditHistoryLogs,
      'competence_goals': instance.competenceGoals,
    };
