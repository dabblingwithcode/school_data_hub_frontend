import 'package:flutter/material.dart';

import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class SupportCategoryTree extends StatelessWidget {
  final int parentId;
  final int indentation;
  final Color? backGroundColor;
  const SupportCategoryTree(
      {required this.parentId,
      required this.indentation,
      this.backGroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

List<Widget> buildCategoryTree(
    int? parentId, int indentation, Color? backGroundColor) {
  List<Widget> goalCategoryWidgets = [];
  final goalLocator = locator<GoalManager>();
  List<GoalCategory> goalCategories = goalLocator.goalCategories.value;
  Color categoryBackgroundColor = backGroundColor ?? Colors.blue;
  for (var goalCategory in goalCategories) {
    if (backGroundColor == null) {
      if (goalCategory.categoryName == 'Körper, Wahrnehmung, Motorik') {
        categoryBackgroundColor = const Color.fromARGB(255, 156, 76, 149);
      } else if (goalCategory.categoryName ==
          'Sozialkompetenz / Emotionalität') {
        categoryBackgroundColor = const Color.fromARGB(255, 233, 127, 22);
      } else if (goalCategory.categoryName == 'Mathematik') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 118, 172);
      } else if (goalCategory.categoryName == 'Lernen und Leisten') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 155, 88);
      } else if (goalCategory.categoryName == 'Deutsch') {
        categoryBackgroundColor = const Color.fromARGB(255, 228, 70, 60);
      } else if (goalCategory.categoryName == 'Sprache und Sprechen') {
        categoryBackgroundColor = const Color.fromARGB(255, 244, 198, 17);
      }
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (goalCategory.parentCategory == parentId) {
      final children = buildCategoryTree(
          goalCategory.categoryId, indentation + 1, categoryBackgroundColor);

      goalCategoryWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: 16.0 * indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: categoryBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: true,
                        backgroundColor: categoryBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  goalCategory.categoryName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: categoryBackgroundColor,
                        children: children,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          goalCategory.categoryName,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );

      //return goalCategoryWidgets;
    }
  }

  return goalCategoryWidgets;
}
