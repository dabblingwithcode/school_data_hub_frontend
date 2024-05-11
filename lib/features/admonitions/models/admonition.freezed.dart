// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admonition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Admonition _$AdmonitionFromJson(Map<String, dynamic> json) {
  return _Admonition.fromJson(json);
}

/// @nodoc
mixin _$Admonition {
  @JsonKey(name: 'admonition_id')
  String get admonitionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'admonition_type')
  String get admonitionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'admonition_reason')
  String get admonitionReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'admonishing_user')
  String get admonishingUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'processed')
  bool get processed => throw _privateConstructorUsedError;
  @JsonKey(name: 'processed_by')
  String? get processedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'processed_at')
  DateTime? get processedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String? get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'processed_file_url')
  String? get processedFileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'admonished_day')
  DateTime get admonishedDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'admonished_pupil_id')
  int get admonishedPupilId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdmonitionCopyWith<Admonition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdmonitionCopyWith<$Res> {
  factory $AdmonitionCopyWith(
          Admonition value, $Res Function(Admonition) then) =
      _$AdmonitionCopyWithImpl<$Res, Admonition>;
  @useResult
  $Res call(
      {@JsonKey(name: 'admonition_id') String admonitionId,
      @JsonKey(name: 'admonition_type') String admonitionType,
      @JsonKey(name: 'admonition_reason') String admonitionReason,
      @JsonKey(name: 'admonishing_user') String admonishingUser,
      @JsonKey(name: 'processed') bool processed,
      @JsonKey(name: 'processed_by') String? processedBy,
      @JsonKey(name: 'processed_at') DateTime? processedAt,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'processed_file_url') String? processedFileUrl,
      @JsonKey(name: 'admonished_day') DateTime admonishedDay,
      @JsonKey(name: 'admonished_pupil_id') int admonishedPupilId});
}

/// @nodoc
class _$AdmonitionCopyWithImpl<$Res, $Val extends Admonition>
    implements $AdmonitionCopyWith<$Res> {
  _$AdmonitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? admonitionId = null,
    Object? admonitionType = null,
    Object? admonitionReason = null,
    Object? admonishingUser = null,
    Object? processed = null,
    Object? processedBy = freezed,
    Object? processedAt = freezed,
    Object? fileUrl = freezed,
    Object? processedFileUrl = freezed,
    Object? admonishedDay = null,
    Object? admonishedPupilId = null,
  }) {
    return _then(_value.copyWith(
      admonitionId: null == admonitionId
          ? _value.admonitionId
          : admonitionId // ignore: cast_nullable_to_non_nullable
              as String,
      admonitionType: null == admonitionType
          ? _value.admonitionType
          : admonitionType // ignore: cast_nullable_to_non_nullable
              as String,
      admonitionReason: null == admonitionReason
          ? _value.admonitionReason
          : admonitionReason // ignore: cast_nullable_to_non_nullable
              as String,
      admonishingUser: null == admonishingUser
          ? _value.admonishingUser
          : admonishingUser // ignore: cast_nullable_to_non_nullable
              as String,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      processedFileUrl: freezed == processedFileUrl
          ? _value.processedFileUrl
          : processedFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      admonishedDay: null == admonishedDay
          ? _value.admonishedDay
          : admonishedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      admonishedPupilId: null == admonishedPupilId
          ? _value.admonishedPupilId
          : admonishedPupilId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdmonitionImplCopyWith<$Res>
    implements $AdmonitionCopyWith<$Res> {
  factory _$$AdmonitionImplCopyWith(
          _$AdmonitionImpl value, $Res Function(_$AdmonitionImpl) then) =
      __$$AdmonitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'admonition_id') String admonitionId,
      @JsonKey(name: 'admonition_type') String admonitionType,
      @JsonKey(name: 'admonition_reason') String admonitionReason,
      @JsonKey(name: 'admonishing_user') String admonishingUser,
      @JsonKey(name: 'processed') bool processed,
      @JsonKey(name: 'processed_by') String? processedBy,
      @JsonKey(name: 'processed_at') DateTime? processedAt,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'processed_file_url') String? processedFileUrl,
      @JsonKey(name: 'admonished_day') DateTime admonishedDay,
      @JsonKey(name: 'admonished_pupil_id') int admonishedPupilId});
}

/// @nodoc
class __$$AdmonitionImplCopyWithImpl<$Res>
    extends _$AdmonitionCopyWithImpl<$Res, _$AdmonitionImpl>
    implements _$$AdmonitionImplCopyWith<$Res> {
  __$$AdmonitionImplCopyWithImpl(
      _$AdmonitionImpl _value, $Res Function(_$AdmonitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? admonitionId = null,
    Object? admonitionType = null,
    Object? admonitionReason = null,
    Object? admonishingUser = null,
    Object? processed = null,
    Object? processedBy = freezed,
    Object? processedAt = freezed,
    Object? fileUrl = freezed,
    Object? processedFileUrl = freezed,
    Object? admonishedDay = null,
    Object? admonishedPupilId = null,
  }) {
    return _then(_$AdmonitionImpl(
      admonitionId: null == admonitionId
          ? _value.admonitionId
          : admonitionId // ignore: cast_nullable_to_non_nullable
              as String,
      admonitionType: null == admonitionType
          ? _value.admonitionType
          : admonitionType // ignore: cast_nullable_to_non_nullable
              as String,
      admonitionReason: null == admonitionReason
          ? _value.admonitionReason
          : admonitionReason // ignore: cast_nullable_to_non_nullable
              as String,
      admonishingUser: null == admonishingUser
          ? _value.admonishingUser
          : admonishingUser // ignore: cast_nullable_to_non_nullable
              as String,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      processedFileUrl: freezed == processedFileUrl
          ? _value.processedFileUrl
          : processedFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      admonishedDay: null == admonishedDay
          ? _value.admonishedDay
          : admonishedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      admonishedPupilId: null == admonishedPupilId
          ? _value.admonishedPupilId
          : admonishedPupilId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdmonitionImpl implements _Admonition {
  _$AdmonitionImpl(
      {@JsonKey(name: 'admonition_id') required this.admonitionId,
      @JsonKey(name: 'admonition_type') required this.admonitionType,
      @JsonKey(name: 'admonition_reason') required this.admonitionReason,
      @JsonKey(name: 'admonishing_user') required this.admonishingUser,
      @JsonKey(name: 'processed') required this.processed,
      @JsonKey(name: 'processed_by') this.processedBy,
      @JsonKey(name: 'processed_at') this.processedAt,
      @JsonKey(name: 'file_url') this.fileUrl,
      @JsonKey(name: 'processed_file_url') this.processedFileUrl,
      @JsonKey(name: 'admonished_day') required this.admonishedDay,
      @JsonKey(name: 'admonished_pupil_id') required this.admonishedPupilId});

  factory _$AdmonitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdmonitionImplFromJson(json);

  @override
  @JsonKey(name: 'admonition_id')
  final String admonitionId;
  @override
  @JsonKey(name: 'admonition_type')
  final String admonitionType;
  @override
  @JsonKey(name: 'admonition_reason')
  final String admonitionReason;
  @override
  @JsonKey(name: 'admonishing_user')
  final String admonishingUser;
  @override
  @JsonKey(name: 'processed')
  final bool processed;
  @override
  @JsonKey(name: 'processed_by')
  final String? processedBy;
  @override
  @JsonKey(name: 'processed_at')
  final DateTime? processedAt;
  @override
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @override
  @JsonKey(name: 'processed_file_url')
  final String? processedFileUrl;
  @override
  @JsonKey(name: 'admonished_day')
  final DateTime admonishedDay;
  @override
  @JsonKey(name: 'admonished_pupil_id')
  final int admonishedPupilId;

  @override
  String toString() {
    return 'Admonition(admonitionId: $admonitionId, admonitionType: $admonitionType, admonitionReason: $admonitionReason, admonishingUser: $admonishingUser, processed: $processed, processedBy: $processedBy, processedAt: $processedAt, fileUrl: $fileUrl, processedFileUrl: $processedFileUrl, admonishedDay: $admonishedDay, admonishedPupilId: $admonishedPupilId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdmonitionImpl &&
            (identical(other.admonitionId, admonitionId) ||
                other.admonitionId == admonitionId) &&
            (identical(other.admonitionType, admonitionType) ||
                other.admonitionType == admonitionType) &&
            (identical(other.admonitionReason, admonitionReason) ||
                other.admonitionReason == admonitionReason) &&
            (identical(other.admonishingUser, admonishingUser) ||
                other.admonishingUser == admonishingUser) &&
            (identical(other.processed, processed) ||
                other.processed == processed) &&
            (identical(other.processedBy, processedBy) ||
                other.processedBy == processedBy) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.processedFileUrl, processedFileUrl) ||
                other.processedFileUrl == processedFileUrl) &&
            (identical(other.admonishedDay, admonishedDay) ||
                other.admonishedDay == admonishedDay) &&
            (identical(other.admonishedPupilId, admonishedPupilId) ||
                other.admonishedPupilId == admonishedPupilId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      admonitionId,
      admonitionType,
      admonitionReason,
      admonishingUser,
      processed,
      processedBy,
      processedAt,
      fileUrl,
      processedFileUrl,
      admonishedDay,
      admonishedPupilId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdmonitionImplCopyWith<_$AdmonitionImpl> get copyWith =>
      __$$AdmonitionImplCopyWithImpl<_$AdmonitionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdmonitionImplToJson(
      this,
    );
  }
}

abstract class _Admonition implements Admonition {
  factory _Admonition(
      {@JsonKey(name: 'admonition_id') required final String admonitionId,
      @JsonKey(name: 'admonition_type') required final String admonitionType,
      @JsonKey(name: 'admonition_reason')
      required final String admonitionReason,
      @JsonKey(name: 'admonishing_user') required final String admonishingUser,
      @JsonKey(name: 'processed') required final bool processed,
      @JsonKey(name: 'processed_by') final String? processedBy,
      @JsonKey(name: 'processed_at') final DateTime? processedAt,
      @JsonKey(name: 'file_url') final String? fileUrl,
      @JsonKey(name: 'processed_file_url') final String? processedFileUrl,
      @JsonKey(name: 'admonished_day') required final DateTime admonishedDay,
      @JsonKey(name: 'admonished_pupil_id')
      required final int admonishedPupilId}) = _$AdmonitionImpl;

  factory _Admonition.fromJson(Map<String, dynamic> json) =
      _$AdmonitionImpl.fromJson;

  @override
  @JsonKey(name: 'admonition_id')
  String get admonitionId;
  @override
  @JsonKey(name: 'admonition_type')
  String get admonitionType;
  @override
  @JsonKey(name: 'admonition_reason')
  String get admonitionReason;
  @override
  @JsonKey(name: 'admonishing_user')
  String get admonishingUser;
  @override
  @JsonKey(name: 'processed')
  bool get processed;
  @override
  @JsonKey(name: 'processed_by')
  String? get processedBy;
  @override
  @JsonKey(name: 'processed_at')
  DateTime? get processedAt;
  @override
  @JsonKey(name: 'file_url')
  String? get fileUrl;
  @override
  @JsonKey(name: 'processed_file_url')
  String? get processedFileUrl;
  @override
  @JsonKey(name: 'admonished_day')
  DateTime get admonishedDay;
  @override
  @JsonKey(name: 'admonished_pupil_id')
  int get admonishedPupilId;
  @override
  @JsonKey(ignore: true)
  _$$AdmonitionImplCopyWith<_$AdmonitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
