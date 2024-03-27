// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  String get author => throw _privateConstructorUsedError;
  @JsonKey(name: "book_id")
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: "image_url")
  String get imageUrl => throw _privateConstructorUsedError;
  int get isbn => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: "reading_level")
  String get readingLevel => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {String author,
      @JsonKey(name: "book_id") String bookId,
      @JsonKey(name: "image_url") String imageUrl,
      int isbn,
      String location,
      @JsonKey(name: "reading_level") String readingLevel,
      String title});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? bookId = null,
    Object? imageUrl = null,
    Object? isbn = null,
    Object? location = null,
    Object? readingLevel = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      readingLevel: null == readingLevel
          ? _value.readingLevel
          : readingLevel // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookImplCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$BookImplCopyWith(
          _$BookImpl value, $Res Function(_$BookImpl) then) =
      __$$BookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String author,
      @JsonKey(name: "book_id") String bookId,
      @JsonKey(name: "image_url") String imageUrl,
      int isbn,
      String location,
      @JsonKey(name: "reading_level") String readingLevel,
      String title});
}

/// @nodoc
class __$$BookImplCopyWithImpl<$Res>
    extends _$BookCopyWithImpl<$Res, _$BookImpl>
    implements _$$BookImplCopyWith<$Res> {
  __$$BookImplCopyWithImpl(_$BookImpl _value, $Res Function(_$BookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? bookId = null,
    Object? imageUrl = null,
    Object? isbn = null,
    Object? location = null,
    Object? readingLevel = null,
    Object? title = null,
  }) {
    return _then(_$BookImpl(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      readingLevel: null == readingLevel
          ? _value.readingLevel
          : readingLevel // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookImpl implements _Book {
  _$BookImpl(
      {required this.author,
      @JsonKey(name: "book_id") required this.bookId,
      @JsonKey(name: "image_url") required this.imageUrl,
      required this.isbn,
      required this.location,
      @JsonKey(name: "reading_level") required this.readingLevel,
      required this.title});

  factory _$BookImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookImplFromJson(json);

  @override
  final String author;
  @override
  @JsonKey(name: "book_id")
  final String bookId;
  @override
  @JsonKey(name: "image_url")
  final String imageUrl;
  @override
  final int isbn;
  @override
  final String location;
  @override
  @JsonKey(name: "reading_level")
  final String readingLevel;
  @override
  final String title;

  @override
  String toString() {
    return 'Book(author: $author, bookId: $bookId, imageUrl: $imageUrl, isbn: $isbn, location: $location, readingLevel: $readingLevel, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.readingLevel, readingLevel) ||
                other.readingLevel == readingLevel) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, author, bookId, imageUrl, isbn,
      location, readingLevel, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      __$$BookImplCopyWithImpl<_$BookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookImplToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  factory _Book(
      {required final String author,
      @JsonKey(name: "book_id") required final String bookId,
      @JsonKey(name: "image_url") required final String imageUrl,
      required final int isbn,
      required final String location,
      @JsonKey(name: "reading_level") required final String readingLevel,
      required final String title}) = _$BookImpl;

  factory _Book.fromJson(Map<String, dynamic> json) = _$BookImpl.fromJson;

  @override
  String get author;
  @override
  @JsonKey(name: "book_id")
  String get bookId;
  @override
  @JsonKey(name: "image_url")
  String get imageUrl;
  @override
  int get isbn;
  @override
  String get location;
  @override
  @JsonKey(name: "reading_level")
  String get readingLevel;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
