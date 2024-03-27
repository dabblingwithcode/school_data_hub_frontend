import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/attendance_ranking_list_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

import 'package:watch_it/watch_it.dart';

class AttendanceRankingList extends WatchingStatefulWidget {
  const AttendanceRankingList({Key? key}) : super(key: key);

  @override
  AttendanceRankingListController createState() =>
      AttendanceRankingListController();
}

class AttendanceRankingListController extends State<AttendanceRankingList> {
  List<Pupil>? pupils;
  List<Pupil>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    pupils = locator<PupilManager>().pupils.value;
    filteredPupils = List.from(pupils!);
    locator<PupilFilterManager>().refreshFilteredPupils();
    super.initState();
  }

  int totalFluidCredit(List<Pupil> pupils) {
    int totalCredit = 0;
    for (Pupil pupil in pupils) {
      totalCredit = totalCredit + pupil.credit;
    }
    return totalCredit;
  }

  int totalGeneratedCredit(List<Pupil> pupils) {
    int totalGeneratedCredit = 0;
    for (Pupil pupil in pupils) {
      totalGeneratedCredit = totalGeneratedCredit + pupil.creditEarned;
    }
    return totalGeneratedCredit;
  }

  void getPupilsFromServer() async {
    if (filteredPupils == []) {
      return;
    }
    final List<int> pupilsToFetch = [];
    for (Pupil pupil in filteredPupils!) {
      pupilsToFetch.add(pupil.internalId);
    }
    await locator.get<PupilManager>().fetchPupilsById(pupilsToFetch);
  }

  // void _search() async {
  //   if (!isSearching) {
  //     setState(() {
  //       isSearching = true;
  //     });
  //   }

  //   if (!isSearchMode) return;
  //   setState(() {
  //     isSearching = false;
  //   });
  // }

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

    // _coolDown?.cancel();
    // _coolDown = Timer(const Duration(milliseconds: 500), _search);
  }

  @override
  Widget build(BuildContext context) {
    return AttendanceRankingListView(this);
  }
}
