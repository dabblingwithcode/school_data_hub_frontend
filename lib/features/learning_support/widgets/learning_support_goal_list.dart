import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_item_view/controller/new_category_item_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_goal_card.dart';

List<Widget> learningSupportGoalList(BuildContext context, Pupil pupil) {
  return [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: actionButtonStyle,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewCategoryItem(
                    appBarTitle: 'Neues Förderziel',
                    pupilId: pupil.internalId,
                    goalCategoryId: 0,
                    elementType: 'goal',
                  )));
        },
        child: const Text(
          "NEUES FÖRDERZIEL",
          style: TextStyle(
              fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    const Gap(5),
    pupil.pupilGoals!.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.pupilGoals!.length,
            itemBuilder: (context, int index) {
              return categoryGoalCard(context, pupil, index);
            })
        : const SizedBox.shrink(),
    const Gap(10),
  ];
}
