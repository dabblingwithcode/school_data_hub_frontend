// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PupilList _$PupilListFromJson(Map<String, dynamic> json) {
  return _PupilList.fromJson(json);
}

/// @nodoc
mixin _$PupilList {
  @JsonKey(name: 'origin_list')
  String get originList => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_list_comment')
  String? get pupilListComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_list_entry_by')
  String? get pupilListEntryBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_list_status')
  bool? get pupilListStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilListCopyWith<PupilList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilListCopyWith<$Res> {
  factory $PupilListCopyWith(PupilList value, $Res Function(PupilList) then) =
      _$PupilListCopyWithImpl<$Res, PupilList>;
  @useResult
  $Res call(
      {@JsonKey(name: 'origin_list') String originList,
      @JsonKey(name: 'pupil_list_comment') String? pupilListComment,
      @JsonKey(name: 'pupil_list_entry_by') String? pupilListEntryBy,
      @JsonKey(name: 'pupil_list_status') bool? pupilListStatus});
}

/// @nodoc
class _$PupilListCopyWithImpl<$Res, $Val extends PupilList>
    implements $PupilListCopyWith<$Res> {
  _$PupilListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originList = null,
    Object? pupilListComment = freezed,
    Object? pupilListEntryBy = freezed,
    Object? pupilListStatus = freezed,
  }) {
    return _then(_value.copyWith(
      originList: null == originList
          ? _value.originList
          : originList // ignore: cast_nullable_to_non_nullable
              as String,
      pupilListComment: freezed == pupilListComment
          ? _value.pupilListComment
          : pupilListComment // ignore: cast_nullable_to_non_nullable
              as String?,
      pupilListEntryBy: freezed == pupilListEntryBy
          ? _value.pupilListEntryBy
          : pupilListEntryBy // ignore: cast_nullable_to_non_nullable
              as String?,
      pupilListStatus: freezed == pupilListStatus
          ? _value.pupilListStatus
          : pupilListStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PupilListImplCopyWith<$Res>
    implements $PupilListCopyWith<$Res> {
  factory _$$PupilListImplCopyWith(
          _$PupilListImpl value, $Res Function(_$PupilListImpl) then) =
      __$$PupilListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'origin_list') String originList,
      @JsonKey(name: 'pupil_list_comment') String? pupilListComment,
      @JsonKey(name: 'pupil_list_entry_by') String? pupilListEntryBy,
      @JsonKey(name: 'pupil_list_status') bool? pupilListStatus});
}

/// @nodoc
class __$$PupilListImplCopyWithImpl<$Res>
    extends _$PupilListCopyWithImpl<$Res, _$PupilListImpl>
    implements _$$PupilListImplCopyWith<$Res> {
  __$$PupilListImplCopyWithImpl(
      _$PupilListImpl _value, $Res Function(_$PupilListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originList = null,
    Object? pupilListComment = freezed,
    Object? pupilListEntryBy = freezed,
    Object? pupilListStatus = freezed,
  }) {
    return _then(_$PupilListImpl(
      originList: null == originList
          ? _value.originList
          : originList // ignore: cast_nullable_to_non_nullable
              as String,
      pupilListComment: freezed == pupilListComment
          ? _value.pupilListComment
          : pupilListComment // ignore: cast_nullable_to_non_nullable
              as String?,
      pupilListEntryBy: freezed == pupilListEntryBy
          ? _value.pupilListEntryBy
          : pupilListEntryBy // ignore: cast_nullable_to_non_nullable
              as String?,
      pupilListStatus: freezed == pupilListStatus
          ? _value.pupilListStatus
          : pupilListStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PupilListImpl implements _PupilList {
  _$PupilListImpl(
      {@JsonKey(name: 'origin_list') required this.originList,
      @JsonKey(name: 'pupil_list_comment') this.pupilListComment,
      @JsonKey(name: 'pupil_list_entry_by') this.pupilListEntryBy,
      @JsonKey(name: 'pupil_list_status') this.pupilListStatus});

  factory _$PupilListImpl.fromJson(Map<String, dynamic> json) =>
      _$$PupilListImplFromJson(json);

  @override
  @JsonKey(name: 'origin_list')
  final String originList;
  @override
  @JsonKey(name: 'pupil_list_comment')
  final String? pupilListComment;
  @override
  @JsonKey(name: 'pupil_list_entry_by')
  final String? pupilListEntryBy;
  @override
  @JsonKey(name: 'pupil_list_status')
  final bool? pupilListStatus;

  @override
  String toString() {
    return 'PupilList(originList: $originList, pupilListComment: $pupilListComment, pupilListEntryBy: $pupilListEntryBy, pupilListStatus: $pupilListStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PupilListImpl &&
            (identical(other.originList, originList) ||
                other.originList == originList) &&
            (identical(other.pupilListComment, pupilListComment) ||
                other.pupilListComment == pupilListComment) &&
            (identical(other.pupilListEntryBy, pupilListEntryBy) ||
                other.pupilListEntryBy == pupilListEntryBy) &&
            (identical(other.pupilListStatus, pupilListStatus) ||
                other.pupilListStatus == pupilListStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, originList, pupilListComment,
      pupilListEntryBy, pupilListStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PupilListImplCopyWith<_$PupilListImpl> get copyWith =>
      __$$PupilListImplCopyWithImpl<_$PupilListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PupilListImplToJson(
      this,
    );
  }
}

abstract class _PupilList implements PupilList {
  factory _PupilList(
          {@JsonKey(name: 'origin_list') required final String originList,
          @JsonKey(name: 'pupil_list_comment') final String? pupilListComment,
          @JsonKey(name: 'pupil_list_entry_by') final String? pupilListEntryBy,
          @JsonKey(name: 'pupil_list_status') final bool? pupilListStatus}) =
      _$PupilListImpl;

  factory _PupilList.fromJson(Map<String, dynamic> json) =
      _$PupilListImpl.fromJson;

  @override
  @JsonKey(name: 'origin_list')
  String get originList;
  @override
  @JsonKey(name: 'pupil_list_comment')
  String? get pupilListComment;
  @override
  @JsonKey(name: 'pupil_list_entry_by')
  String? get pupilListEntryBy;
  @override
  @JsonKey(name: 'pupil_list_status')
  bool? get pupilListStatus;
  @override
  @JsonKey(ignore: true)
  _$$PupilListImplCopyWith<_$PupilListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
