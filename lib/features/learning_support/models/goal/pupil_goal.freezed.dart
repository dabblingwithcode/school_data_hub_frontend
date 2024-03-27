// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PupilGoal _$PupilGoalFromJson(Map<String, dynamic> json) {
  return _PupilGoal.fromJson(json);
}

/// @nodoc
mixin _$PupilGoal {
  int? get achieved => throw _privateConstructorUsedError;
  @JsonKey(name: 'achieved_at')
  DateTime? get achievedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_category_id')
  int get goalCategoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_checks')
  List<GoalCheck>? get goalChecks => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_id')
  String get goalId => throw _privateConstructorUsedError;
  String? get strategies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilGoalCopyWith<PupilGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilGoalCopyWith<$Res> {
  factory $PupilGoalCopyWith(PupilGoal value, $Res Function(PupilGoal) then) =
      _$PupilGoalCopyWithImpl<$Res, PupilGoal>;
  @useResult
  $Res call(
      {int? achieved,
      @JsonKey(name: 'achieved_at') DateTime? achievedAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      String? description,
      @JsonKey(name: 'goal_category_id') int goalCategoryId,
      @JsonKey(name: 'goal_checks') List<GoalCheck>? goalChecks,
      @JsonKey(name: 'goal_id') String goalId,
      String? strategies});
}

/// @nodoc
class _$PupilGoalCopyWithImpl<$Res, $Val extends PupilGoal>
    implements $PupilGoalCopyWith<$Res> {
  _$PupilGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achieved = freezed,
    Object? achievedAt = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? description = freezed,
    Object? goalCategoryId = null,
    Object? goalChecks = freezed,
    Object? goalId = null,
    Object? strategies = freezed,
  }) {
    return _then(_value.copyWith(
      achieved: freezed == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int?,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      goalCategoryId: null == goalCategoryId
          ? _value.goalCategoryId
          : goalCategoryId // ignore: cast_nullable_to_non_nullable
              as int,
      goalChecks: freezed == goalChecks
          ? _value.goalChecks
          : goalChecks // ignore: cast_nullable_to_non_nullable
              as List<GoalCheck>?,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      strategies: freezed == strategies
          ? _value.strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PupilGoalImplCopyWith<$Res>
    implements $PupilGoalCopyWith<$Res> {
  factory _$$PupilGoalImplCopyWith(
          _$PupilGoalImpl value, $Res Function(_$PupilGoalImpl) then) =
      __$$PupilGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? achieved,
      @JsonKey(name: 'achieved_at') DateTime? achievedAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      String? description,
      @JsonKey(name: 'goal_category_id') int goalCategoryId,
      @JsonKey(name: 'goal_checks') List<GoalCheck>? goalChecks,
      @JsonKey(name: 'goal_id') String goalId,
      String? strategies});
}

/// @nodoc
class __$$PupilGoalImplCopyWithImpl<$Res>
    extends _$PupilGoalCopyWithImpl<$Res, _$PupilGoalImpl>
    implements _$$PupilGoalImplCopyWith<$Res> {
  __$$PupilGoalImplCopyWithImpl(
      _$PupilGoalImpl _value, $Res Function(_$PupilGoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achieved = freezed,
    Object? achievedAt = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? description = freezed,
    Object? goalCategoryId = null,
    Object? goalChecks = freezed,
    Object? goalId = null,
    Object? strategies = freezed,
  }) {
    return _then(_$PupilGoalImpl(
      achieved: freezed == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int?,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      goalCategoryId: null == goalCategoryId
          ? _value.goalCategoryId
          : goalCategoryId // ignore: cast_nullable_to_non_nullable
              as int,
      goalChecks: freezed == goalChecks
          ? _value._goalChecks
          : goalChecks // ignore: cast_nullable_to_non_nullable
              as List<GoalCheck>?,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      strategies: freezed == strategies
          ? _value.strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PupilGoalImpl implements _PupilGoal {
  _$PupilGoalImpl(
      {this.achieved,
      @JsonKey(name: 'achieved_at') this.achievedAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      this.description,
      @JsonKey(name: 'goal_category_id') required this.goalCategoryId,
      @JsonKey(name: 'goal_checks') final List<GoalCheck>? goalChecks,
      @JsonKey(name: 'goal_id') required this.goalId,
      this.strategies})
      : _goalChecks = goalChecks;

  factory _$PupilGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$PupilGoalImplFromJson(json);

  @override
  final int? achieved;
  @override
  @JsonKey(name: 'achieved_at')
  final DateTime? achievedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  final String? description;
  @override
  @JsonKey(name: 'goal_category_id')
  final int goalCategoryId;
  final List<GoalCheck>? _goalChecks;
  @override
  @JsonKey(name: 'goal_checks')
  List<GoalCheck>? get goalChecks {
    final value = _goalChecks;
    if (value == null) return null;
    if (_goalChecks is EqualUnmodifiableListView) return _goalChecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'goal_id')
  final String goalId;
  @override
  final String? strategies;

  @override
  String toString() {
    return 'PupilGoal(achieved: $achieved, achievedAt: $achievedAt, createdAt: $createdAt, createdBy: $createdBy, description: $description, goalCategoryId: $goalCategoryId, goalChecks: $goalChecks, goalId: $goalId, strategies: $strategies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PupilGoalImpl &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.achievedAt, achievedAt) ||
                other.achievedAt == achievedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.goalCategoryId, goalCategoryId) ||
                other.goalCategoryId == goalCategoryId) &&
            const DeepCollectionEquality()
                .equals(other._goalChecks, _goalChecks) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.strategies, strategies) ||
                other.strategies == strategies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      achieved,
      achievedAt,
      createdAt,
      createdBy,
      description,
      goalCategoryId,
      const DeepCollectionEquality().hash(_goalChecks),
      goalId,
      strategies);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PupilGoalImplCopyWith<_$PupilGoalImpl> get copyWith =>
      __$$PupilGoalImplCopyWithImpl<_$PupilGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PupilGoalImplToJson(
      this,
    );
  }
}

abstract class _PupilGoal implements PupilGoal {
  factory _PupilGoal(
      {final int? achieved,
      @JsonKey(name: 'achieved_at') final DateTime? achievedAt,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'created_by') required final String createdBy,
      final String? description,
      @JsonKey(name: 'goal_category_id') required final int goalCategoryId,
      @JsonKey(name: 'goal_checks') final List<GoalCheck>? goalChecks,
      @JsonKey(name: 'goal_id') required final String goalId,
      final String? strategies}) = _$PupilGoalImpl;

  factory _PupilGoal.fromJson(Map<String, dynamic> json) =
      _$PupilGoalImpl.fromJson;

  @override
  int? get achieved;
  @override
  @JsonKey(name: 'achieved_at')
  DateTime? get achievedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  String? get description;
  @override
  @JsonKey(name: 'goal_category_id')
  int get goalCategoryId;
  @override
  @JsonKey(name: 'goal_checks')
  List<GoalCheck>? get goalChecks;
  @override
  @JsonKey(name: 'goal_id')
  String get goalId;
  @override
  String? get strategies;
  @override
  @JsonKey(ignore: true)
  _$$PupilGoalImplCopyWith<_$PupilGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
