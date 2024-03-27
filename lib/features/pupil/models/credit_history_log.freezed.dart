// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_history_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreditHistoryLog _$CreditHistoryLogFromJson(Map<String, dynamic> json) {
  return _CreditHistoryLog.fromJson(json);
}

/// @nodoc
mixin _$CreditHistoryLog {
  @JsonKey(name: "created_at")
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "created_by")
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: "credit")
  int get credit => throw _privateConstructorUsedError;
  @JsonKey(name: "operation")
  int get operation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditHistoryLogCopyWith<CreditHistoryLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditHistoryLogCopyWith<$Res> {
  factory $CreditHistoryLogCopyWith(
          CreditHistoryLog value, $Res Function(CreditHistoryLog) then) =
      _$CreditHistoryLogCopyWithImpl<$Res, CreditHistoryLog>;
  @useResult
  $Res call(
      {@JsonKey(name: "created_at") DateTime createdAt,
      @JsonKey(name: "created_by") String createdBy,
      @JsonKey(name: "credit") int credit,
      @JsonKey(name: "operation") int operation});
}

/// @nodoc
class _$CreditHistoryLogCopyWithImpl<$Res, $Val extends CreditHistoryLog>
    implements $CreditHistoryLogCopyWith<$Res> {
  _$CreditHistoryLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? createdBy = null,
    Object? credit = null,
    Object? operation = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditHistoryLogImplCopyWith<$Res>
    implements $CreditHistoryLogCopyWith<$Res> {
  factory _$$CreditHistoryLogImplCopyWith(_$CreditHistoryLogImpl value,
          $Res Function(_$CreditHistoryLogImpl) then) =
      __$$CreditHistoryLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "created_at") DateTime createdAt,
      @JsonKey(name: "created_by") String createdBy,
      @JsonKey(name: "credit") int credit,
      @JsonKey(name: "operation") int operation});
}

/// @nodoc
class __$$CreditHistoryLogImplCopyWithImpl<$Res>
    extends _$CreditHistoryLogCopyWithImpl<$Res, _$CreditHistoryLogImpl>
    implements _$$CreditHistoryLogImplCopyWith<$Res> {
  __$$CreditHistoryLogImplCopyWithImpl(_$CreditHistoryLogImpl _value,
      $Res Function(_$CreditHistoryLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? createdBy = null,
    Object? credit = null,
    Object? operation = null,
  }) {
    return _then(_$CreditHistoryLogImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditHistoryLogImpl implements _CreditHistoryLog {
  const _$CreditHistoryLogImpl(
      {@JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "created_by") required this.createdBy,
      @JsonKey(name: "credit") required this.credit,
      @JsonKey(name: "operation") required this.operation});

  factory _$CreditHistoryLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditHistoryLogImplFromJson(json);

  @override
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @override
  @JsonKey(name: "created_by")
  final String createdBy;
  @override
  @JsonKey(name: "credit")
  final int credit;
  @override
  @JsonKey(name: "operation")
  final int operation;

  @override
  String toString() {
    return 'CreditHistoryLog(createdAt: $createdAt, createdBy: $createdBy, credit: $credit, operation: $operation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditHistoryLogImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.credit, credit) || other.credit == credit) &&
            (identical(other.operation, operation) ||
                other.operation == operation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, createdBy, credit, operation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditHistoryLogImplCopyWith<_$CreditHistoryLogImpl> get copyWith =>
      __$$CreditHistoryLogImplCopyWithImpl<_$CreditHistoryLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditHistoryLogImplToJson(
      this,
    );
  }
}

abstract class _CreditHistoryLog implements CreditHistoryLog {
  const factory _CreditHistoryLog(
          {@JsonKey(name: "created_at") required final DateTime createdAt,
          @JsonKey(name: "created_by") required final String createdBy,
          @JsonKey(name: "credit") required final int credit,
          @JsonKey(name: "operation") required final int operation}) =
      _$CreditHistoryLogImpl;

  factory _CreditHistoryLog.fromJson(Map<String, dynamic> json) =
      _$CreditHistoryLogImpl.fromJson;

  @override
  @JsonKey(name: "created_at")
  DateTime get createdAt;
  @override
  @JsonKey(name: "created_by")
  String get createdBy;
  @override
  @JsonKey(name: "credit")
  int get credit;
  @override
  @JsonKey(name: "operation")
  int get operation;
  @override
  @JsonKey(ignore: true)
  _$$CreditHistoryLogImplCopyWith<_$CreditHistoryLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
