import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';

List<Widget> buildCompetenceTree(
    Function(int) navigateToNewCompetenceView,
    Function(Competence) navigateToPatchCompetenceView,
    int? parentId,
    int indentation,
    Color? backgroundColor,
    List<Competence> competences) {
  List<Widget> competenceWidgets = [];

  Color competenceBackgroundColor = backgroundColor ?? Colors.red;
  for (var competence in competences) {
    if (backgroundColor == null) {
      if (competence.competenceName == 'Sachunterricht') {
        competenceBackgroundColor = const Color.fromARGB(255, 156, 76, 149);
      } else if (competence.competenceName == 'Englisch') {
        competenceBackgroundColor = const Color.fromARGB(255, 233, 127, 22);
      } else if (competence.competenceName == 'Mathematik') {
        competenceBackgroundColor = const Color.fromARGB(255, 5, 118, 172);
      } else if (competence.competenceName == 'Musik') {
        competenceBackgroundColor = const Color.fromARGB(255, 5, 155, 88);
      } else if (competence.competenceName == 'Deutsch') {
        competenceBackgroundColor = const Color.fromARGB(255, 228, 70, 60);
      } else if (competence.competenceName == 'Kunst') {
        competenceBackgroundColor = const Color.fromARGB(255, 244, 198, 17);
      } else if (competence.competenceName == 'Katholische Religion') {
        competenceBackgroundColor = const Color.fromARGB(255, 211, 115, 13);
      } else if (competence.competenceName == 'Islamische Religion') {
        competenceBackgroundColor = const Color.fromARGB(255, 227, 168, 29);
      } else if (competence.competenceName == 'Sport') {
        competenceBackgroundColor = const Color.fromARGB(255, 245, 62, 114);
      }
    } else {
      competenceBackgroundColor = backgroundColor;
    }
    if (competence.parentCompetence == parentId) {
      final children = buildCompetenceTree(
          navigateToNewCompetenceView,
          navigateToPatchCompetenceView,
          competence.competenceId,
          indentation + 1,
          competenceBackgroundColor,
          competences);

      competenceWidgets.add(
        children.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(top: 10, left: 16.0 * indentation),
                child: Wrap(
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
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      onTap: () =>
                                          navigateToPatchCompetenceView(
                                              competence),
                                      onLongPress: () =>
                                          navigateToNewCompetenceView(
                                              competence.competenceId),
                                      child: Text(
                                        competence.competenceName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: competenceBackgroundColor,
                        children: children,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 10, left: 16.0 * indentation),
                child: Container(
                  color: competenceBackgroundColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () =>
                                  navigateToPatchCompetenceView(competence),
                              onLongPress: () => navigateToNewCompetenceView(
                                  competence.competenceId),
                              child: Text(
                                competence.competenceName,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      competence.indicators != null
                          ? Row(
                              children: [
                                const Text(
                                  'Indikatoren:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                                const Gap(10),
                                Text(
                                  competence.indicators!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      competence.competenceLevel != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      competence.competenceLevel!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
      );
    }
  }
  return competenceWidgets;
}
