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

SchoolSemester _$SchoolSemesterFromJson(Map<String, dynamic> json) =>
    SchoolSemester(
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isFirst: json['is_first'] as bool,
    );

Map<String, dynamic> _$SchoolSemesterToJson(SchoolSemester instance) =>
    <String, dynamic>{
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'is_first': instance.isFirst,
    };
