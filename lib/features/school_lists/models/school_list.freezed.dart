// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SchoolList _$SchoolListFromJson(Map<String, dynamic> json) {
  return _SchoolList.fromJson(json);
}

/// @nodoc
mixin _$SchoolList {
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_description')
  String get listDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_id')
  String get listId => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_name')
  String get listName => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchoolListCopyWith<SchoolList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolListCopyWith<$Res> {
  factory $SchoolListCopyWith(
          SchoolList value, $Res Function(SchoolList) then) =
      _$SchoolListCopyWithImpl<$Res, SchoolList>;
  @useResult
  $Res call(
      {@JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'list_description') String listDescription,
      @JsonKey(name: 'list_id') String listId,
      @JsonKey(name: 'list_name') String listName,
      String visibility});
}

/// @nodoc
class _$SchoolListCopyWithImpl<$Res, $Val extends SchoolList>
    implements $SchoolListCopyWith<$Res> {
  _$SchoolListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdBy = null,
    Object? listDescription = null,
    Object? listId = null,
    Object? listName = null,
    Object? visibility = null,
  }) {
    return _then(_value.copyWith(
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      listDescription: null == listDescription
          ? _value.listDescription
          : listDescription // ignore: cast_nullable_to_non_nullable
              as String,
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as String,
      listName: null == listName
          ? _value.listName
          : listName // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SchoolListImplCopyWith<$Res>
    implements $SchoolListCopyWith<$Res> {
  factory _$$SchoolListImplCopyWith(
          _$SchoolListImpl value, $Res Function(_$SchoolListImpl) then) =
      __$$SchoolListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'list_description') String listDescription,
      @JsonKey(name: 'list_id') String listId,
      @JsonKey(name: 'list_name') String listName,
      String visibility});
}

/// @nodoc
class __$$SchoolListImplCopyWithImpl<$Res>
    extends _$SchoolListCopyWithImpl<$Res, _$SchoolListImpl>
    implements _$$SchoolListImplCopyWith<$Res> {
  __$$SchoolListImplCopyWithImpl(
      _$SchoolListImpl _value, $Res Function(_$SchoolListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdBy = null,
    Object? listDescription = null,
    Object? listId = null,
    Object? listName = null,
    Object? visibility = null,
  }) {
    return _then(_$SchoolListImpl(
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      listDescription: null == listDescription
          ? _value.listDescription
          : listDescription // ignore: cast_nullable_to_non_nullable
              as String,
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as String,
      listName: null == listName
          ? _value.listName
          : listName // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchoolListImpl implements _SchoolList {
  _$SchoolListImpl(
      {@JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'list_description') required this.listDescription,
      @JsonKey(name: 'list_id') required this.listId,
      @JsonKey(name: 'list_name') required this.listName,
      required this.visibility});

  factory _$SchoolListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchoolListImplFromJson(json);

  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'list_description')
  final String listDescription;
  @override
  @JsonKey(name: 'list_id')
  final String listId;
  @override
  @JsonKey(name: 'list_name')
  final String listName;
  @override
  final String visibility;

  @override
  String toString() {
    return 'SchoolList(createdBy: $createdBy, listDescription: $listDescription, listId: $listId, listName: $listName, visibility: $visibility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchoolListImpl &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.listDescription, listDescription) ||
                other.listDescription == listDescription) &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.listName, listName) ||
                other.listName == listName) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdBy, listDescription, listId, listName, visibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchoolListImplCopyWith<_$SchoolListImpl> get copyWith =>
      __$$SchoolListImplCopyWithImpl<_$SchoolListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchoolListImplToJson(
      this,
    );
  }
}

abstract class _SchoolList implements SchoolList {
  factory _SchoolList(
      {@JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'list_description') required final String listDescription,
      @JsonKey(name: 'list_id') required final String listId,
      @JsonKey(name: 'list_name') required final String listName,
      required final String visibility}) = _$SchoolListImpl;

  factory _SchoolList.fromJson(Map<String, dynamic> json) =
      _$SchoolListImpl.fromJson;

  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'list_description')
  String get listDescription;
  @override
  @JsonKey(name: 'list_id')
  String get listId;
  @override
  @JsonKey(name: 'list_name')
  String get listName;
  @override
  String get visibility;
  @override
  @JsonKey(ignore: true)
  _$$SchoolListImplCopyWith<_$SchoolListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
