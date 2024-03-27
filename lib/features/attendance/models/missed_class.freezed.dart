// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'missed_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MissedClass _$MissedClassFromJson(Map<String, dynamic> json) {
  return _MissedClass.fromJson(json);
}

/// @nodoc
mixin _$MissedClass {
  String? get contacted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  bool? get excused => throw _privateConstructorUsedError;
  @JsonKey(name: 'minutes_late')
  int? get minutesLate => throw _privateConstructorUsedError;
  @JsonKey(name: 'missed_day')
  DateTime get missedDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'missed_pupil_id')
  int get missedPupilId => throw _privateConstructorUsedError;
  @JsonKey(name: 'missed_type')
  String get missedType => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy => throw _privateConstructorUsedError;
  bool? get returned => throw _privateConstructorUsedError;
  @JsonKey(name: 'returned_at')
  String? get returnedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'written_excuse')
  bool? get writtenExcuse => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissedClassCopyWith<MissedClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissedClassCopyWith<$Res> {
  factory $MissedClassCopyWith(
          MissedClass value, $Res Function(MissedClass) then) =
      _$MissedClassCopyWithImpl<$Res, MissedClass>;
  @useResult
  $Res call(
      {String? contacted,
      @JsonKey(name: 'created_by') String createdBy,
      bool? excused,
      @JsonKey(name: 'minutes_late') int? minutesLate,
      @JsonKey(name: 'missed_day') DateTime missedDay,
      @JsonKey(name: 'missed_pupil_id') int missedPupilId,
      @JsonKey(name: 'missed_type') String missedType,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      bool? returned,
      @JsonKey(name: 'returned_at') String? returnedAt,
      @JsonKey(name: 'written_excuse') bool? writtenExcuse});
}

/// @nodoc
class _$MissedClassCopyWithImpl<$Res, $Val extends MissedClass>
    implements $MissedClassCopyWith<$Res> {
  _$MissedClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacted = freezed,
    Object? createdBy = null,
    Object? excused = freezed,
    Object? minutesLate = freezed,
    Object? missedDay = null,
    Object? missedPupilId = null,
    Object? missedType = null,
    Object? modifiedBy = freezed,
    Object? returned = freezed,
    Object? returnedAt = freezed,
    Object? writtenExcuse = freezed,
  }) {
    return _then(_value.copyWith(
      contacted: freezed == contacted
          ? _value.contacted
          : contacted // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      excused: freezed == excused
          ? _value.excused
          : excused // ignore: cast_nullable_to_non_nullable
              as bool?,
      minutesLate: freezed == minutesLate
          ? _value.minutesLate
          : minutesLate // ignore: cast_nullable_to_non_nullable
              as int?,
      missedDay: null == missedDay
          ? _value.missedDay
          : missedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      missedPupilId: null == missedPupilId
          ? _value.missedPupilId
          : missedPupilId // ignore: cast_nullable_to_non_nullable
              as int,
      missedType: null == missedType
          ? _value.missedType
          : missedType // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      returned: freezed == returned
          ? _value.returned
          : returned // ignore: cast_nullable_to_non_nullable
              as bool?,
      returnedAt: freezed == returnedAt
          ? _value.returnedAt
          : returnedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      writtenExcuse: freezed == writtenExcuse
          ? _value.writtenExcuse
          : writtenExcuse // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissedClassImplCopyWith<$Res>
    implements $MissedClassCopyWith<$Res> {
  factory _$$MissedClassImplCopyWith(
          _$MissedClassImpl value, $Res Function(_$MissedClassImpl) then) =
      __$$MissedClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? contacted,
      @JsonKey(name: 'created_by') String createdBy,
      bool? excused,
      @JsonKey(name: 'minutes_late') int? minutesLate,
      @JsonKey(name: 'missed_day') DateTime missedDay,
      @JsonKey(name: 'missed_pupil_id') int missedPupilId,
      @JsonKey(name: 'missed_type') String missedType,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      bool? returned,
      @JsonKey(name: 'returned_at') String? returnedAt,
      @JsonKey(name: 'written_excuse') bool? writtenExcuse});
}

/// @nodoc
class __$$MissedClassImplCopyWithImpl<$Res>
    extends _$MissedClassCopyWithImpl<$Res, _$MissedClassImpl>
    implements _$$MissedClassImplCopyWith<$Res> {
  __$$MissedClassImplCopyWithImpl(
      _$MissedClassImpl _value, $Res Function(_$MissedClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacted = freezed,
    Object? createdBy = null,
    Object? excused = freezed,
    Object? minutesLate = freezed,
    Object? missedDay = null,
    Object? missedPupilId = null,
    Object? missedType = null,
    Object? modifiedBy = freezed,
    Object? returned = freezed,
    Object? returnedAt = freezed,
    Object? writtenExcuse = freezed,
  }) {
    return _then(_$MissedClassImpl(
      contacted: freezed == contacted
          ? _value.contacted
          : contacted // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      excused: freezed == excused
          ? _value.excused
          : excused // ignore: cast_nullable_to_non_nullable
              as bool?,
      minutesLate: freezed == minutesLate
          ? _value.minutesLate
          : minutesLate // ignore: cast_nullable_to_non_nullable
              as int?,
      missedDay: null == missedDay
          ? _value.missedDay
          : missedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      missedPupilId: null == missedPupilId
          ? _value.missedPupilId
          : missedPupilId // ignore: cast_nullable_to_non_nullable
              as int,
      missedType: null == missedType
          ? _value.missedType
          : missedType // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      returned: freezed == returned
          ? _value.returned
          : returned // ignore: cast_nullable_to_non_nullable
              as bool?,
      returnedAt: freezed == returnedAt
          ? _value.returnedAt
          : returnedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      writtenExcuse: freezed == writtenExcuse
          ? _value.writtenExcuse
          : writtenExcuse // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissedClassImpl implements _MissedClass {
  _$MissedClassImpl(
      {this.contacted,
      @JsonKey(name: 'created_by') required this.createdBy,
      this.excused,
      @JsonKey(name: 'minutes_late') this.minutesLate,
      @JsonKey(name: 'missed_day') required this.missedDay,
      @JsonKey(name: 'missed_pupil_id') required this.missedPupilId,
      @JsonKey(name: 'missed_type') required this.missedType,
      @JsonKey(name: 'modified_by') this.modifiedBy,
      this.returned,
      @JsonKey(name: 'returned_at') this.returnedAt,
      @JsonKey(name: 'written_excuse') this.writtenExcuse});

  factory _$MissedClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissedClassImplFromJson(json);

  @override
  final String? contacted;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  final bool? excused;
  @override
  @JsonKey(name: 'minutes_late')
  final int? minutesLate;
  @override
  @JsonKey(name: 'missed_day')
  final DateTime missedDay;
  @override
  @JsonKey(name: 'missed_pupil_id')
  final int missedPupilId;
  @override
  @JsonKey(name: 'missed_type')
  final String missedType;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;
  @override
  final bool? returned;
  @override
  @JsonKey(name: 'returned_at')
  final String? returnedAt;
  @override
  @JsonKey(name: 'written_excuse')
  final bool? writtenExcuse;

  @override
  String toString() {
    return 'MissedClass(contacted: $contacted, createdBy: $createdBy, excused: $excused, minutesLate: $minutesLate, missedDay: $missedDay, missedPupilId: $missedPupilId, missedType: $missedType, modifiedBy: $modifiedBy, returned: $returned, returnedAt: $returnedAt, writtenExcuse: $writtenExcuse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissedClassImpl &&
            (identical(other.contacted, contacted) ||
                other.contacted == contacted) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.excused, excused) || other.excused == excused) &&
            (identical(other.minutesLate, minutesLate) ||
                other.minutesLate == minutesLate) &&
            (identical(other.missedDay, missedDay) ||
                other.missedDay == missedDay) &&
            (identical(other.missedPupilId, missedPupilId) ||
                other.missedPupilId == missedPupilId) &&
            (identical(other.missedType, missedType) ||
                other.missedType == missedType) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.returned, returned) ||
                other.returned == returned) &&
            (identical(other.returnedAt, returnedAt) ||
                other.returnedAt == returnedAt) &&
            (identical(other.writtenExcuse, writtenExcuse) ||
                other.writtenExcuse == writtenExcuse));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      contacted,
      createdBy,
      excused,
      minutesLate,
      missedDay,
      missedPupilId,
      missedType,
      modifiedBy,
      returned,
      returnedAt,
      writtenExcuse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissedClassImplCopyWith<_$MissedClassImpl> get copyWith =>
      __$$MissedClassImplCopyWithImpl<_$MissedClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissedClassImplToJson(
      this,
    );
  }
}

abstract class _MissedClass implements MissedClass {
  factory _MissedClass(
          {final String? contacted,
          @JsonKey(name: 'created_by') required final String createdBy,
          final bool? excused,
          @JsonKey(name: 'minutes_late') final int? minutesLate,
          @JsonKey(name: 'missed_day') required final DateTime missedDay,
          @JsonKey(name: 'missed_pupil_id') required final int missedPupilId,
          @JsonKey(name: 'missed_type') required final String missedType,
          @JsonKey(name: 'modified_by') final String? modifiedBy,
          final bool? returned,
          @JsonKey(name: 'returned_at') final String? returnedAt,
          @JsonKey(name: 'written_excuse') final bool? writtenExcuse}) =
      _$MissedClassImpl;

  factory _MissedClass.fromJson(Map<String, dynamic> json) =
      _$MissedClassImpl.fromJson;

  @override
  String? get contacted;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  bool? get excused;
  @override
  @JsonKey(name: 'minutes_late')
  int? get minutesLate;
  @override
  @JsonKey(name: 'missed_day')
  DateTime get missedDay;
  @override
  @JsonKey(name: 'missed_pupil_id')
  int get missedPupilId;
  @override
  @JsonKey(name: 'missed_type')
  String get missedType;
  @override
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;
  @override
  bool? get returned;
  @override
  @JsonKey(name: 'returned_at')
  String? get returnedAt;
  @override
  @JsonKey(name: 'written_excuse')
  bool? get writtenExcuse;
  @override
  @JsonKey(ignore: true)
  _$$MissedClassImplCopyWith<_$MissedClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
