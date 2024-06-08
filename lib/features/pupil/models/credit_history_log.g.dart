// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_history_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditHistoryLog _$CreditHistoryLogFromJson(Map<String, dynamic> json) =>
    CreditHistoryLog(
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      credit: (json['credit'] as num).toInt(),
      operation: (json['operation'] as num).toInt(),
    );

Map<String, dynamic> _$CreditHistoryLogToJson(CreditHistoryLog instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'credit': instance.credit,
      'operation': instance.operation,
    };
