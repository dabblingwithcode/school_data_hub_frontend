import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_status_comment.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/dialogs/category_status_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';

import 'package:schuldaten_hub/features/learning_support/views/new_category_item_view/controller/new_category_item_controller.dart';

List<Widget> buildPupilCompetenceTree(PupilProxy pupil, int? parentId,
    double indentation, Color? passedBackGroundColor, BuildContext context) {
  List<Widget> competenceWidgets = [];
  final competenceLocator = locator<CompetenceManager>();
  List<Competence> competences = competenceLocator.competences.value;
  Color competenceBackgroundColor = backgroundColor;
  for (var competence in competences) {
    if (passedBackGroundColor == null) {
      if (competence.competenceName == 'Sachunterricht') {
        competenceBackgroundColor = const Color.fromARGB(255, 156, 76, 149);
      } else if (competence.competenceName == 'Englisch') {
        competenceBackgroundColor = const Color.fromARGB(255, 44, 46, 193);
      } else if (competence.competenceName == 'Mathematik') {
        competenceBackgroundColor = const Color.fromARGB(255, 5, 118, 172);
      } else if (competence.competenceName == 'Musik') {
        competenceBackgroundColor = const Color.fromARGB(255, 5, 155, 88);
      } else if (competence.competenceName == 'Deutsch') {
        competenceBackgroundColor = const Color.fromARGB(255, 231, 143, 56);
      } else if (competence.competenceName == 'Kunst') {
        competenceBackgroundColor = const Color.fromARGB(255, 244, 198, 17);
      } else if (competence.competenceName == 'Katholische Religion') {
        competenceBackgroundColor = const Color.fromARGB(255, 211, 115, 13);
      } else if (competence.competenceName == 'Islamische Religion') {
        competenceBackgroundColor = const Color.fromARGB(255, 227, 168, 29);
      }
    } else {
      competenceBackgroundColor = passedBackGroundColor;
    }

    if (competence.parentCompetence == parentId) {
      final children = buildPupilCompetenceTree(pupil, competence.competenceId,
          indentation + 15, competenceBackgroundColor, context);

      competenceWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: competenceBackgroundColor,
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
                        backgroundColor: competenceBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onLongPress: () {
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (ctx) => NewCategoryGoalView(
                                        //     pupilId: pupil.internalId,
                                        //     goalCategoryId:
                                        //         competence.competenceId,
                                        //   ),
                                        // ));
                                      },
                                      child: locator<GoalManager>()
                                          .getLastCategoryStatusSymbol(
                                              pupil, competence.competenceId),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      competence.competenceName,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              // locator<GoalManager>().getCategoryStatusComment(
                              //     pupil, competence.competenceId),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: competenceBackgroundColor,
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
                            child: InkWell(
                              onTap: () => categoryStatusDialog(
                                  pupil, competence.competenceId, context),
                              onLongPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => NewCategoryItem(
                                    appBarTitle: 'Neues Förderziel',
                                    pupilId: pupil.internalId,
                                    goalCategoryId: competence.competenceId,
                                    elementType: 'goal',
                                  ),
                                ));
                              },
                              child: locator<GoalManager>()
                                  .getLastCategoryStatusSymbol(
                                      pupil, competence.competenceId),
                            ),
                          ),
                          const Gap(5),
                          Flexible(
                            child: Text(
                              competence.competenceName,
                              maxLines: 4,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      getCategoryStatusComment(pupil, competence.competenceId),
                    ],
                  ),
                ),
        ),
      );
    }
  }

  return competenceWidgets;
}
