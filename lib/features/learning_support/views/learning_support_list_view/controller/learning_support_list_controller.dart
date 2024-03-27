import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_view/learning_support_list_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:watch_it/watch_it.dart';

class LearningSupportList extends WatchingStatefulWidget {
  const LearningSupportList({Key? key}) : super(key: key);

  @override
  LearningSupportListController createState() =>
      LearningSupportListController();
}

class LearningSupportListController extends State<LearningSupportList> {
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  //- overview numbers functions
  int developmentPlan1Pupils(List<Pupil> filteredPupils) {
    List<Pupil> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (Pupil pupil in filteredPupils) {
        if (pupil.individualDevelopmentPlan == 1) {
          developmentPlan1Pupils.add(pupil);
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  int developmentPlan2Pupils(List<Pupil> filteredPupils) {
    List<Pupil> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (Pupil pupil in filteredPupils) {
        if (pupil.individualDevelopmentPlan == 2) {
          developmentPlan1Pupils.add(pupil);
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  int developmentPlan3Pupils(List<Pupil> filteredPupils) {
    List<Pupil> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (Pupil pupil in filteredPupils) {
        if (pupil.individualDevelopmentPlan == 3) {
          developmentPlan1Pupils.add(pupil);
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  String preschoolRevision(int value) {
    switch (value) {
      case 0:
        return 'nicht da';
      case 1:
        return 'unauffällig';
      case 2:
        return 'Förderbedarf';
      case 3:
        return 'AO-SF';
      default:
        return 'keine';
    }
  }

  void cancelSearch({bool unfocus = true}) {
    if (locator<PupilFilterManager>().filterState.value ==
        initialFilterValues) {
      locator<PupilFilterManager>().filtersOnSwitch(false);
      locator<PupilFilterManager>().refreshFilteredPupils();
    }
    setState(() {
      searchController.clear();
      isSearchMode = false;
      isSearching = false;
    });
    locator<PupilFilterManager>().setSearchText('');
    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSearchEnter(String text) {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;

    locator<PupilFilterManager>().setSearchText(text);
  }

  @override
  Widget build(BuildContext context) {
    return LearningSupportListView(this);
  }
}
