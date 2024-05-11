// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'goal_check.freezed.dart';
part 'goal_check.g.dart';

@JsonSerializable()
class GoalCheck with _$GoalCheck {
  factory GoalCheck({
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    required int id,
  }) = _GoalCheck;

  factory GoalCheck.fromJson(Map<String, dynamic> json) =>
      _$GoalCheckFromJson(json);
}
