// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admonition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdmonitionImpl _$$AdmonitionImplFromJson(Map<String, dynamic> json) =>
    _$AdmonitionImpl(
      admonitionId: json['admonition_id'] as String,
      admonitionType: json['admonition_type'] as String,
      admonitionReason: json['admonition_reason'] as String,
      admonishingUser: json['admonishing_user'] as String,
      processed: json['processed'] as bool,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
      fileUrl: json['file_url'] as String?,
      processedFileUrl: json['processed_file_url'] as String?,
      admonishedDay: DateTime.parse(json['admonished_day'] as String),
      admonishedPupilId: json['admonished_pupil_id'] as int,
    );

Map<String, dynamic> _$$AdmonitionImplToJson(_$AdmonitionImpl instance) =>
    <String, dynamic>{
      'admonition_id': instance.admonitionId,
      'admonition_type': instance.admonitionType,
      'admonition_reason': instance.admonitionReason,
      'admonishing_user': instance.admonishingUser,
      'processed': instance.processed,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt?.toIso8601String(),
      'file_url': instance.fileUrl,
      'processed_file_url': instance.processedFileUrl,
      'admonished_day': instance.admonishedDay.toIso8601String(),
      'admonished_pupil_id': instance.admonishedPupilId,
    };
