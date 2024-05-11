// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'goal_category.freezed.dart';
part 'goal_category.g.dart';

@JsonSerializable()
class GoalCategory with _$GoalCategory {
  factory GoalCategory({
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'parent_category') int? parentCategory,
  }) = _GoalCategory;

  factory GoalCategory.fromJson(Map<String, dynamic> json) =>
      _$GoalCategoryFromJson(json);
}
