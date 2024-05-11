import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';

import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/controller/selectable_category_tree_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

List<Widget> buildPupilCategoryTree(
  BuildContext context,
  PupilProxy pupil,
  int? parentId,
  double indentation,
  Color? backGroundColor,
  SelectableCategoryTreeController controller,
  String elementType,
) {
  List<Widget> goalCategoryWidgets = [];
  final goalLocator = locator<GoalManager>();
  List<GoalCategory> goalCategories = goalLocator.goalCategories.value;
  Color categoryBackgroundColor;

  for (var goalCategory in goalCategories) {
    if (backGroundColor == null) {
      categoryBackgroundColor =
          locator<GoalManager>().getRootCategoryColor(goalCategory) ??
              Colors.red;
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (goalCategory.parentCategory == parentId) {
      final children = buildPupilCategoryTree(
          context,
          pupil,
          goalCategory.categoryId,
          indentation + 15,
          categoryBackgroundColor,
          controller,
          elementType);

      goalCategoryWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: categoryBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: false,
                        backgroundColor: categoryBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      goalCategory.categoryName,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
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
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:
                                // getCategoryStatus(
                                //             pupil, goalCategory.categoryId) ==
                                //         null
                                //     ?
                                Radio(
                              value: goalCategory.categoryId,
                              groupValue: controller.selectedCategoryId,
                              onChanged: (value) {
                                controller.selectCategory(value!);
                              },
                            ),
                            // : const Row(children: [
                            //     Gap(7),
                            //     Icon(
                            //       Icons.support,
                            //       color: Colors.white,
                            //     )
                            //   ]),
                          ),
                          const Gap(5),
                          Flexible(
                            child: InkWell(
                              onTap: () => controller
                                  .selectCategory(goalCategory.categoryId),
                              onLongPress: locator<SessionManager>()
                                      .isAdmin
                                      .value
                                  ? () async {
                                      if (pupil
                                          .pupilCategoryStatuses!.isEmpty) {
                                        return;
                                      }
                                      final bool? delete =
                                          await confirmationDialog(
                                              context,
                                              'Kategoriestatus löschen',
                                              'Kategoriestatus löschen?');
                                      if (delete == true) {
                                        final PupilCategoryStatus?
                                            categoryStatus = pupil
                                                .pupilCategoryStatuses!
                                                .lastWhereOrNull((element) =>
                                                    element.goalCategoryId ==
                                                    goalCategory.categoryId);
                                        await locator<GoalManager>()
                                            .deleteCategoryStatus(
                                                categoryStatus!.statusId);
                                      }
                                      return;
                                    }
                                  : () {},
                              child: Text(
                                goalCategory.categoryName,
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
  }

  return goalCategoryWidgets;
}
