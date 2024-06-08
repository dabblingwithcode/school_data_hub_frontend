// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workbook _$WorkbookFromJson(Map<String, dynamic> json) => Workbook(
      isbn: (json['isbn'] as num).toInt(),
      name: json['name'] as String?,
      subject: json['subject'] as String?,
      level: json['level'] as String?,
      amount: (json['amount'] as num).toInt(),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$WorkbookToJson(Workbook instance) => <String, dynamic>{
      'isbn': instance.isbn,
      'name': instance.name,
      'subject': instance.subject,
      'level': instance.level,
      'amount': instance.amount,
      'image_url': instance.imageUrl,
    };
