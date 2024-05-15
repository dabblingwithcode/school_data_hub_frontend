// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolday_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchooldayEvent _$SchooldayEventFromJson(Map<String, dynamic> json) =>
    SchooldayEvent(
      schooldayEventId: json['schooldayEvent_id'] as String,
      schooldayEventType: json['schooldayEvent_type'] as String,
      schooldayEventReason: json['schooldayEvent_reason'] as String,
      admonishingUser: json['admonishing_user'] as String,
      processed: json['processed'] as bool,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
      fileUrl: json['file_url'] as String?,
      processedFileUrl: json['processed_file_url'] as String?,
      schooldayEventDate: DateTime.parse(json['admonished_day'] as String),
      admonishedPupilId: json['admonished_pupil_id'] as int,
    );

Map<String, dynamic> _$SchooldayEventToJson(SchooldayEvent instance) =>
    <String, dynamic>{
      'schooldayEvent_id': instance.schooldayEventId,
      'schooldayEvent_type': instance.schooldayEventType,
      'schooldayEvent_reason': instance.schooldayEventReason,
      'admonishing_user': instance.admonishingUser,
      'processed': instance.processed,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt?.toIso8601String(),
      'file_url': instance.fileUrl,
      'processed_file_url': instance.processedFileUrl,
      'admonished_day': instance.schooldayEventDate.toIso8601String(),
      'admonished_pupil_id': instance.admonishedPupilId,
    };
