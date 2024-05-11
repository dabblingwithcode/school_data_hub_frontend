// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schoolday _$SchooldayFromJson(Map<String, dynamic> json) => Schoolday(
      schoolday: DateTime.parse(json['schoolday'] as String),
    );

Map<String, dynamic> _$SchooldayToJson(Schoolday instance) => <String, dynamic>{
      'schoolday': instance.schoolday.toIso8601String(),
    };
