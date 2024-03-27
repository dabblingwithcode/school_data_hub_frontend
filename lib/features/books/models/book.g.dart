// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      author: json['author'] as String,
      bookId: json['book_id'] as String,
      imageUrl: json['image_url'] as String,
      isbn: json['isbn'] as int,
      location: json['location'] as String,
      readingLevel: json['reading_level'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'book_id': instance.bookId,
      'image_url': instance.imageUrl,
      'isbn': instance.isbn,
      'location': instance.location,
      'reading_level': instance.readingLevel,
      'title': instance.title,
    };
