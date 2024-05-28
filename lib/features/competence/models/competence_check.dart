// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'competence_check.g.dart';

@JsonSerializable()
class CompetenceCheck {
  @JsonKey(name: 'check_id')
  final String checkId;
  final String comment;
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @JsonKey(name: 'competence_status')
  final int competenceStatus;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @JsonKey(name: 'is_report')
  final bool isReport;
  @JsonKey(name: 'report_id')
  final String? reportId;
  @JsonKey(name: "competence_check_files")
  final List<CompetenceCheckFile>? competenceCheckFiles;

  CompetenceCheck(
      {required this.checkId,
      required this.comment,
      required this.competenceId,
      required this.competenceStatus,
      required this.createdAt,
      required this.createdBy,
      required this.pupilId,
      required this.isReport,
      required this.reportId,
      required this.competenceCheckFiles});

  factory CompetenceCheck.fromJson(Map<String, dynamic> json) =>
      _$CompetenceCheckFromJson(json);

  Map<String, dynamic> toJson() => _$CompetenceCheckToJson(this);
}

@JsonSerializable()
class CompetenceCheckFile {
  @JsonKey(name: "check_id")
  final String checkId;
  @JsonKey(name: "file_id")
  final String fileId;
  @JsonKey(name: "file_url")
  final String fileUrl;

  CompetenceCheckFile(
      {required this.checkId, required this.fileId, required this.fileUrl});

  factory CompetenceCheckFile.fromJson(Map<String, dynamic> json) =>
      _$CompetenceCheckFileFromJson(json);

  Map<String, dynamic> toJson() => _$CompetenceCheckFileToJson(this);
}
