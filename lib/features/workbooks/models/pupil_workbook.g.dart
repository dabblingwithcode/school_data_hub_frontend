// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_workbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PupilWorkbookImpl _$$PupilWorkbookImplFromJson(Map<String, dynamic> json) =>
    _$PupilWorkbookImpl(
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      state: json['state'] as String?,
      workbookIsbn: json['workbook_isbn'] as int,
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
    );

Map<String, dynamic> _$$PupilWorkbookImplToJson(_$PupilWorkbookImpl instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'state': instance.state,
      'workbook_isbn': instance.workbookIsbn,
      'finished_at': instance.finishedAt?.toIso8601String(),
    };
