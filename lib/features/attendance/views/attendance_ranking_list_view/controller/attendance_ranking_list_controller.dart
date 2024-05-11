import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/attendance_ranking_list_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingList extends WatchingStatefulWidget {
  const AttendanceRankingList({Key? key}) : super(key: key);

  @override
  AttendanceRankingListController createState() =>
      AttendanceRankingListController();
}

class AttendanceRankingListController extends State<AttendanceRankingList> {
  // List<PupilProxy>? pupils;
  // List<PupilProxy>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  int totalFluidCredit(List<PupilProxy> pupils) {
    int totalCredit = 0;
    for (PupilProxy pupil in pupils) {
      totalCredit = totalCredit + pupil.credit;
    }
    return totalCredit;
  }

  int totalGeneratedCredit(List<PupilProxy> pupils) {
    int totalGeneratedCredit = 0;
    for (PupilProxy pupil in pupils) {
      totalGeneratedCredit = totalGeneratedCredit + pupil.creditEarned;
    }
    return totalGeneratedCredit;
  }

  @override
  Widget build(BuildContext context) {
    return AttendanceRankingListView(this);
  }
}
