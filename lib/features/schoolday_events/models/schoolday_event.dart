// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'schoolday_event.g.dart';

@JsonSerializable()
class SchooldayEvent {
  @JsonKey(name: 'admonition_id')
  final String schooldayEventId;
  @JsonKey(name: 'admonition_type')
  final String schooldayEventType;
  @JsonKey(name: 'admonition_reason')
  final String schooldayEventReason;
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
  final DateTime schooldayEventDate;
  @JsonKey(name: 'admonished_pupil_id')
  final int admonishedPupilId;

  SchooldayEvent(
      {required this.schooldayEventId,
      required this.schooldayEventType,
      required this.schooldayEventReason,
      required this.admonishingUser,
      required this.processed,
      required this.processedBy,
      required this.processedAt,
      required this.fileUrl,
      required this.processedFileUrl,
      required this.schooldayEventDate,
      required this.admonishedPupilId});

  factory SchooldayEvent.fromJson(Map<String, dynamic> json) =>
      _$SchooldayEventFromJson(json);

  Map<String, dynamic> toJson() => _$SchooldayEventToJson(this);
}
