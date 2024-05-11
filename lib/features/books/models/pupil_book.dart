// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PupilBook {
  @JsonKey(name: 'book_id')
  final String bookId;
  @JsonKey(name: 'lent_at')
  final DateTime lentAt;
  @JsonKey(name: 'lent_by')
  final String lentBy;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @JsonKey(name: 'received_by')
  final String? receivedBy;
  @JsonKey(name: 'returned_at')
  final DateTime? returnedAt;
  final String state;

  PupilBook(
      {this.bookId,
      this.lentAt,
      this.lentBy,
      this.pupilId,
      this.receivedBy,
      this.returnedAt,
      this.state});

  factory PupilBook.fromJson(Map<String, dynamic> json) =>
      _$PupilBookFromJson(this);
}
