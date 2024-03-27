// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authorization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) {
  return _Authorization.fromJson(json);
}

/// @nodoc
mixin _$Authorization {
  @JsonKey(name: "authorization_description")
  String get authorizationDescription => throw _privateConstructorUsedError;
  @JsonKey(name: "authorization_id")
  String get authorizationId => throw _privateConstructorUsedError;
  @JsonKey(name: "authorization_name")
  String get authorizationName => throw _privateConstructorUsedError;
  @JsonKey(name: "created_by")
  String? get createdBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthorizationCopyWith<Authorization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorizationCopyWith<$Res> {
  factory $AuthorizationCopyWith(
          Authorization value, $Res Function(Authorization) then) =
      _$AuthorizationCopyWithImpl<$Res, Authorization>;
  @useResult
  $Res call(
      {@JsonKey(name: "authorization_description")
      String authorizationDescription,
      @JsonKey(name: "authorization_id") String authorizationId,
      @JsonKey(name: "authorization_name") String authorizationName,
      @JsonKey(name: "created_by") String? createdBy});
}

/// @nodoc
class _$AuthorizationCopyWithImpl<$Res, $Val extends Authorization>
    implements $AuthorizationCopyWith<$Res> {
  _$AuthorizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorizationDescription = null,
    Object? authorizationId = null,
    Object? authorizationName = null,
    Object? createdBy = freezed,
  }) {
    return _then(_value.copyWith(
      authorizationDescription: null == authorizationDescription
          ? _value.authorizationDescription
          : authorizationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationId: null == authorizationId
          ? _value.authorizationId
          : authorizationId // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationName: null == authorizationName
          ? _value.authorizationName
          : authorizationName // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthorizationImplCopyWith<$Res>
    implements $AuthorizationCopyWith<$Res> {
  factory _$$AuthorizationImplCopyWith(
          _$AuthorizationImpl value, $Res Function(_$AuthorizationImpl) then) =
      __$$AuthorizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "authorization_description")
      String authorizationDescription,
      @JsonKey(name: "authorization_id") String authorizationId,
      @JsonKey(name: "authorization_name") String authorizationName,
      @JsonKey(name: "created_by") String? createdBy});
}

/// @nodoc
class __$$AuthorizationImplCopyWithImpl<$Res>
    extends _$AuthorizationCopyWithImpl<$Res, _$AuthorizationImpl>
    implements _$$AuthorizationImplCopyWith<$Res> {
  __$$AuthorizationImplCopyWithImpl(
      _$AuthorizationImpl _value, $Res Function(_$AuthorizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorizationDescription = null,
    Object? authorizationId = null,
    Object? authorizationName = null,
    Object? createdBy = freezed,
  }) {
    return _then(_$AuthorizationImpl(
      authorizationDescription: null == authorizationDescription
          ? _value.authorizationDescription
          : authorizationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationId: null == authorizationId
          ? _value.authorizationId
          : authorizationId // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationName: null == authorizationName
          ? _value.authorizationName
          : authorizationName // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorizationImpl implements _Authorization {
  const _$AuthorizationImpl(
      {@JsonKey(name: "authorization_description")
      required this.authorizationDescription,
      @JsonKey(name: "authorization_id") required this.authorizationId,
      @JsonKey(name: "authorization_name") required this.authorizationName,
      @JsonKey(name: "created_by") required this.createdBy});

  factory _$AuthorizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorizationImplFromJson(json);

  @override
  @JsonKey(name: "authorization_description")
  final String authorizationDescription;
  @override
  @JsonKey(name: "authorization_id")
  final String authorizationId;
  @override
  @JsonKey(name: "authorization_name")
  final String authorizationName;
  @override
  @JsonKey(name: "created_by")
  final String? createdBy;

  @override
  String toString() {
    return 'Authorization(authorizationDescription: $authorizationDescription, authorizationId: $authorizationId, authorizationName: $authorizationName, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizationImpl &&
            (identical(
                    other.authorizationDescription, authorizationDescription) ||
                other.authorizationDescription == authorizationDescription) &&
            (identical(other.authorizationId, authorizationId) ||
                other.authorizationId == authorizationId) &&
            (identical(other.authorizationName, authorizationName) ||
                other.authorizationName == authorizationName) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, authorizationDescription,
      authorizationId, authorizationName, createdBy);

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

abstract class _Authorization implements Authorization {
  const factory _Authorization(
      {@JsonKey(name: "authorization_description")
      required final String authorizationDescription,
      @JsonKey(name: "authorization_id") required final String authorizationId,
      @JsonKey(name: "authorization_name")
      required final String authorizationName,
      @JsonKey(name: "created_by")
      required final String? createdBy}) = _$AuthorizationImpl;

  factory _Authorization.fromJson(Map<String, dynamic> json) =
      _$AuthorizationImpl.fromJson;

  @override
  @JsonKey(name: "authorization_description")
  String get authorizationDescription;
  @override
  @JsonKey(name: "authorization_id")
  String get authorizationId;
  @override
  @JsonKey(name: "authorization_name")
  String get authorizationName;
  @override
  @JsonKey(name: "created_by")
  String? get createdBy;
  @override
  @JsonKey(ignore: true)
  _$$AuthorizationImplCopyWith<_$AuthorizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
