// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'competence_goal.g.dart';

@JsonSerializable()
class CompetenceGoal with _$CompetenceGoal {
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @JsonKey(name: 'competence_goal_id')
  final String competenceGoalId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'strategies')
  final String strategies;
  int? achieved;
  @JsonKey(name: 'achieved_at')
  DateTime? achievedAt;
  @JsonKey(name: 'modified_by')
  String? modifiedBy;

  CompetenceGoal(
      {required this.competenceId,
      required this.competenceGoalId,
      required this.createdAt,
      required this.createdBy,
      required this.pupilId,
      required this.description,
      required this.strategies});

  factory CompetenceGoal.fromJson(Map<String, dynamic> json) =>
      _$CompetenceGoalFromJson(json);
}
