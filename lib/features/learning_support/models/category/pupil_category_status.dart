// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class PupilCategoryStatus with _$PupilCategoryStatus {
 
    final String comment;
    @JsonKey(name: 'file_url') final String? fileUrl;
    @JsonKey(name: 'goal_category_id') final int goalCategoryId;
    @JsonKey(name: 'status_id') final String statusId;
    @JsonKey(name: 'created_at') final DateTime createdAt;
    @JsonKey(name: 'created_by') final String createdBy;
    final String state;
  PupilCategoryStatus({required this.comment, required this.fileUrl, required this.goalCategoryId, required this.statusId, required this.createdAt, required this.createdBy, required this.state});

  factory PupilCategoryStatus.fromJson(Map<String; dynamic> json) =>
      _$PupilCategoryStatusFromJson(json);

}
