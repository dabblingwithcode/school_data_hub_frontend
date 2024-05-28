// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilPersonalData _$PupilPersonalDataFromJson(Map<String, dynamic> json) =>
    PupilPersonalData(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      group: json['group'] as String,
      schoolyear: json['schoolyear'] as String,
      gender: json['gender'] as String,
      language: json['language'] as String,
      family: json['family'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
      pupilSince: DateTime.parse(json['pupilSince'] as String),
      specialNeeds: json['specialNeeds'] as String?,
      migrationSupportEnds: json['migrationSupportEnds'] == null
          ? null
          : DateTime.parse(json['migrationSupportEnds'] as String),
    );

Map<String, dynamic> _$PupilPersonalDataToJson(PupilPersonalData instance) =>
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
