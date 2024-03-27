import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/competence/views/competence_list_view/widgets/competence_filter_bottom_sheet.dart';

BottomAppBar competenceListViewBottomNavBar(
    BuildContext context, List<Competence> competences) {
  return BottomAppBar(
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            tooltip: 'zurück',
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            tooltip: 'aktualisieren',
            icon: const Icon(Icons.update_rounded),
            onPressed: () {
              locator<CompetenceFilterManager>()
                  .refreshFilteredCompetences(competences);
            },
          ),
          IconButton(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => showCompetenceFilterBottomSheet(context),
          ),
          const Gap(10)
        ],
      ),
    ),
  );
}
