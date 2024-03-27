// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competence_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompetenceGoal _$CompetenceGoalFromJson(Map<String, dynamic> json) {
  return _CompetenceGoal.fromJson(json);
}

/// @nodoc
mixin _$CompetenceGoal {
  @JsonKey(name: 'competence_id')
  int get competenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'competence_goal_id')
  String get competenceGoalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_id')
  int get pupilId => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'strategies')
  String get strategies => throw _privateConstructorUsedError;
  int? get achieved => throw _privateConstructorUsedError;
  @JsonKey(name: 'achieved_at')
  DateTime? get achievedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompetenceGoalCopyWith<CompetenceGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetenceGoalCopyWith<$Res> {
  factory $CompetenceGoalCopyWith(
          CompetenceGoal value, $Res Function(CompetenceGoal) then) =
      _$CompetenceGoalCopyWithImpl<$Res, CompetenceGoal>;
  @useResult
  $Res call(
      {@JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: 'competence_goal_id') String competenceGoalId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'strategies') String strategies,
      int? achieved,
      @JsonKey(name: 'achieved_at') DateTime? achievedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy});
}

/// @nodoc
class _$CompetenceGoalCopyWithImpl<$Res, $Val extends CompetenceGoal>
    implements $CompetenceGoalCopyWith<$Res> {
  _$CompetenceGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competenceId = null,
    Object? competenceGoalId = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? pupilId = null,
    Object? description = null,
    Object? strategies = null,
    Object? achieved = freezed,
    Object? achievedAt = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceGoalId: null == competenceGoalId
          ? _value.competenceGoalId
          : competenceGoalId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      strategies: null == strategies
          ? _value.strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: freezed == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int?,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetenceGoalImplCopyWith<$Res>
    implements $CompetenceGoalCopyWith<$Res> {
  factory _$$CompetenceGoalImplCopyWith(_$CompetenceGoalImpl value,
          $Res Function(_$CompetenceGoalImpl) then) =
      __$$CompetenceGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: 'competence_goal_id') String competenceGoalId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'strategies') String strategies,
      int? achieved,
      @JsonKey(name: 'achieved_at') DateTime? achievedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy});
}

/// @nodoc
class __$$CompetenceGoalImplCopyWithImpl<$Res>
    extends _$CompetenceGoalCopyWithImpl<$Res, _$CompetenceGoalImpl>
    implements _$$CompetenceGoalImplCopyWith<$Res> {
  __$$CompetenceGoalImplCopyWithImpl(
      _$CompetenceGoalImpl _value, $Res Function(_$CompetenceGoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competenceId = null,
    Object? competenceGoalId = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? pupilId = null,
    Object? description = null,
    Object? strategies = null,
    Object? achieved = freezed,
    Object? achievedAt = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_$CompetenceGoalImpl(
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceGoalId: null == competenceGoalId
          ? _value.competenceGoalId
          : competenceGoalId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      strategies: null == strategies
          ? _value.strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: freezed == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int?,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetenceGoalImpl implements _CompetenceGoal {
  _$CompetenceGoalImpl(
      {@JsonKey(name: 'competence_id') required this.competenceId,
      @JsonKey(name: 'competence_goal_id') required this.competenceGoalId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'pupil_id') required this.pupilId,
      @JsonKey(name: 'description') required this.description,
      @JsonKey(name: 'strategies') required this.strategies,
      this.achieved,
      @JsonKey(name: 'achieved_at') this.achievedAt,
      @JsonKey(name: 'modified_by') this.modifiedBy});

  factory _$CompetenceGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetenceGoalImplFromJson(json);

  @override
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @override
  @JsonKey(name: 'competence_goal_id')
  final String competenceGoalId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'strategies')
  final String strategies;
  @override
  final int? achieved;
  @override
  @JsonKey(name: 'achieved_at')
  final DateTime? achievedAt;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;

  @override
  String toString() {
    return 'CompetenceGoal(competenceId: $competenceId, competenceGoalId: $competenceGoalId, createdAt: $createdAt, createdBy: $createdBy, pupilId: $pupilId, description: $description, strategies: $strategies, achieved: $achieved, achievedAt: $achievedAt, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetenceGoalImpl &&
            (identical(other.competenceId, competenceId) ||
                other.competenceId == competenceId) &&
            (identical(other.competenceGoalId, competenceGoalId) ||
                other.competenceGoalId == competenceGoalId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.pupilId, pupilId) || other.pupilId == pupilId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.strategies, strategies) ||
                other.strategies == strategies) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.achievedAt, achievedAt) ||
                other.achievedAt == achievedAt) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      competenceId,
      competenceGoalId,
      createdAt,
      createdBy,
      pupilId,
      description,
      strategies,
      achieved,
      achievedAt,
      modifiedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetenceGoalImplCopyWith<_$CompetenceGoalImpl> get copyWith =>
      __$$CompetenceGoalImplCopyWithImpl<_$CompetenceGoalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetenceGoalImplToJson(
      this,
    );
  }
}

abstract class _CompetenceGoal implements CompetenceGoal {
  factory _CompetenceGoal(
          {@JsonKey(name: 'competence_id') required final int competenceId,
          @JsonKey(name: 'competence_goal_id')
          required final String competenceGoalId,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'created_by') required final String createdBy,
          @JsonKey(name: 'pupil_id') required final int pupilId,
          @JsonKey(name: 'description') required final String description,
          @JsonKey(name: 'strategies') required final String strategies,
          final int? achieved,
          @JsonKey(name: 'achieved_at') final DateTime? achievedAt,
          @JsonKey(name: 'modified_by') final String? modifiedBy}) =
      _$CompetenceGoalImpl;

  factory _CompetenceGoal.fromJson(Map<String, dynamic> json) =
      _$CompetenceGoalImpl.fromJson;

  @override
  @JsonKey(name: 'competence_id')
  int get competenceId;
  @override
  @JsonKey(name: 'competence_goal_id')
  String get competenceGoalId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'pupil_id')
  int get pupilId;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'strategies')
  String get strategies;
  @override
  int? get achieved;
  @override
  @JsonKey(name: 'achieved_at')
  DateTime? get achievedAt;
  @override
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;
  @override
  @JsonKey(ignore: true)
  _$$CompetenceGoalImplCopyWith<_$CompetenceGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
