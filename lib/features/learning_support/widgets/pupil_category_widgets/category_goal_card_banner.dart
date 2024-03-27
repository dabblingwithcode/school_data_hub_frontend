import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';

Widget categoryGoalCardBanner(int categoryId) {
  return Container(
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>().getRootCategory(categoryId)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locator<GoalManager>()
                      .getRootCategory(categoryId)
                      .categoryName,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ));
}
