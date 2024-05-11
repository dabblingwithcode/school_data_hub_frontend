// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matrix_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatrixRoom _$MatrixRoomFromJson(Map<String, dynamic> json) {
  return _MatrixRoom.fromJson(json);
}

/// @nodoc
mixin _$MatrixRoom {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get powerLevelReactions => throw _privateConstructorUsedError;
  int? get eventsDefault => throw _privateConstructorUsedError;
  List<RoomAdmin>? get roomAdmins => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatrixRoomCopyWith<MatrixRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatrixRoomCopyWith<$Res> {
  factory $MatrixRoomCopyWith(
          MatrixRoom value, $Res Function(MatrixRoom) then) =
      _$MatrixRoomCopyWithImpl<$Res, MatrixRoom>;
  @useResult
  $Res call(
      {String id,
      String? name,
      int? powerLevelReactions,
      int? eventsDefault,
      List<RoomAdmin>? roomAdmins});
}

/// @nodoc
class _$MatrixRoomCopyWithImpl<$Res, $Val extends MatrixRoom>
    implements $MatrixRoomCopyWith<$Res> {
  _$MatrixRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? powerLevelReactions = freezed,
    Object? eventsDefault = freezed,
    Object? roomAdmins = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      powerLevelReactions: freezed == powerLevelReactions
          ? _value.powerLevelReactions
          : powerLevelReactions // ignore: cast_nullable_to_non_nullable
              as int?,
      eventsDefault: freezed == eventsDefault
          ? _value.eventsDefault
          : eventsDefault // ignore: cast_nullable_to_non_nullable
              as int?,
      roomAdmins: freezed == roomAdmins
          ? _value.roomAdmins
          : roomAdmins // ignore: cast_nullable_to_non_nullable
              as List<RoomAdmin>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatrixRoomImplCopyWith<$Res>
    implements $MatrixRoomCopyWith<$Res> {
  factory _$$MatrixRoomImplCopyWith(
          _$MatrixRoomImpl value, $Res Function(_$MatrixRoomImpl) then) =
      __$$MatrixRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      int? powerLevelReactions,
      int? eventsDefault,
      List<RoomAdmin>? roomAdmins});
}

/// @nodoc
class __$$MatrixRoomImplCopyWithImpl<$Res>
    extends _$MatrixRoomCopyWithImpl<$Res, _$MatrixRoomImpl>
    implements _$$MatrixRoomImplCopyWith<$Res> {
  __$$MatrixRoomImplCopyWithImpl(
      _$MatrixRoomImpl _value, $Res Function(_$MatrixRoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? powerLevelReactions = freezed,
    Object? eventsDefault = freezed,
    Object? roomAdmins = freezed,
  }) {
    return _then(_$MatrixRoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      powerLevelReactions: freezed == powerLevelReactions
          ? _value.powerLevelReactions
          : powerLevelReactions // ignore: cast_nullable_to_non_nullable
              as int?,
      eventsDefault: freezed == eventsDefault
          ? _value.eventsDefault
          : eventsDefault // ignore: cast_nullable_to_non_nullable
              as int?,
      roomAdmins: freezed == roomAdmins
          ? _value._roomAdmins
          : roomAdmins // ignore: cast_nullable_to_non_nullable
              as List<RoomAdmin>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatrixRoomImpl extends _MatrixRoom {
  _$MatrixRoomImpl(
      {required this.id,
      this.name,
      this.powerLevelReactions,
      this.eventsDefault,
      final List<RoomAdmin>? roomAdmins})
      : _roomAdmins = roomAdmins,
        super._();

  factory _$MatrixRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatrixRoomImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final int? powerLevelReactions;
  @override
  final int? eventsDefault;
  final List<RoomAdmin>? _roomAdmins;
  @override
  List<RoomAdmin>? get roomAdmins {
    final value = _roomAdmins;
    if (value == null) return null;
    if (_roomAdmins is EqualUnmodifiableListView) return _roomAdmins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MatrixRoom(id: $id, name: $name, powerLevelReactions: $powerLevelReactions, eventsDefault: $eventsDefault, roomAdmins: $roomAdmins)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatrixRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.powerLevelReactions, powerLevelReactions) ||
                other.powerLevelReactions == powerLevelReactions) &&
            (identical(other.eventsDefault, eventsDefault) ||
                other.eventsDefault == eventsDefault) &&
            const DeepCollectionEquality()
                .equals(other._roomAdmins, _roomAdmins));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, powerLevelReactions,
      eventsDefault, const DeepCollectionEquality().hash(_roomAdmins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatrixRoomImplCopyWith<_$MatrixRoomImpl> get copyWith =>
      __$$MatrixRoomImplCopyWithImpl<_$MatrixRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatrixRoomImplToJson(
      this,
    );
  }
}

abstract class _MatrixRoom extends MatrixRoom {
  factory _MatrixRoom(
      {required final String id,
      final String? name,
      final int? powerLevelReactions,
      final int? eventsDefault,
      final List<RoomAdmin>? roomAdmins}) = _$MatrixRoomImpl;
  _MatrixRoom._() : super._();

  factory _MatrixRoom.fromJson(Map<String, dynamic> json) =
      _$MatrixRoomImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  int? get powerLevelReactions;
  @override
  int? get eventsDefault;
  @override
  List<RoomAdmin>? get roomAdmins;
  @override
  @JsonKey(ignore: true)
  _$$MatrixRoomImplCopyWith<_$MatrixRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomAdmin _$RoomAdminFromJson(Map<String, dynamic> json) {
  return _RoomAdmin.fromJson(json);
}

/// @nodoc
mixin _$RoomAdmin {
  String get id => throw _privateConstructorUsedError;
  int get powerLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomAdminCopyWith<RoomAdmin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomAdminCopyWith<$Res> {
  factory $RoomAdminCopyWith(RoomAdmin value, $Res Function(RoomAdmin) then) =
      _$RoomAdminCopyWithImpl<$Res, RoomAdmin>;
  @useResult
  $Res call({String id, int powerLevel});
}

/// @nodoc
class _$RoomAdminCopyWithImpl<$Res, $Val extends RoomAdmin>
    implements $RoomAdminCopyWith<$Res> {
  _$RoomAdminCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? powerLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      powerLevel: null == powerLevel
          ? _value.powerLevel
          : powerLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomAdminImplCopyWith<$Res>
    implements $RoomAdminCopyWith<$Res> {
  factory _$$RoomAdminImplCopyWith(
          _$RoomAdminImpl value, $Res Function(_$RoomAdminImpl) then) =
      __$$RoomAdminImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int powerLevel});
}

/// @nodoc
class __$$RoomAdminImplCopyWithImpl<$Res>
    extends _$RoomAdminCopyWithImpl<$Res, _$RoomAdminImpl>
    implements _$$RoomAdminImplCopyWith<$Res> {
  __$$RoomAdminImplCopyWithImpl(
      _$RoomAdminImpl _value, $Res Function(_$RoomAdminImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? powerLevel = null,
  }) {
    return _then(_$RoomAdminImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      powerLevel: null == powerLevel
          ? _value.powerLevel
          : powerLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomAdminImpl implements _RoomAdmin {
  _$RoomAdminImpl({required this.id, required this.powerLevel});

  factory _$RoomAdminImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomAdminImplFromJson(json);

  @override
  final String id;
  @override
  final int powerLevel;

  @override
  String toString() {
    return 'RoomAdmin(id: $id, powerLevel: $powerLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomAdminImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.powerLevel, powerLevel) ||
                other.powerLevel == powerLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, powerLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomAdminImplCopyWith<_$RoomAdminImpl> get copyWith =>
      __$$RoomAdminImplCopyWithImpl<_$RoomAdminImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomAdminImplToJson(
      this,
    );
  }
}

abstract class _RoomAdmin implements RoomAdmin {
  factory _RoomAdmin(
      {required final String id,
      required final int powerLevel}) = _$RoomAdminImpl;

  factory _RoomAdmin.fromJson(Map<String, dynamic> json) =
      _$RoomAdminImpl.fromJson;

  @override
  String get id;
  @override
  int get powerLevel;
  @override
  @JsonKey(ignore: true)
  _$$RoomAdminImplCopyWith<_$RoomAdminImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
