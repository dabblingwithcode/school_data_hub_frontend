// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GoalCategory {
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'parent_category')
  final int? parentCategory;

  factory GoalCategory.fromJson(Map<String, dynamic> json) =>
      _$GoalCategoryFromJson(this);

  GoalCategory(
      {required this.categoryId,
      required this.categoryName,
      required this.parentCategory});
}
