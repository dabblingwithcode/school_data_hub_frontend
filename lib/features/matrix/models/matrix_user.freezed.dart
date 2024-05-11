// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matrix_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatrixUser _$MatrixUserFromJson(Map<String, dynamic> json) {
  return _MatrixUser.fromJson(json);
}

/// @nodoc
mixin _$MatrixUser {
  String? get id => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  String? get authType => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUri => throw _privateConstructorUsedError;
  @JsonKey(name: 'joinedRoomIds')
  List<MatrixRoom>? get matrixRooms => throw _privateConstructorUsedError;
  dynamic get forbidRoomCreation => throw _privateConstructorUsedError;
  dynamic get forbidEncryptedRoomCreation => throw _privateConstructorUsedError;
  dynamic get forbidUnencryptedRoomCreation =>
      throw _privateConstructorUsedError;
  String? get authCredential => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatrixUserCopyWith<MatrixUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatrixUserCopyWith<$Res> {
  factory $MatrixUserCopyWith(
          MatrixUser value, $Res Function(MatrixUser) then) =
      _$MatrixUserCopyWithImpl<$Res, MatrixUser>;
  @useResult
  $Res call(
      {String? id,
      bool? active,
      String? authType,
      String? displayName,
      String? avatarUri,
      @JsonKey(name: 'joinedRoomIds') List<MatrixRoom>? matrixRooms,
      dynamic forbidRoomCreation,
      dynamic forbidEncryptedRoomCreation,
      dynamic forbidUnencryptedRoomCreation,
      String? authCredential});
}

/// @nodoc
class _$MatrixUserCopyWithImpl<$Res, $Val extends MatrixUser>
    implements $MatrixUserCopyWith<$Res> {
  _$MatrixUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? active = freezed,
    Object? authType = freezed,
    Object? displayName = freezed,
    Object? avatarUri = freezed,
    Object? matrixRooms = freezed,
    Object? forbidRoomCreation = freezed,
    Object? forbidEncryptedRoomCreation = freezed,
    Object? forbidUnencryptedRoomCreation = freezed,
    Object? authCredential = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      authType: freezed == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUri: freezed == avatarUri
          ? _value.avatarUri
          : avatarUri // ignore: cast_nullable_to_non_nullable
              as String?,
      matrixRooms: freezed == matrixRooms
          ? _value.matrixRooms
          : matrixRooms // ignore: cast_nullable_to_non_nullable
              as List<MatrixRoom>?,
      forbidRoomCreation: freezed == forbidRoomCreation
          ? _value.forbidRoomCreation
          : forbidRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      forbidEncryptedRoomCreation: freezed == forbidEncryptedRoomCreation
          ? _value.forbidEncryptedRoomCreation
          : forbidEncryptedRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      forbidUnencryptedRoomCreation: freezed == forbidUnencryptedRoomCreation
          ? _value.forbidUnencryptedRoomCreation
          : forbidUnencryptedRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      authCredential: freezed == authCredential
          ? _value.authCredential
          : authCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatrixUserImplCopyWith<$Res>
    implements $MatrixUserCopyWith<$Res> {
  factory _$$MatrixUserImplCopyWith(
          _$MatrixUserImpl value, $Res Function(_$MatrixUserImpl) then) =
      __$$MatrixUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      bool? active,
      String? authType,
      String? displayName,
      String? avatarUri,
      @JsonKey(name: 'joinedRoomIds') List<MatrixRoom>? matrixRooms,
      dynamic forbidRoomCreation,
      dynamic forbidEncryptedRoomCreation,
      dynamic forbidUnencryptedRoomCreation,
      String? authCredential});
}

/// @nodoc
class __$$MatrixUserImplCopyWithImpl<$Res>
    extends _$MatrixUserCopyWithImpl<$Res, _$MatrixUserImpl>
    implements _$$MatrixUserImplCopyWith<$Res> {
  __$$MatrixUserImplCopyWithImpl(
      _$MatrixUserImpl _value, $Res Function(_$MatrixUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? active = freezed,
    Object? authType = freezed,
    Object? displayName = freezed,
    Object? avatarUri = freezed,
    Object? matrixRooms = freezed,
    Object? forbidRoomCreation = freezed,
    Object? forbidEncryptedRoomCreation = freezed,
    Object? forbidUnencryptedRoomCreation = freezed,
    Object? authCredential = freezed,
  }) {
    return _then(_$MatrixUserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      authType: freezed == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUri: freezed == avatarUri
          ? _value.avatarUri
          : avatarUri // ignore: cast_nullable_to_non_nullable
              as String?,
      matrixRooms: freezed == matrixRooms
          ? _value._matrixRooms
          : matrixRooms // ignore: cast_nullable_to_non_nullable
              as List<MatrixRoom>?,
      forbidRoomCreation: freezed == forbidRoomCreation
          ? _value.forbidRoomCreation
          : forbidRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      forbidEncryptedRoomCreation: freezed == forbidEncryptedRoomCreation
          ? _value.forbidEncryptedRoomCreation
          : forbidEncryptedRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      forbidUnencryptedRoomCreation: freezed == forbidUnencryptedRoomCreation
          ? _value.forbidUnencryptedRoomCreation
          : forbidUnencryptedRoomCreation // ignore: cast_nullable_to_non_nullable
              as dynamic,
      authCredential: freezed == authCredential
          ? _value.authCredential
          : authCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatrixUserImpl implements _MatrixUser {
  _$MatrixUserImpl(
      {this.id,
      this.active,
      this.authType,
      this.displayName,
      this.avatarUri,
      @JsonKey(name: 'joinedRoomIds') final List<MatrixRoom>? matrixRooms,
      this.forbidRoomCreation,
      this.forbidEncryptedRoomCreation,
      this.forbidUnencryptedRoomCreation,
      this.authCredential})
      : _matrixRooms = matrixRooms;

  factory _$MatrixUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatrixUserImplFromJson(json);

  @override
  final String? id;
  @override
  final bool? active;
  @override
  final String? authType;
  @override
  final String? displayName;
  @override
  final String? avatarUri;
  final List<MatrixRoom>? _matrixRooms;
  @override
  @JsonKey(name: 'joinedRoomIds')
  List<MatrixRoom>? get matrixRooms {
    final value = _matrixRooms;
    if (value == null) return null;
    if (_matrixRooms is EqualUnmodifiableListView) return _matrixRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic forbidRoomCreation;
  @override
  final dynamic forbidEncryptedRoomCreation;
  @override
  final dynamic forbidUnencryptedRoomCreation;
  @override
  final String? authCredential;

  @override
  String toString() {
    return 'MatrixUser(id: $id, active: $active, authType: $authType, displayName: $displayName, avatarUri: $avatarUri, matrixRooms: $matrixRooms, forbidRoomCreation: $forbidRoomCreation, forbidEncryptedRoomCreation: $forbidEncryptedRoomCreation, forbidUnencryptedRoomCreation: $forbidUnencryptedRoomCreation, authCredential: $authCredential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatrixUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.authType, authType) ||
                other.authType == authType) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUri, avatarUri) ||
                other.avatarUri == avatarUri) &&
            const DeepCollectionEquality()
                .equals(other._matrixRooms, _matrixRooms) &&
            const DeepCollectionEquality()
                .equals(other.forbidRoomCreation, forbidRoomCreation) &&
            const DeepCollectionEquality().equals(
                other.forbidEncryptedRoomCreation,
                forbidEncryptedRoomCreation) &&
            const DeepCollectionEquality().equals(
                other.forbidUnencryptedRoomCreation,
                forbidUnencryptedRoomCreation) &&
            (identical(other.authCredential, authCredential) ||
                other.authCredential == authCredential));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      active,
      authType,
      displayName,
      avatarUri,
      const DeepCollectionEquality().hash(_matrixRooms),
      const DeepCollectionEquality().hash(forbidRoomCreation),
      const DeepCollectionEquality().hash(forbidEncryptedRoomCreation),
      const DeepCollectionEquality().hash(forbidUnencryptedRoomCreation),
      authCredential);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatrixUserImplCopyWith<_$MatrixUserImpl> get copyWith =>
      __$$MatrixUserImplCopyWithImpl<_$MatrixUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatrixUserImplToJson(
      this,
    );
  }
}

abstract class _MatrixUser implements MatrixUser {
  factory _MatrixUser(
      {final String? id,
      final bool? active,
      final String? authType,
      final String? displayName,
      final String? avatarUri,
      @JsonKey(name: 'joinedRoomIds') final List<MatrixRoom>? matrixRooms,
      final dynamic forbidRoomCreation,
      final dynamic forbidEncryptedRoomCreation,
      final dynamic forbidUnencryptedRoomCreation,
      final String? authCredential}) = _$MatrixUserImpl;

  factory _MatrixUser.fromJson(Map<String, dynamic> json) =
      _$MatrixUserImpl.fromJson;

  @override
  String? get id;
  @override
  bool? get active;
  @override
  String? get authType;
  @override
  String? get displayName;
  @override
  String? get avatarUri;
  @override
  @JsonKey(name: 'joinedRoomIds')
  List<MatrixRoom>? get matrixRooms;
  @override
  dynamic get forbidRoomCreation;
  @override
  dynamic get forbidEncryptedRoomCreation;
  @override
  dynamic get forbidUnencryptedRoomCreation;
  @override
  String? get authCredential;
  @override
  @JsonKey(ignore: true)
  _$$MatrixUserImplCopyWith<_$MatrixUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
