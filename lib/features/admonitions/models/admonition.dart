// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admonition.freezed.dart';
part 'admonition.g.dart';

@freezed
class Admonition with _$Admonition {
  factory Admonition({
    @JsonKey(name: 'admonition_id') required String admonitionId,
    @JsonKey(name: 'admonition_type') required String admonitionType,
    @JsonKey(name: 'admonition_reason') required String admonitionReason,
    @JsonKey(name: 'admonishing_user') required String admonishingUser,
    @JsonKey(name: 'processed') required bool processed,
    @JsonKey(name: 'processed_by') String? processedBy,
    @JsonKey(name: 'processed_at') DateTime? processedAt,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'admonished_day') required DateTime admonishedDay,
    @JsonKey(name: 'admonished_pupil_id') required int admonishedPupilId,
  }) = _Admonition;

  factory Admonition.fromJson(Map<String, dynamic> json) =>
      _$AdmonitionFromJson(json);
}
