// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SchooldayImpl _$$SchooldayImplFromJson(Map<String, dynamic> json) =>
    _$SchooldayImpl(
      schoolday: DateTime.parse(json['schoolday'] as String),
    );

Map<String, dynamic> _$$SchooldayImplToJson(_$SchooldayImpl instance) =>
    <String, dynamic>{
      'schoolday': instance.schoolday.toIso8601String(),
    };
