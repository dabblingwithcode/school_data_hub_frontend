// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil_workbook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PupilWorkbook _$PupilWorkbookFromJson(Map<String, dynamic> json) {
  return _PupilWorkbook.fromJson(json);
}

/// @nodoc
mixin _$PupilWorkbook {
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'workbook_isbn')
  int get workbookIsbn => throw _privateConstructorUsedError;
  @JsonKey(name: 'finished_at')
  DateTime? get finishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilWorkbookCopyWith<PupilWorkbook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilWorkbookCopyWith<$Res> {
  factory $PupilWorkbookCopyWith(
          PupilWorkbook value, $Res Function(PupilWorkbook) then) =
      _$PupilWorkbookCopyWithImpl<$Res, PupilWorkbook>;
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      String? state,
      @JsonKey(name: 'workbook_isbn') int workbookIsbn,
      @JsonKey(name: 'finished_at') DateTime? finishedAt});
}

/// @nodoc
class _$PupilWorkbookCopyWithImpl<$Res, $Val extends PupilWorkbook>
    implements $PupilWorkbookCopyWith<$Res> {
  _$PupilWorkbookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? createdBy = null,
    Object? state = freezed,
    Object? workbookIsbn = null,
    Object? finishedAt = freezed,
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
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      workbookIsbn: null == workbookIsbn
          ? _value.workbookIsbn
          : workbookIsbn // ignore: cast_nullable_to_non_nullable
              as int,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PupilWorkbookImplCopyWith<$Res>
    implements $PupilWorkbookCopyWith<$Res> {
  factory _$$PupilWorkbookImplCopyWith(
          _$PupilWorkbookImpl value, $Res Function(_$PupilWorkbookImpl) then) =
      __$$PupilWorkbookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      String? state,
      @JsonKey(name: 'workbook_isbn') int workbookIsbn,
      @JsonKey(name: 'finished_at') DateTime? finishedAt});
}

/// @nodoc
class __$$PupilWorkbookImplCopyWithImpl<$Res>
    extends _$PupilWorkbookCopyWithImpl<$Res, _$PupilWorkbookImpl>
    implements _$$PupilWorkbookImplCopyWith<$Res> {
  __$$PupilWorkbookImplCopyWithImpl(
      _$PupilWorkbookImpl _value, $Res Function(_$PupilWorkbookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? createdBy = null,
    Object? state = freezed,
    Object? workbookIsbn = null,
    Object? finishedAt = freezed,
  }) {
    return _then(_$PupilWorkbookImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      workbookIsbn: null == workbookIsbn
          ? _value.workbookIsbn
          : workbookIsbn // ignore: cast_nullable_to_non_nullable
              as int,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PupilWorkbookImpl implements _PupilWorkbook {
  _$PupilWorkbookImpl(
      {@JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      this.state,
      @JsonKey(name: 'workbook_isbn') required this.workbookIsbn,
      @JsonKey(name: 'finished_at') this.finishedAt});

  factory _$PupilWorkbookImpl.fromJson(Map<String, dynamic> json) =>
      _$$PupilWorkbookImplFromJson(json);

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  final String? state;
  @override
  @JsonKey(name: 'workbook_isbn')
  final int workbookIsbn;
  @override
  @JsonKey(name: 'finished_at')
  final DateTime? finishedAt;

  @override
  String toString() {
    return 'PupilWorkbook(createdAt: $createdAt, createdBy: $createdBy, state: $state, workbookIsbn: $workbookIsbn, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PupilWorkbookImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.workbookIsbn, workbookIsbn) ||
                other.workbookIsbn == workbookIsbn) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdAt, createdBy, state, workbookIsbn, finishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PupilWorkbookImplCopyWith<_$PupilWorkbookImpl> get copyWith =>
      __$$PupilWorkbookImplCopyWithImpl<_$PupilWorkbookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PupilWorkbookImplToJson(
      this,
    );
  }
}

abstract class _PupilWorkbook implements PupilWorkbook {
  factory _PupilWorkbook(
          {@JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'created_by') required final String createdBy,
          final String? state,
          @JsonKey(name: 'workbook_isbn') required final int workbookIsbn,
          @JsonKey(name: 'finished_at') final DateTime? finishedAt}) =
      _$PupilWorkbookImpl;

  factory _PupilWorkbook.fromJson(Map<String, dynamic> json) =
      _$PupilWorkbookImpl.fromJson;

  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  String? get state;
  @override
  @JsonKey(name: 'workbook_isbn')
  int get workbookIsbn;
  @override
  @JsonKey(name: 'finished_at')
  DateTime? get finishedAt;
  @override
  @JsonKey(ignore: true)
  _$$PupilWorkbookImplCopyWith<_$PupilWorkbookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
