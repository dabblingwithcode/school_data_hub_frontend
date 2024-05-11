// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'competence_goal.freezed.dart';
part 'competence_goal.g.dart';

@JsonSerializable()
class CompetenceGoal with _$CompetenceGoal {
  factory CompetenceGoal({
    @JsonKey(name: 'competence_id') required int competenceId,
    @JsonKey(name: 'competence_goal_id') required String competenceGoalId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'pupil_id') required int pupilId,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'strategies') required String strategies,
    int? achieved,
    @JsonKey(name: 'achieved_at') DateTime? achievedAt,
    @JsonKey(name: 'modified_by') String? modifiedBy,
  }) = _CompetenceGoal;

  factory CompetenceGoal.fromJson(Map<String, dynamic> json) =>
      _$CompetenceGoalFromJson(json);
}
