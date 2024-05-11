// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'admonition.g.dart';

@JsonSerializable()
class Admonition  {
  @JsonKey(name: 'admonition_id')
  final String admonitionId;
  @JsonKey(name: 'admonition_type')
  final String admonitionType;
  @JsonKey(name: 'admonition_reason')
  final String admonitionReason;
  @JsonKey(name: 'admonishing_user')
  final String admonishingUser;
  @JsonKey(name: 'processed')
  final bool processed;
  @JsonKey(name: 'processed_by')
  final String? processedBy;
  @JsonKey(name: 'processed_at')
  final DateTime? processedAt;
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @JsonKey(name: 'processed_file_url')
  final String? processedFileUrl;
  @JsonKey(name: 'admonished_day')
  final DateTime admonishedDay;
  @JsonKey(name: 'admonished_pupil_id')
  final int admonishedPupilId;

  Admonition(
      {required this.admonitionId,
      required this.admonitionType,
      required this.admonitionReason,
      required this.admonishingUser,
      required this.processed,
      required this.processedBy,
      required this.processedAt,
      required this.fileUrl,
      required this.processedFileUrl,
      required this.admonishedDay,
      required this.admonishedPupilId});

  factory Admonition.fromJson(Map<String, dynamic> json) =>
      _$AdmonitionFromJson(json);
}
