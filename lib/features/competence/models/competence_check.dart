// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'competence_check.freezed.dart';
part 'competence_check.g.dart';

@freezed
class CompetenceCheck with _$CompetenceCheck {
  factory CompetenceCheck({
    @JsonKey(name: 'check_id') required String checkId,
    required String comment,
    @JsonKey(name: 'competence_id') required int competenceId,
    @JsonKey(name: 'competence_status') required int competenceStatus,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'pupil_id') required int pupilId,
    @JsonKey(name: 'is_report') required bool isReport,
    @JsonKey(name: 'report_id') String? reportId,
    @JsonKey(name: "competence_check_files")
    List<CompetenceCheckFile>? competenceCheckFiles,
  }) = _CompetenceCheck;

  factory CompetenceCheck.fromJson(Map<String, dynamic> json) =>
      _$CompetenceCheckFromJson(json);
}

@freezed
class CompetenceCheckFile with _$CompetenceCheckFile {
  const factory CompetenceCheckFile({
    @JsonKey(name: "check_id") required String checkId,
    @JsonKey(name: "file_id") required String fileId,
    @JsonKey(name: "file_url") required String fileUrl,
  }) = _CompetenceCheckFile;

  factory CompetenceCheckFile.fromJson(Map<String, dynamic> json) =>
      _$CompetenceCheckFileFromJson(json);
}
