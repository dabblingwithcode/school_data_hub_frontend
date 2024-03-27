// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_history_log.freezed.dart';
part 'credit_history_log.g.dart';

@freezed
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
