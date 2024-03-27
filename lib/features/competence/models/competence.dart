// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'competence.freezed.dart';
part 'competence.g.dart';

@freezed
class Competence with _$Competence {
  factory Competence({
    @JsonKey(name: 'competence_id') required int competenceId,
    @JsonKey(name: "competence_level") String? competenceLevel,
    @JsonKey(name: 'competence_name') required String competenceName,
    @JsonKey(name: 'parent_competence') int? parentCompetence,
    @JsonKey(name: 'indicators') String? indicators,
  }) = _Competence;

  factory Competence.fromJson(Map<String, dynamic> json) =>
      _$CompetenceFromJson(json);
}
