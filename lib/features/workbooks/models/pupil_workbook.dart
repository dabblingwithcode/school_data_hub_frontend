// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
part 'pupil_workbook.g.dart';

@JsonSerializable()
class PupilWorkbook {
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;
  final String? state;
  @JsonKey(name: 'workbook_isbn')
  final int workbookIsbn;
  @JsonKey(name: 'finished_at')
  final DateTime? finishedAt;

  factory PupilWorkbook.fromJson(Map<String, dynamic> json) =>
      _$PupilWorkbookFromJson(json);

  Map<String, dynamic> toJson() => _$PupilWorkbookToJson(this);

  PupilWorkbook(
      {required this.createdAt,
      required this.createdBy,
      required this.state,
      required this.workbookIsbn,
      required this.finishedAt});
}
