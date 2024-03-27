// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalCheckImpl _$$GoalCheckImplFromJson(Map<String, dynamic> json) =>
    _$GoalCheckImpl(
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$GoalCheckImplToJson(_$GoalCheckImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'id': instance.id,
    };
