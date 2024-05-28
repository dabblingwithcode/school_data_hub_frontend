import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_goal_card_banner.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

Widget categoryGoalCard(BuildContext context, PupilProxy pupil, int index) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: InkWell(
        onLongPress: () async {
          final bool? delete = await confirmationDialog(
              context, 'Förderziel löschen', 'Förderziel löschen?');
          if (delete == true) {
            await locator<GoalManager>()
                .deleteGoal(pupil.pupilGoals![index].goalId);
            return;
          }
          return;
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: groupColor,
                width: 2,
              )),
          color: cardInCardColor,
          child: Column(
            children: [
              const Gap(5),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: locator<GoalManager>().getRootCategoryColor(
                        locator<GoalManager>().getRootCategory(
                            pupil.pupilGoals![index].goalCategoryId)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: categoryGoalCardBanner(
                      pupil.pupilGoals![index].goalCategoryId),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: locator<GoalManager>().getLastCategoryStatusSymbol(
                          pupil, pupil.pupilGoals![index].goalCategoryId),
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        locator<GoalManager>()
                            .getGoalCategory(
                                pupil.pupilGoals![index].goalCategoryId)
                            .categoryName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(5),
              Row(
                children: [
                  const Gap(15),
                  Flexible(
                    child: Text(
                      pupil.pupilGoals![index].description!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: groupColor),
                    ),
                  ),
                  const Gap(10)
                ],
              ),
              const Gap(5),
              const Row(
                children: [
                  Gap(15),
                  Text('Strategien:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  const Gap(15),
                  Flexible(
                    child: Text(
                      pupil.pupilGoals![index].strategies!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  const Gap(15),
                  const Text('Erstellt von:'),
                  const Gap(10),
                  Text(
                    pupil.pupilGoals![index].createdBy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(15),
                  const Text('am'),
                  const Gap(10),
                  Text(
                    pupil.pupilGoals![index].createdAt.formatForUser(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    ),
  );
}
