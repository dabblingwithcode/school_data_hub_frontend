import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/credit/credit_list_view.dart';
import 'package:watch_it/watch_it.dart';

class CreditList extends WatchingStatefulWidget {
  const CreditList({Key? key}) : super(key: key);

  @override
  CreditListController createState() => CreditListController();
}

class CreditListController extends State<CreditList> {
  List<PupilProxy>? pupils;
  List<PupilProxy>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  //- Values for the search bar
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
    int userCredit = watchValue((SessionManager x) => x.credentials).credit!;
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<PupilProxy> pupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    return CreditListView(this, userCredit, filtersOn, pupils);
  }
}
