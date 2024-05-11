// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_workbook.freezed.dart';
part 'pupil_workbook.g.dart';

@JsonSerializable()
class PupilWorkbook with _$PupilWorkbook {
  factory PupilWorkbook({
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    String? state,
    @JsonKey(name: 'workbook_isbn') required int workbookIsbn,
    @JsonKey(name: 'finished_at') DateTime? finishedAt,
  }) = _PupilWorkbook;

  factory PupilWorkbook.fromJson(Map<String, dynamic> json) =>
      _$PupilWorkbookFromJson(json);
}
