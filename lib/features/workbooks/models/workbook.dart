// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Workbook with _$Workbook {
  factory Workbook({
    required int isbn,
    String? name,
    String? subject,
    String? level,
    required int amount,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _Workbook;

  factory Workbook.fromJson(Map<String, dynamic> json) =>
      _$WorkbookFromJson(json);
}
