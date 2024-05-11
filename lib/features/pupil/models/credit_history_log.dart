// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreditHistoryLog with _$CreditHistoryLog {
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "created_by")
  final String createdBy;
  @JsonKey(name: "credit")
  final int credit;
  @JsonKey(name: "operation")
  final int operation;

  factory CreditHistoryLog.fromJson(Map<String, dynamic> json) =>
      _$CreditHistoryLogFromJson(json);

  CreditHistoryLog(
      {required this.createdAt,
      required this.createdBy,
      required this.credit,
      required this.operation});
}
