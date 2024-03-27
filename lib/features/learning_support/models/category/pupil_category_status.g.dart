// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_category_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PupilCategoryStatusImpl _$$PupilCategoryStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$PupilCategoryStatusImpl(
      comment: json['comment'] as String,
      fileUrl: json['file_url'] as String?,
      goalCategoryId: json['goal_category_id'] as int,
      statusId: json['status_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$$PupilCategoryStatusImplToJson(
        _$PupilCategoryStatusImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'file_url': instance.fileUrl,
      'goal_category_id': instance.goalCategoryId,
      'status_id': instance.statusId,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'state': instance.state,
    };
