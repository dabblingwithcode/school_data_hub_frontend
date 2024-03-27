// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PupilBook _$PupilBookFromJson(Map<String, dynamic> json) {
  return _PupilBook.fromJson(json);
}

/// @nodoc
mixin _$PupilBook {
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'lent_at')
  DateTime get lentAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'lent_by')
  String get lentBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_id')
  int get pupilId => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_by')
  String? get receivedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'returned_at')
  DateTime? get returnedAt => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilBookCopyWith<PupilBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilBookCopyWith<$Res> {
  factory $PupilBookCopyWith(PupilBook value, $Res Function(PupilBook) then) =
      _$PupilBookCopyWithImpl<$Res, PupilBook>;
  @useResult
  $Res call(
      {@JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'lent_at') DateTime lentAt,
      @JsonKey(name: 'lent_by') String lentBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'received_by') String? receivedBy,
      @JsonKey(name: 'returned_at') DateTime? returnedAt,
      String state});
}

/// @nodoc
class _$PupilBookCopyWithImpl<$Res, $Val extends PupilBook>
    implements $PupilBookCopyWith<$Res> {
  _$PupilBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? lentAt = null,
    Object? lentBy = null,
    Object? pupilId = null,
    Object? receivedBy = freezed,
    Object? returnedAt = freezed,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      lentAt: null == lentAt
          ? _value.lentAt
          : lentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lentBy: null == lentBy
          ? _value.lentBy
          : lentBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      returnedAt: freezed == returnedAt
          ? _value.returnedAt
          : returnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PupilBookImplCopyWith<$Res>
    implements $PupilBookCopyWith<$Res> {
  factory _$$PupilBookImplCopyWith(
          _$PupilBookImpl value, $Res Function(_$PupilBookImpl) then) =
      __$$PupilBookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'lent_at') DateTime lentAt,
      @JsonKey(name: 'lent_by') String lentBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'received_by') String? receivedBy,
      @JsonKey(name: 'returned_at') DateTime? returnedAt,
      String state});
}

/// @nodoc
class __$$PupilBookImplCopyWithImpl<$Res>
    extends _$PupilBookCopyWithImpl<$Res, _$PupilBookImpl>
    implements _$$PupilBookImplCopyWith<$Res> {
  __$$PupilBookImplCopyWithImpl(
      _$PupilBookImpl _value, $Res Function(_$PupilBookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? lentAt = null,
    Object? lentBy = null,
    Object? pupilId = null,
    Object? receivedBy = freezed,
    Object? returnedAt = freezed,
    Object? state = null,
  }) {
    return _then(_$PupilBookImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      lentAt: null == lentAt
          ? _value.lentAt
          : lentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lentBy: null == lentBy
          ? _value.lentBy
          : lentBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      returnedAt: freezed == returnedAt
          ? _value.returnedAt
          : returnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PupilBookImpl implements _PupilBook {
  _$PupilBookImpl(
      {@JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'lent_at') required this.lentAt,
      @JsonKey(name: 'lent_by') required this.lentBy,
      @JsonKey(name: 'pupil_id') required this.pupilId,
      @JsonKey(name: 'received_by') this.receivedBy,
      @JsonKey(name: 'returned_at') this.returnedAt,
      required this.state});

  factory _$PupilBookImpl.fromJson(Map<String, dynamic> json) =>
      _$$PupilBookImplFromJson(json);

  @override
  @JsonKey(name: 'book_id')
  final String bookId;
  @override
  @JsonKey(name: 'lent_at')
  final DateTime lentAt;
  @override
  @JsonKey(name: 'lent_by')
  final String lentBy;
  @override
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @override
  @JsonKey(name: 'received_by')
  final String? receivedBy;
  @override
  @JsonKey(name: 'returned_at')
  final DateTime? returnedAt;
  @override
  final String state;

  @override
  String toString() {
    return 'PupilBook(bookId: $bookId, lentAt: $lentAt, lentBy: $lentBy, pupilId: $pupilId, receivedBy: $receivedBy, returnedAt: $returnedAt, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PupilBookImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.lentAt, lentAt) || other.lentAt == lentAt) &&
            (identical(other.lentBy, lentBy) || other.lentBy == lentBy) &&
            (identical(other.pupilId, pupilId) || other.pupilId == pupilId) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy) &&
            (identical(other.returnedAt, returnedAt) ||
                other.returnedAt == returnedAt) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bookId, lentAt, lentBy, pupilId,
      receivedBy, returnedAt, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PupilBookImplCopyWith<_$PupilBookImpl> get copyWith =>
      __$$PupilBookImplCopyWithImpl<_$PupilBookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PupilBookImplToJson(
      this,
    );
  }
}

abstract class _PupilBook implements PupilBook {
  factory _PupilBook(
      {@JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'lent_at') required final DateTime lentAt,
      @JsonKey(name: 'lent_by') required final String lentBy,
      @JsonKey(name: 'pupil_id') required final int pupilId,
      @JsonKey(name: 'received_by') final String? receivedBy,
      @JsonKey(name: 'returned_at') final DateTime? returnedAt,
      required final String state}) = _$PupilBookImpl;

  factory _PupilBook.fromJson(Map<String, dynamic> json) =
      _$PupilBookImpl.fromJson;

  @override
  @JsonKey(name: 'book_id')
  String get bookId;
  @override
  @JsonKey(name: 'lent_at')
  DateTime get lentAt;
  @override
  @JsonKey(name: 'lent_by')
  String get lentBy;
  @override
  @JsonKey(name: 'pupil_id')
  int get pupilId;
  @override
  @JsonKey(name: 'received_by')
  String? get receivedBy;
  @override
  @JsonKey(name: 'returned_at')
  DateTime? get returnedAt;
  @override
  String get state;
  @override
  @JsonKey(ignore: true)
  _$$PupilBookImplCopyWith<_$PupilBookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
