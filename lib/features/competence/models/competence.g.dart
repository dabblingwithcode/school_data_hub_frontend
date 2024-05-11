// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Competence _$CompetenceFromJson(Map<String, dynamic> json) => Competence(
      competenceId: json['competence_id'] as int,
      competenceLevel: json['competence_level'] as String?,
      competenceName: json['competence_name'] as String,
      parentCompetence: json['parent_competence'] as int?,
      indicators: json['indicators'] as String?,
    );

Map<String, dynamic> _$CompetenceToJson(Competence instance) =>
    <String, dynamic>{
      'competence_id': instance.competenceId,
      'competence_level': instance.competenceLevel,
      'competence_name': instance.competenceName,
      'parent_competence': instance.parentCompetence,
      'indicators': instance.indicators,
    };
