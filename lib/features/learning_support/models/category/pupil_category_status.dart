// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_category_status.freezed.dart';
part 'pupil_category_status.g.dart';

@JsonSerializable()
class PupilCategoryStatus with _$PupilCategoryStatus {
  factory PupilCategoryStatus({
    required String comment,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'goal_category_id') required int goalCategoryId,
    @JsonKey(name: 'status_id') required String statusId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    required String state,
  }) = _PupilCategoryStatus;

  factory PupilCategoryStatus.fromJson(Map<String, dynamic> json) =>
      _$PupilCategoryStatusFromJson(json);
}
