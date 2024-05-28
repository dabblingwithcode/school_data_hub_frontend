// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
part 'goal_check.g.dart';

@JsonSerializable()
class GoalCheck {
  final String comment;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;
  final int id;

  GoalCheck(
      {required this.comment,
      required this.createdAt,
      required this.createdBy,
      required this.id});

  factory GoalCheck.fromJson(Map<String, dynamic> json) =>
      _$GoalCheckFromJson(json);

  Map<String, dynamic> toJson() => _$GoalCheckToJson(this);
}
