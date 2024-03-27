import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> learningSupportGoalsBatches(Pupil pupil) {
  List<Widget> widgetList = [];
  List<PupilGoal> pupilGoals = pupil.pupilGoals!;

  Map<int, int> categoryCounts = {};

  // Calculate counts
  for (var goal in pupilGoals) {
    int rootCategoryId =
        locator<GoalManager>().getRootCategory(goal.goalCategoryId).categoryId;
    if (categoryCounts.containsKey(rootCategoryId)) {
      categoryCounts[rootCategoryId] = categoryCounts[rootCategoryId]! + 1;
    } else {
      categoryCounts[rootCategoryId] = 1;
    }
  }

  categoryCounts.forEach((categoryId, count) {
    widgetList.add(
      Container(
        width: 21.0,
        height: 21.0,
        decoration: BoxDecoration(
          color: locator<GoalManager>().getRootCategoryColor(
              locator<GoalManager>().getRootCategory(categoryId)),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            count.toString(),
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    widgetList.add(
      const Gap(5),
    );
  });

  return widgetList;
}
