// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@JsonSerializable()
class Book with _$Book {
  factory Book({
    required String author,
    @JsonKey(name: "book_id") required String bookId,
    @JsonKey(name: "image_url") required String imageUrl,
    required int isbn,
    required String location,
    @JsonKey(name: "reading_level") required String readingLevel,
    required String title,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
