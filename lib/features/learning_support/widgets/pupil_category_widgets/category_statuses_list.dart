import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support/services/learning_support_helper_functions.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_item_page/controller/new_category_item_controller.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_tree_ancestors_names.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

List<Widget> pupilCategoryStatusesList(PupilProxy pupil, BuildContext context) {
  if (pupil.pupilCategoryStatuses != null) {
    List<Widget> statusesWidgetList = [];

    Map<int, List<PupilCategoryStatus>> statusesWithDuplicateGoalCategory = {};
    for (PupilCategoryStatus status in pupil.pupilCategoryStatuses!) {
      if (pupil.pupilCategoryStatuses!.any((element) =>
          element.goalCategoryId == status.goalCategoryId &&
          pupil.pupilCategoryStatuses!.indexOf(element) !=
              pupil.pupilCategoryStatuses!.indexOf(status))) {
        //- This one is duplicate. Adding a key / widget in the map
        if (!statusesWithDuplicateGoalCategory
            .containsKey(status.goalCategoryId)) {
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)] =
              List<PupilCategoryStatus>.empty(growable: true);
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)]!
              .add(status);
        } else {
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)]!
              .add(status);
        }
        debug.warning(
            'Adding status vom ${status.createdAt.formatForUser()} erstellt von ${status.createdBy}');
      } else {
        //- GECHECKT
        //- This one is returning a unique status for this category
        statusesWidgetList.add(
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: accentColor,
                  width: 2,
                )),
            child: Column(
              children: [
                const Gap(10),
                Row(
                  children: [
                    const Gap(10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: locator<GoalManager>()
                              .getCategoryColor(status.goalCategoryId),
                        ),
                        child: InkWell(
                          onLongPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => NewCategoryItem(
                                      appBarTitle: 'Neuer Förderbereich',
                                      pupilId: pupil.internalId,
                                      goalCategoryId: status.goalCategoryId,
                                      elementType: 'status',
                                    )));
                          },
                          child: Column(children: [
                            const Gap(5),
                            ...categoryTreeAncestorsNames(
                              status.goalCategoryId,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                Row(
                  children: [
                    const Gap(15),
                    Flexible(
                      child: Text(
                        locator<GoalManager>()
                            .getGoalCategory(status.goalCategoryId)
                            .categoryName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: locator<GoalManager>()
                                .getCategoryColor(status.goalCategoryId)),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Column(
                //       children: [
                //         Container(
                //           width: 20.0,
                //           height: 20.0,
                //           decoration: const BoxDecoration(
                //             color: interactiveColor,
                //             shape: BoxShape.circle,
                //           ),
                //           child: Center(
                //             child: Text(
                //               getGoalsForCategory(pupil, status.goalCategoryId)
                //                   .length
                //                   .toString(),
                //               style: const TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     const Gap(10),
                //   ],
                // ),
                statusEntry(pupil, status, context),
              ],
            ),
          ),
        );
      }
    }
    //- Now let's build the statuses with multiple entries for a category
    if (statusesWithDuplicateGoalCategory.isNotEmpty) {
      for (int key in statusesWithDuplicateGoalCategory.keys) {
        debug.warning('KEY: $key');
        List<PupilCategoryStatus> mappedStatusesWithSameGoalCategory = [];

        mappedStatusesWithSameGoalCategory =
            statusesWithDuplicateGoalCategory[key]!;

        statusesWidgetList.add(
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: accentColor,
                  width: 2,
                )),
            child: Column(children: [
              const Gap(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: locator<GoalManager>().getRootCategoryColor(
                          locator<GoalManager>().getRootCategory(
                            key,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onLongPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => NewCategoryItem(
                                    appBarTitle: 'Neuer Förderbereich',
                                    pupilId: pupil.internalId,
                                    goalCategoryId: key,
                                    elementType: 'status',
                                  )));
                        },
                        child: Column(
                          children: [
                            ...categoryTreeAncestorsNames(
                              key,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
              Row(
                children: [
                  const Gap(10),
                  Flexible(
                    child: Text(
                      locator<GoalManager>().getGoalCategory(key).categoryName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: locator<GoalManager>().getCategoryColor(key),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          color: interactiveColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            getGoalsForCategory(pupil, key).length.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
              for (int i = 0;
                  i < mappedStatusesWithSameGoalCategory.length;
                  i++) ...<Widget>[
                statusEntry(
                    pupil, mappedStatusesWithSameGoalCategory[i], context),
              ]
            ]),
          ),
        );
      }
    }
    return statusesWidgetList;
  }
  return [];
}

Widget statusEntry(
    PupilProxy pupil, PupilCategoryStatus status, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
    child: InkWell(
      onLongPress: () async {
        bool? confirm = await confirmationDialog(
            context, 'Status löschen?', 'Status löschen?');
        if (confirm != true) return;
        locator<GoalManager>().deleteCategoryStatus(status.statusId);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              locator<GoalManager>().getCategoryStatusSymbol(
                  pupil, status.goalCategoryId, status.statusId),
            ],
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAuthorizedToChangeStatus(status)
                    ? InkWell(
                        onTap: () async {
                          final String? correctedStatus =
                              await longTextFieldDialog('Status korrigieren',
                                  status.comment, context);
                          if (correctedStatus != null) {
                            locator<GoalManager>().updateCategoryStatusProperty(
                                pupil,
                                status.statusId,
                                correctedStatus,
                                null,
                                null,
                                null);
                          }
                        },
                        child: Text(status.comment,
                            style: const TextStyle(
                              color: interactiveColor,
                            )))
                    : Text(status.comment),
                const Gap(5),
                Wrap(
                  children: [
                    const Text('Eingetragen von '),
                    const Gap(5),
                    Text(
                      status.createdBy,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(' am '),
                    Text(
                      status.createdAt.formatForUser(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
