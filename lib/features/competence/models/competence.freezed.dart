// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Competence _$CompetenceFromJson(Map<String, dynamic> json) {
  return _Competence.fromJson(json);
}

/// @nodoc
mixin _$Competence {
  @JsonKey(name: 'competence_id')
  int get competenceId => throw _privateConstructorUsedError;
  @JsonKey(name: "competence_level")
  String? get competenceLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'competence_name')
  String get competenceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_competence')
  int? get parentCompetence => throw _privateConstructorUsedError;
  @JsonKey(name: 'indicators')
  String? get indicators => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompetenceCopyWith<Competence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetenceCopyWith<$Res> {
  factory $CompetenceCopyWith(
          Competence value, $Res Function(Competence) then) =
      _$CompetenceCopyWithImpl<$Res, Competence>;
  @useResult
  $Res call(
      {@JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: "competence_level") String? competenceLevel,
      @JsonKey(name: 'competence_name') String competenceName,
      @JsonKey(name: 'parent_competence') int? parentCompetence,
      @JsonKey(name: 'indicators') String? indicators});
}

/// @nodoc
class _$CompetenceCopyWithImpl<$Res, $Val extends Competence>
    implements $CompetenceCopyWith<$Res> {
  _$CompetenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competenceId = null,
    Object? competenceLevel = freezed,
    Object? competenceName = null,
    Object? parentCompetence = freezed,
    Object? indicators = freezed,
  }) {
    return _then(_value.copyWith(
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceLevel: freezed == competenceLevel
          ? _value.competenceLevel
          : competenceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceName: null == competenceName
          ? _value.competenceName
          : competenceName // ignore: cast_nullable_to_non_nullable
              as String,
      parentCompetence: freezed == parentCompetence
          ? _value.parentCompetence
          : parentCompetence // ignore: cast_nullable_to_non_nullable
              as int?,
      indicators: freezed == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetenceImplCopyWith<$Res>
    implements $CompetenceCopyWith<$Res> {
  factory _$$CompetenceImplCopyWith(
          _$CompetenceImpl value, $Res Function(_$CompetenceImpl) then) =
      __$$CompetenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: "competence_level") String? competenceLevel,
      @JsonKey(name: 'competence_name') String competenceName,
      @JsonKey(name: 'parent_competence') int? parentCompetence,
      @JsonKey(name: 'indicators') String? indicators});
}

/// @nodoc
class __$$CompetenceImplCopyWithImpl<$Res>
    extends _$CompetenceCopyWithImpl<$Res, _$CompetenceImpl>
    implements _$$CompetenceImplCopyWith<$Res> {
  __$$CompetenceImplCopyWithImpl(
      _$CompetenceImpl _value, $Res Function(_$CompetenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competenceId = null,
    Object? competenceLevel = freezed,
    Object? competenceName = null,
    Object? parentCompetence = freezed,
    Object? indicators = freezed,
  }) {
    return _then(_$CompetenceImpl(
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceLevel: freezed == competenceLevel
          ? _value.competenceLevel
          : competenceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceName: null == competenceName
          ? _value.competenceName
          : competenceName // ignore: cast_nullable_to_non_nullable
              as String,
      parentCompetence: freezed == parentCompetence
          ? _value.parentCompetence
          : parentCompetence // ignore: cast_nullable_to_non_nullable
              as int?,
      indicators: freezed == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetenceImpl implements _Competence {
  _$CompetenceImpl(
      {@JsonKey(name: 'competence_id') required this.competenceId,
      @JsonKey(name: "competence_level") this.competenceLevel,
      @JsonKey(name: 'competence_name') required this.competenceName,
      @JsonKey(name: 'parent_competence') this.parentCompetence,
      @JsonKey(name: 'indicators') this.indicators});

  factory _$CompetenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetenceImplFromJson(json);

  @override
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @override
  @JsonKey(name: "competence_level")
  final String? competenceLevel;
  @override
  @JsonKey(name: 'competence_name')
  final String competenceName;
  @override
  @JsonKey(name: 'parent_competence')
  final int? parentCompetence;
  @override
  @JsonKey(name: 'indicators')
  final String? indicators;

  @override
  String toString() {
    return 'Competence(competenceId: $competenceId, competenceLevel: $competenceLevel, competenceName: $competenceName, parentCompetence: $parentCompetence, indicators: $indicators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetenceImpl &&
            (identical(other.competenceId, competenceId) ||
                other.competenceId == competenceId) &&
            (identical(other.competenceLevel, competenceLevel) ||
                other.competenceLevel == competenceLevel) &&
            (identical(other.competenceName, competenceName) ||
                other.competenceName == competenceName) &&
            (identical(other.parentCompetence, parentCompetence) ||
                other.parentCompetence == parentCompetence) &&
            (identical(other.indicators, indicators) ||
                other.indicators == indicators));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, competenceId, competenceLevel,
      competenceName, parentCompetence, indicators);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetenceImplCopyWith<_$CompetenceImpl> get copyWith =>
      __$$CompetenceImplCopyWithImpl<_$CompetenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetenceImplToJson(
      this,
    );
  }
}

abstract class _Competence implements Competence {
  factory _Competence(
      {@JsonKey(name: 'competence_id') required final int competenceId,
      @JsonKey(name: "competence_level") final String? competenceLevel,
      @JsonKey(name: 'competence_name') required final String competenceName,
      @JsonKey(name: 'parent_competence') final int? parentCompetence,
      @JsonKey(name: 'indicators')
      final String? indicators}) = _$CompetenceImpl;

  factory _Competence.fromJson(Map<String, dynamic> json) =
      _$CompetenceImpl.fromJson;

  @override
  @JsonKey(name: 'competence_id')
  int get competenceId;
  @override
  @JsonKey(name: "competence_level")
  String? get competenceLevel;
  @override
  @JsonKey(name: 'competence_name')
  String get competenceName;
  @override
  @JsonKey(name: 'parent_competence')
  int? get parentCompetence;
  @override
  @JsonKey(name: 'indicators')
  String? get indicators;
  @override
  @JsonKey(ignore: true)
  _$$CompetenceImplCopyWith<_$CompetenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
