// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalCategory _$GoalCategoryFromJson(Map<String, dynamic> json) => GoalCategory(
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String,
      parentCategory: json['parent_category'] as int?,
    );

Map<String, dynamic> _$GoalCategoryToJson(GoalCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'parent_category': instance.parentCategory,
    };
