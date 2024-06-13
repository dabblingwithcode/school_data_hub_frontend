// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolday_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchooldayEvent _$SchooldayEventFromJson(Map<String, dynamic> json) =>
    SchooldayEvent(
      schooldayEventId: json['admonition_id'] as String,
      schooldayEventType: json['admonition_type'] as String,
      schooldayEventReason: json['admonition_reason'] as String,
      admonishingUser: json['admonishing_user'] as String,
      processed: json['processed'] as bool,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
      fileId: json['file_id'] as String?,
      processedFileId: json['processed_file_id'] as String?,
      schooldayEventDate: DateTime.parse(json['admonished_day'] as String),
      admonishedPupilId: (json['admonished_pupil_id'] as num).toInt(),
    );

Map<String, dynamic> _$SchooldayEventToJson(SchooldayEvent instance) =>
    <String, dynamic>{
      'admonition_id': instance.schooldayEventId,
      'admonition_type': instance.schooldayEventType,
      'admonition_reason': instance.schooldayEventReason,
      'admonishing_user': instance.admonishingUser,
      'processed': instance.processed,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt?.toIso8601String(),
      'file_id': instance.fileId,
      'processed_file_id': instance.processedFileId,
      'admonished_day': instance.schooldayEventDate.toIso8601String(),
      'admonished_pupil_id': instance.admonishedPupilId,
    };
