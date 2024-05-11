// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_book.freezed.dart';
part 'pupil_book.g.dart';

@JsonSerializable()
class PupilBook with _$PupilBook {
  factory PupilBook({
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'lent_at') required DateTime lentAt,
    @JsonKey(name: 'lent_by') required String lentBy,
    @JsonKey(name: 'pupil_id') required int pupilId,
    @JsonKey(name: 'received_by') String? receivedBy,
    @JsonKey(name: 'returned_at') DateTime? returnedAt,
    required String state,
  }) = _PupilBook;

  factory PupilBook.fromJson(Map<String, dynamic> json) =>
      _$PupilBookFromJson(json);
}
