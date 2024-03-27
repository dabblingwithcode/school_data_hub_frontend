// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalCategoryImpl _$$GoalCategoryImplFromJson(Map<String, dynamic> json) =>
    _$GoalCategoryImpl(
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String,
      parentCategory: json['parent_category'] as int?,
    );

Map<String, dynamic> _$$GoalCategoryImplToJson(_$GoalCategoryImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'parent_category': instance.parentCategory,
    };
