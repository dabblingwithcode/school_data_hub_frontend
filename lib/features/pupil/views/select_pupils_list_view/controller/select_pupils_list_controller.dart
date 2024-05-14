import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/select_pupils_list_view.dart';

import 'package:watch_it/watch_it.dart';

class SelectPupilList extends WatchingStatefulWidget {
  final List<int>? selectablePupils;
  const SelectPupilList(this.selectablePupils, {super.key});

  @override
  SelectPupilListController createState() => SelectPupilListController();
}

class SelectPupilListController extends State<SelectPupilList> {
  List<PupilProxy>? pupils;
  List<PupilProxy>? filteredPupils;
  Map<PupilFilter, bool>? inheritedFilters;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<int> selectedPupilIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    //locator<PupilFilterManager>().refreshFilteredPupils();
    setState(() {
      inheritedFilters = locator<PupilFilterManager>().filterState.value;
      pupils = locator<PupilManager>().allPupils.value;
      //filteredPupils = List.from(pupils!);
    });
    super.initState();
  }

  // void getPupilsFromServer() async {
  //   if (filteredPupils == []) {
  //     return;
  //   }
  //   final List<int> pupilsToFetch = [];
  //   for (PupilProxy pupil in filteredPupils!) {
  //     pupilsToFetch.add(pupil.internalId);
  //   }
  //   await locator.get<PupilManager>().fetchPupilsById(pupilsToFetch);
  // }

  void search() async {
    if (!isSearching) {
      setState(() {
        isSearching = true;
      });
    }

    if (!isSearchMode) return;
    setState(() {
      isSearching = false;
    });
  }

  void cancelSelect() {
    setState(() {
      selectedPupilIds.clear();
      isSelectMode = false;
    });
  }

  void cancelSearch({bool unfocus = true}) {
    setState(() {
      searchController.clear();
      isSearchMode = false;
      locator<PupilFilterManager>().setSearchText('');
      filteredPupils = List.from(pupils!);
      isSearching = false;
    });

    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onCardPress(int pupilId) {
    if (selectedPupilIds.contains(pupilId)) {
      setState(() {
        selectedPupilIds.remove(pupilId);
        if (selectedPupilIds.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedPupilIds.add(pupilId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedPupilIds.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<PupilProxy> shownPupils =
            locator<PupilFilterManager>().filteredPupils.value;
        isSelectMode = true;
        selectedPupilIds =
            shownPupils.map((pupil) => pupil.internalId).toList();
      } else {
        isSelectMode = false;
        selectedPupilIds.clear();
      }
    });
  }

  List<int> getSelectedPupilIds() {
    return selectedPupilIds.toList();
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;
    locator<PupilFilterManager>().setSearchText(text);
    setState(() {
      // final pupils = locator<PupilFilterManager>().filteredPupils.value;
      // isSearchMode = true;
      // filteredPupils = pupils
      //     .where(
      //       (user) =>
      //           user.firstName!.toLowerCase().contains(text.toLowerCase()),
      //     )
      //     .toList();
    });
  }

  // @override
  // void dispose() {
  //   if (inheritedFilters != null) {
  //     locator<PupilFilterManager>().restoreFilterValues(inheritedFilters!);
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> filteredPupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    List<PupilProxy> filteredListedPupils =
        pupilsFromPupilIds(widget.selectablePupils!)
            .where((pupil) => filteredPupils.contains(pupil))
            .toList();
    return SelectPupilListView(this, filteredListedPupils);
  }
}
