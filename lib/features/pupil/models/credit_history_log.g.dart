// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_history_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditHistoryLogImpl _$$CreditHistoryLogImplFromJson(
        Map<String, dynamic> json) =>
    _$CreditHistoryLogImpl(
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      credit: json['credit'] as int,
      operation: json['operation'] as int,
    );

Map<String, dynamic> _$$CreditHistoryLogImplToJson(
        _$CreditHistoryLogImpl instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'credit': instance.credit,
      'operation': instance.operation,
    };
