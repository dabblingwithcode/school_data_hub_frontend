// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competence_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetenceGoal _$CompetenceGoalFromJson(Map<String, dynamic> json) =>
    CompetenceGoal(
      competenceId: (json['competence_id'] as num).toInt(),
      competenceGoalId: json['competence_goal_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      pupilId: (json['pupil_id'] as num).toInt(),
      description: json['description'] as String,
      strategies: json['strategies'] as String,
    )
      ..achieved = (json['achieved'] as num?)?.toInt()
      ..achievedAt = json['achieved_at'] == null
          ? null
          : DateTime.parse(json['achieved_at'] as String)
      ..modifiedBy = json['modified_by'] as String?;

Map<String, dynamic> _$CompetenceGoalToJson(CompetenceGoal instance) =>
    <String, dynamic>{
      'competence_id': instance.competenceId,
      'competence_goal_id': instance.competenceGoalId,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'pupil_id': instance.pupilId,
      'description': instance.description,
      'strategies': instance.strategies,
      'achieved': instance.achieved,
      'achieved_at': instance.achievedAt?.toIso8601String(),
      'modified_by': instance.modifiedBy,
    };
