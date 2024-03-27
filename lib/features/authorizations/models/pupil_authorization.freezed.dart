// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil_authorization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PupilAuthorization _$PupilAuthorizationFromJson(Map<String, dynamic> json) {
  return _Authorization.fromJson(json);
}

/// @nodoc
mixin _$PupilAuthorization {
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String? get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'origin_authorization')
  String get originAuthorization => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_id')
  int get pupilId => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilAuthorizationCopyWith<PupilAuthorization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilAuthorizationCopyWith<$Res> {
  factory $PupilAuthorizationCopyWith(
          PupilAuthorization value, $Res Function(PupilAuthorization) then) =
      _$PupilAuthorizationCopyWithImpl<$Res, PupilAuthorization>;
  @useResult
  $Res call(
      {String? comment,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'origin_authorization') String originAuthorization,
      @JsonKey(name: 'pupil_id') int pupilId,
      bool? status});
}

/// @nodoc
class _$PupilAuthorizationCopyWithImpl<$Res, $Val extends PupilAuthorization>
    implements $PupilAuthorizationCopyWith<$Res> {
  _$PupilAuthorizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
    Object? createdBy = freezed,
    Object? fileUrl = freezed,
    Object? originAuthorization = null,
    Object? pupilId = null,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      originAuthorization: null == originAuthorization
          ? _value.originAuthorization
          : originAuthorization // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthorizationImplCopyWith<$Res>
    implements $PupilAuthorizationCopyWith<$Res> {
  factory _$$AuthorizationImplCopyWith(
          _$AuthorizationImpl value, $Res Function(_$AuthorizationImpl) then) =
      __$$AuthorizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? comment,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'origin_authorization') String originAuthorization,
      @JsonKey(name: 'pupil_id') int pupilId,
      bool? status});
}

/// @nodoc
class __$$AuthorizationImplCopyWithImpl<$Res>
    extends _$PupilAuthorizationCopyWithImpl<$Res, _$AuthorizationImpl>
    implements _$$AuthorizationImplCopyWith<$Res> {
  __$$AuthorizationImplCopyWithImpl(
      _$AuthorizationImpl _value, $Res Function(_$AuthorizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
    Object? createdBy = freezed,
    Object? fileUrl = freezed,
    Object? originAuthorization = null,
    Object? pupilId = null,
    Object? status = freezed,
  }) {
    return _then(_$AuthorizationImpl(
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      originAuthorization: null == originAuthorization
          ? _value.originAuthorization
          : originAuthorization // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorizationImpl implements _Authorization {
  _$AuthorizationImpl(
      {this.comment,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'file_url') this.fileUrl,
      @JsonKey(name: 'origin_authorization') required this.originAuthorization,
      @JsonKey(name: 'pupil_id') required this.pupilId,
      this.status});

  factory _$AuthorizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorizationImplFromJson(json);

  @override
  final String? comment;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @override
  @JsonKey(name: 'origin_authorization')
  final String originAuthorization;
  @override
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @override
  final bool? status;

  @override
  String toString() {
    return 'PupilAuthorization(comment: $comment, createdBy: $createdBy, fileUrl: $fileUrl, originAuthorization: $originAuthorization, pupilId: $pupilId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizationImpl &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.originAuthorization, originAuthorization) ||
                other.originAuthorization == originAuthorization) &&
            (identical(other.pupilId, pupilId) || other.pupilId == pupilId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, comment, createdBy, fileUrl,
      originAuthorization, pupilId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorizationImplCopyWith<_$AuthorizationImpl> get copyWith =>
      __$$AuthorizationImplCopyWithImpl<_$AuthorizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorizationImplToJson(
      this,
    );
  }
}

abstract class _Authorization implements PupilAuthorization {
  factory _Authorization(
      {final String? comment,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'file_url') final String? fileUrl,
      @JsonKey(name: 'origin_authorization')
      required final String originAuthorization,
      @JsonKey(name: 'pupil_id') required final int pupilId,
      final bool? status}) = _$AuthorizationImpl;

  factory _Authorization.fromJson(Map<String, dynamic> json) =
      _$AuthorizationImpl.fromJson;

  @override
  String? get comment;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'file_url')
  String? get fileUrl;
  @override
  @JsonKey(name: 'origin_authorization')
  String get originAuthorization;
  @override
  @JsonKey(name: 'pupil_id')
  int get pupilId;
  @override
  bool? get status;
  @override
  @JsonKey(ignore: true)
  _$$AuthorizationImplCopyWith<_$AuthorizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
