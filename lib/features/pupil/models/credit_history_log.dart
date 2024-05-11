// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreditHistoryLog with _$CreditHistoryLog {
  const factory CreditHistoryLog({
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "created_by") required String createdBy,
    @JsonKey(name: "credit") required int credit,
    @JsonKey(name: "operation") required int operation,
  }) = _CreditHistoryLog;

  factory CreditHistoryLog.fromJson(Map<String, dynamic> json) =>
      _$CreditHistoryLogFromJson(json);
}
