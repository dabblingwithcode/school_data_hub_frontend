// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkbookImpl _$$WorkbookImplFromJson(Map<String, dynamic> json) =>
    _$WorkbookImpl(
      isbn: json['isbn'] as int,
      name: json['name'] as String?,
      subject: json['subject'] as String?,
      level: json['level'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$WorkbookImplToJson(_$WorkbookImpl instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'name': instance.name,
      'subject': instance.subject,
      'level': instance.level,
      'image_url': instance.imageUrl,
    };
