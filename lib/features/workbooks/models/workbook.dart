// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Workbook {
  Workbook(
      {required this.isbn,
      required this.name,
      required this.subject,
      required this.level,
      required this.amount,
      required this.imageUrl});

  final int isbn;
  final String? name;
  final String? subject;
  final String? level;
  final int amount;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  factory Workbook.fromJson(Map<String, dynamic> json) =>
      _$WorkbookFromJson(this);
}
