// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PupilBaseImpl _$$PupilBaseImplFromJson(Map<String, dynamic> json) =>
    _$PupilBaseImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      group: json['group'] as String,
      schoolyear: json['schoolyear'] as String,
      specialNeeds: json['specialNeeds'] as String?,
      gender: json['gender'] as String,
      language: json['language'] as String,
      family: json['family'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
      migrationSupportEnds: json['migrationSupportEnds'] == null
          ? null
          : DateTime.parse(json['migrationSupportEnds'] as String),
      pupilSince: DateTime.parse(json['pupilSince'] as String),
    );

Map<String, dynamic> _$$PupilBaseImplToJson(_$PupilBaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'group': instance.group,
      'schoolyear': instance.schoolyear,
      'specialNeeds': instance.specialNeeds,
      'gender': instance.gender,
      'language': instance.language,
      'family': instance.family,
      'birthday': instance.birthday.toIso8601String(),
      'migrationSupportEnds': instance.migrationSupportEnds?.toIso8601String(),
      'pupilSince': instance.pupilSince.toIso8601String(),
    };

_$PupilBaseListImpl _$$PupilBaseListImplFromJson(Map<String, dynamic> json) =>
    _$PupilBaseListImpl(
      pupilBaseList: (json['pupilBaseList'] as List<dynamic>)
          .map((e) => PupilBase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PupilBaseListImplToJson(_$PupilBaseListImpl instance) =>
    <String, dynamic>{
      'pupilBaseList': instance.pupilBaseList,
    };
