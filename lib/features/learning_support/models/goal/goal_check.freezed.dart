// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GoalCheck _$GoalCheckFromJson(Map<String, dynamic> json) {
  return _GoalCheck.fromJson(json);
}

/// @nodoc
mixin _$GoalCheck {
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCheckCopyWith<GoalCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCheckCopyWith<$Res> {
  factory $GoalCheckCopyWith(GoalCheck value, $Res Function(GoalCheck) then) =
      _$GoalCheckCopyWithImpl<$Res, GoalCheck>;
  @useResult
  $Res call(
      {String comment,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      int id});
}

/// @nodoc
class _$GoalCheckCopyWithImpl<$Res, $Val extends GoalCheck>
    implements $GoalCheckCopyWith<$Res> {
  _$GoalCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalCheckImplCopyWith<$Res>
    implements $GoalCheckCopyWith<$Res> {
  factory _$$GoalCheckImplCopyWith(
          _$GoalCheckImpl value, $Res Function(_$GoalCheckImpl) then) =
      __$$GoalCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String comment,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      int id});
}

/// @nodoc
class __$$GoalCheckImplCopyWithImpl<$Res>
    extends _$GoalCheckCopyWithImpl<$Res, _$GoalCheckImpl>
    implements _$$GoalCheckImplCopyWith<$Res> {
  __$$GoalCheckImplCopyWithImpl(
      _$GoalCheckImpl _value, $Res Function(_$GoalCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? id = null,
  }) {
    return _then(_$GoalCheckImpl(
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalCheckImpl implements _GoalCheck {
  _$GoalCheckImpl(
      {required this.comment,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      required this.id});

  factory _$GoalCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalCheckImplFromJson(json);

  @override
  final String comment;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  final int id;

  @override
  String toString() {
    return 'GoalCheck(comment: $comment, createdAt: $createdAt, createdBy: $createdBy, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalCheckImpl &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, comment, createdAt, createdBy, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalCheckImplCopyWith<_$GoalCheckImpl> get copyWith =>
      __$$GoalCheckImplCopyWithImpl<_$GoalCheckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalCheckImplToJson(
      this,
    );
  }
}

abstract class _GoalCheck implements GoalCheck {
  factory _GoalCheck(
      {required final String comment,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'created_by') required final String createdBy,
      required final int id}) = _$GoalCheckImpl;

  factory _GoalCheck.fromJson(Map<String, dynamic> json) =
      _$GoalCheckImpl.fromJson;

  @override
  String get comment;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$GoalCheckImplCopyWith<_$GoalCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
