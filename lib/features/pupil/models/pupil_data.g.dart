// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilData _$PupilDataFromJson(Map<String, dynamic> json) => PupilData(
      avatarId: json['avatar_id'] as String?,
      communicationPupil: json['communication_pupil'] as String?,
      communicationTutor1: json['communication_tutor1'] as String?,
      communicationTutor2: json['communication_tutor2'] as String?,
      contact: json['contact'] as String?,
      parentsContact: json['parents_contact'] as String?,
      credit: (json['credit'] as num).toInt(),
      creditEarned: (json['credit_earned'] as num).toInt(),
      fiveYears: json['five_years'] as String?,
      individualDevelopmentPlan:
          (json['individual_development_plan'] as num).toInt(),
      internalId: (json['internal_id'] as num).toInt(),
      ogs: json['ogs'] as bool,
      ogsInfo: json['ogs_info'] as String?,
      pickUpTime: json['pick_up_time'] as String?,
      specialInformation: json['special_information'] as String?,
      preschoolRevision: (json['preschool_revision'] as num?)?.toInt(),
      emergencyCare: json['emergency_care'] as bool?,
      pupilCategoryStatuses: (json['pupil_category_statuses'] as List<dynamic>)
          .map((e) => PupilCategoryStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      schooldayEvents: (json['pupil_admonitions'] as List<dynamic>)
          .map((e) => SchooldayEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      pupilBooks: (json['pupil_books'] as List<dynamic>)
          .map((e) => PupilBook.fromJson(e as Map<String, dynamic>))
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
      creditHistoryLogs: (json['credit_history_logs'] as List<dynamic>)
          .map((e) => CreditHistoryLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      competenceGoals: (json['competence_goals'] as List<dynamic>)
          .map((e) => CompetenceGoal.fromJson(e as Map<String, dynamic>))
          .toList(),
      competenceChecks: (json['competence_checks'] as List<dynamic>)
          .map((e) => CompetenceCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PupilDataToJson(PupilData instance) => <String, dynamic>{
      'avatar_id': instance.avatarId,
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
      'emergency_care': instance.emergencyCare,
      'competence_checks': instance.competenceChecks,
      'pupil_category_statuses': instance.pupilCategoryStatuses,
      'pupil_admonitions': instance.schooldayEvents,
      'pupil_books': instance.pupilBooks,
      'pupil_goals': instance.pupilGoals,
      'pupil_missed_classes': instance.pupilMissedClasses,
      'pupil_workbooks': instance.pupilWorkbooks,
      'credit_history_logs': instance.creditHistoryLogs,
      'competence_goals': instance.competenceGoals,
    };
