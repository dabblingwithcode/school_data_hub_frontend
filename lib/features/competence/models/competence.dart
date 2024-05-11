// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Competence with _$Competence {
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @JsonKey(name: "competence_level")
  final String? competenceLevel;
  @JsonKey(name: 'competence_name')
  final String competenceName;
  @JsonKey(name: 'parent_competence')
  final int? parentCompetence;
  @JsonKey(name: 'indicators')
  final String? indicators;

  Competence(
      {required this.competenceId,
      required this.competenceLevel,
      required this.competenceName,
      required this.parentCompetence,
      required this.indicators});

  factory Competence.fromJson(Map<String, dynamic> json) =>
      _$CompetenceFromJson(json);
}
