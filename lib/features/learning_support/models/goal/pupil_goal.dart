// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/goal_check.dart';
part 'pupil_goal.g.dart';

@JsonSerializable()
class PupilGoal {
  final int? achieved;
  @JsonKey(name: 'achieved_at')
  final DateTime? achievedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;
  final String? description;
  @JsonKey(name: 'goal_category_id')
  final int goalCategoryId;
  @JsonKey(name: 'goal_checks')
  final List<GoalCheck>? goalChecks;
  @JsonKey(name: 'goal_id')
  final String goalId;
  final String? strategies;

  factory PupilGoal.fromJson(Map<String, dynamic> json) =>
      _$PupilGoalFromJson(json);

  PupilGoal(
      {required this.achieved,
      required this.achievedAt,
      required this.createdAt,
      required this.createdBy,
      required this.description,
      required this.goalCategoryId,
      required this.goalChecks,
      required this.goalId,
      required this.strategies});
}
