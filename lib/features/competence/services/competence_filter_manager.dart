import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class CompetenceFilterManager {
  ValueListenable<Map<CompetenceFilter, bool>> get filterState => _filterState;
  ValueListenable<List<Competence>> get filteredCompetences =>
      _filteredCompetences;
  ValueListenable<bool> get filtersOn => _filtersOn;

  final _filterState =
      ValueNotifier<Map<CompetenceFilter, bool>>(initialCompetenceFilterValues);
  final _filteredCompetences = ValueNotifier<List<Competence>>(
      locator<CompetenceManager>().competences.value);
  final _filtersOn = ValueNotifier<bool>(false);
  CompetenceFilterManager() {
    logger.i('CompetenceFilterManager constructor called.');
  }
  refreshFilteredCompetences(List<Competence> competences) {
    _filteredCompetences.value = competences;
    logger.i('refreshed filtered competences');
  }

  resetFilters() {
    _filteredCompetences.value = locator<CompetenceManager>().competences.value;
    _filterState.value = {...initialCompetenceFilterValues};
    _filtersOn.value = false;
  }

  void setFilter(CompetenceFilter filter, bool isActive) {
    _filterState.value = {
      ..._filterState.value,
      filter: isActive,
    };
    filterCompetences();
  }

  filterCompetences() {
    List<Competence> competences =
        locator<CompetenceManager>().competences.value;
    List<Competence> filteredCompetences = [];
    final activeFilters = _filterState.value;
    for (Competence competence in competences) {
      if (competence.competenceLevel != null) {
        if ((activeFilters[CompetenceFilter.E1]! &&
                !competence.competenceLevel!.contains('E1')) ||
            (activeFilters[CompetenceFilter.E2]! &&
                !competence.competenceLevel!.contains('E2')) ||
            (activeFilters[CompetenceFilter.S3]! &&
                !competence.competenceLevel!.contains('S3')) ||
            (activeFilters[CompetenceFilter.S4]! &&
                !competence.competenceLevel!.contains('S4'))) {
          continue;
        }
      }

      filteredCompetences.add(competence);

      _filteredCompetences.value = filteredCompetences;
    }
  }
}
