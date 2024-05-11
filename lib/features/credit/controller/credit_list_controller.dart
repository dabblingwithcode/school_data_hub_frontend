import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/credit/credit_list_view.dart';
import 'package:watch_it/watch_it.dart';

import '../../pupil/models/pupil.dart';

class CreditList extends WatchingStatefulWidget {
  const CreditList({Key? key}) : super(key: key);

  @override
  CreditListController createState() => CreditListController();
}

class CreditListController extends State<CreditList> {
  List<Pupil>? pupils;
  List<Pupil>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  //- Values for the search bar
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

  @override
  Widget build(BuildContext context) {
    int userCredit = watchValue((SessionManager x) => x.credentials).credit!;
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    return CreditListView(this, userCredit, filtersOn, pupils);
  }
}
