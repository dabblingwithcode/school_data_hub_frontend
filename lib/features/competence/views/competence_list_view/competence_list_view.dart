import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/competence/views/competence_list_view/controller/competence_list_controller.dart';
import 'package:schuldaten_hub/features/competence/views/competence_list_view/widgets/competence_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/competence/views/competence_list_view/widgets/competence_tree.dart';

import 'package:watch_it/watch_it.dart';

class CompetenceListView extends WatchingWidget {
  final CompetenceListController controller;
  const CompetenceListView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Competence> competences =
        watchValue((CompetenceFilterManager x) => x.filteredCompetences);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'Kompetenzen',
          style: appBarTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<CompetenceManager>().fetchCompetences(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 10, right: 10, bottom: 10),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: Column(children: [
                  ...buildCompetenceTree(
                      controller.navigateToNewCompetenceview,
                      controller.navigateToPatchCompetenceView,
                      null,
                      0,
                      null,
                      competences),
                ]),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: competenceListViewBottomNavBar(context, competences),
    );
  }
}
