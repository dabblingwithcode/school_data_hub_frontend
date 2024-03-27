import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';

import 'package:schuldaten_hub/features/competence/views/competence_list_view/competence_list_view.dart';
import 'package:schuldaten_hub/features/competence/views/new_competence_view/new_competence_view.dart';
import 'package:schuldaten_hub/features/competence/views/patch_competence_view/patch_competence_view.dart';

class CompetenceList extends StatefulWidget {
  const CompetenceList({
    Key? key,
  }) : super(key: key);

  @override
  CompetenceListController createState() => CompetenceListController();
}

class CompetenceListController extends State<CompetenceList> {
  navigateToNewCompetenceview(int competenceId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => NewCompetenceView(
        parentCompetence: competenceId,
      ),
    ));
  }

  navigateToPatchCompetenceView(Competence competence) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => PatchCompetenceView(
        competence: competence,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CompetenceListView(this);
  }
}
