import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support/services/learning_support_helper_functions.dart';
import 'package:schuldaten_hub/features/learning_support/pages/new_category_item_page/controller/new_category_item_controller.dart';
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
        logger.i(
            'Adding status vom ${status.createdAt.formatForUser()} erstellt von ${status.createdBy}');
      } else {
        //- GECHECKT
        //- This one is returning a unique status for this category
        statusesWidgetList.add(
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: pupil.pupilCategoryStatuses!.any((element) =>
                          element.goalCategoryId == status.goalCategoryId)
                      ? Colors.green
                      : accentColor,
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
                CategoryStatusEntry(
                  pupil: pupil,
                  status: status,
                ),
              ],
            ),
          ),
        );
      }
    }
    //- Now let's build the statuses with multiple entries for a category
    if (statusesWithDuplicateGoalCategory.isNotEmpty) {
      for (int key in statusesWithDuplicateGoalCategory.keys) {
        logger.w('Duplicate status, setting a key: $key');
        List<PupilCategoryStatus> mappedStatusesWithSameGoalCategory = [];

        mappedStatusesWithSameGoalCategory =
            statusesWithDuplicateGoalCategory[key]!;

        statusesWidgetList.add(
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: pupil.pupilCategoryStatuses!
                          .any((element) => element.goalCategoryId == key)
                      ? Colors.green
                      : accentColor,
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
                CategoryStatusEntry(
                    pupil: pupil,
                    status: mappedStatusesWithSameGoalCategory[i]),
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

class CategoryStatusEntry extends StatelessWidget {
  final PupilProxy pupil;
  final PupilCategoryStatus status;

  const CategoryStatusEntry(
      {required this.pupil, required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final bool authorizedToChangeStatus = isAuthorizedToChangeStatus(status);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: InkWell(
        onLongPress: () async {
          if (!authorizedToChangeStatus) {
            informationDialog(context, 'Keine Berechtigung',
                'Sie haben keine Berechtigung für das Löschen des Status!');
            return;
          }
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
                  authorizedToChangeStatus
                      ? InkWell(
                          onTap: () async {
                            final String? correctedComment =
                                await longTextFieldDialog('Status korrigieren',
                                    status.comment, context);
                            if (correctedComment != null) {
                              locator<GoalManager>()
                                  .updateCategoryStatusProperty(
                                pupil: pupil,
                                statusId: status.statusId,
                                comment: correctedComment,
                              );
                            }
                          },
                          child: Text(status.comment,
                              style: const TextStyle(
                                color: interactiveColor,
                                fontWeight: FontWeight.bold,
                              )))
                      : Text(status.comment),
                  const Gap(5),
                  Wrap(
                    children: [
                      const Text('Eingetragen von '),
                      const Gap(5),
                      authorizedToChangeStatus
                          ? InkWell(
                              onTap: () async {
                                final String? correctedCreatedBy =
                                    await shortTextfieldDialog(
                                        title: 'Ersteller ändern',
                                        obscureText: false,
                                        hintText: 'Kürzel eintragen',
                                        labelText: status.createdBy,
                                        context: context);
                                if (correctedCreatedBy != null) {
                                  locator<GoalManager>()
                                      .updateCategoryStatusProperty(
                                    pupil: pupil,
                                    statusId: status.statusId,
                                    createdBy: correctedCreatedBy,
                                  );
                                }
                              },
                              child: Text(
                                status.createdBy,
                                style: const TextStyle(
                                  color: interactiveColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(
                              status.createdBy,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const Text(' am '),
                      authorizedToChangeStatus
                          ? InkWell(
                              onTap: () async {
                                final DateTime? correctedCreatedAt =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: status.createdAt,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if (correctedCreatedAt != null) {
                                  locator<GoalManager>()
                                      .updateCategoryStatusProperty(
                                    pupil: pupil,
                                    statusId: status.statusId,
                                    createdAt:
                                        correctedCreatedAt.formatForJson(),
                                  );
                                }
                              },
                              child: Text(
                                status.createdAt.formatForUser(),
                                style: const TextStyle(
                                  color: interactiveColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(
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
}
