// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GoalCategory _$GoalCategoryFromJson(Map<String, dynamic> json) {
  return _GoalCategory.fromJson(json);
}

/// @nodoc
mixin _$GoalCategory {
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_category')
  int? get parentCategory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCategoryCopyWith<GoalCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCategoryCopyWith<$Res> {
  factory $GoalCategoryCopyWith(
          GoalCategory value, $Res Function(GoalCategory) then) =
      _$GoalCategoryCopyWithImpl<$Res, GoalCategory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'category_id') int categoryId,
      @JsonKey(name: 'category_name') String categoryName,
      @JsonKey(name: 'parent_category') int? parentCategory});
}

/// @nodoc
class _$GoalCategoryCopyWithImpl<$Res, $Val extends GoalCategory>
    implements $GoalCategoryCopyWith<$Res> {
  _$GoalCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? parentCategory = freezed,
  }) {
    return _then(_value.copyWith(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      parentCategory: freezed == parentCategory
          ? _value.parentCategory
          : parentCategory // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalCategoryImplCopyWith<$Res>
    implements $GoalCategoryCopyWith<$Res> {
  factory _$$GoalCategoryImplCopyWith(
          _$GoalCategoryImpl value, $Res Function(_$GoalCategoryImpl) then) =
      __$$GoalCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'category_id') int categoryId,
      @JsonKey(name: 'category_name') String categoryName,
      @JsonKey(name: 'parent_category') int? parentCategory});
}

/// @nodoc
class __$$GoalCategoryImplCopyWithImpl<$Res>
    extends _$GoalCategoryCopyWithImpl<$Res, _$GoalCategoryImpl>
    implements _$$GoalCategoryImplCopyWith<$Res> {
  __$$GoalCategoryImplCopyWithImpl(
      _$GoalCategoryImpl _value, $Res Function(_$GoalCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? parentCategory = freezed,
  }) {
    return _then(_$GoalCategoryImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      parentCategory: freezed == parentCategory
          ? _value.parentCategory
          : parentCategory // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalCategoryImpl implements _GoalCategory {
  _$GoalCategoryImpl(
      {@JsonKey(name: 'category_id') required this.categoryId,
      @JsonKey(name: 'category_name') required this.categoryName,
      @JsonKey(name: 'parent_category') this.parentCategory});

  factory _$GoalCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'parent_category')
  final int? parentCategory;

  @override
  String toString() {
    return 'GoalCategory(categoryId: $categoryId, categoryName: $categoryName, parentCategory: $parentCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalCategoryImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.parentCategory, parentCategory) ||
                other.parentCategory == parentCategory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, categoryName, parentCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalCategoryImplCopyWith<_$GoalCategoryImpl> get copyWith =>
      __$$GoalCategoryImplCopyWithImpl<_$GoalCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalCategoryImplToJson(
      this,
    );
  }
}

abstract class _GoalCategory implements GoalCategory {
  factory _GoalCategory(
          {@JsonKey(name: 'category_id') required final int categoryId,
          @JsonKey(name: 'category_name') required final String categoryName,
          @JsonKey(name: 'parent_category') final int? parentCategory}) =
      _$GoalCategoryImpl;

  factory _GoalCategory.fromJson(Map<String, dynamic> json) =
      _$GoalCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'parent_category')
  int? get parentCategory;
  @override
  @JsonKey(ignore: true)
  _$$GoalCategoryImplCopyWith<_$GoalCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
