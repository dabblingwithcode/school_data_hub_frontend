// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_category_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilCategoryStatus _$PupilCategoryStatusFromJson(Map<String, dynamic> json) =>
    PupilCategoryStatus(
      comment: json['comment'] as String,
      fileId: json['file_id'] as String?,
      goalCategoryId: (json['goal_category_id'] as num).toInt(),
      statusId: json['status_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$PupilCategoryStatusToJson(
        PupilCategoryStatus instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'file_id': instance.fileId,
      'goal_category_id': instance.goalCategoryId,
      'status_id': instance.statusId,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'state': instance.state,
    };
