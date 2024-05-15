// import 'package:flutter/material.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/features/schooldayEvents/views/schooldayEvent_list_view/schooldayEvent_list_view.dart';
// import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
// import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
// import 'package:watch_it/watch_it.dart';

// class SchooldayEventList extends WatchingStatefulWidget {
//   const SchooldayEventList({Key? key}) : super(key: key);

//   @override
//   SchooldayEventListController createState() => SchooldayEventListController();
// }

// class SchooldayEventListController extends State<SchooldayEventList> {
//   List<PupilProxy>? pupils;
//   List<PupilProxy>? filteredPupils;
//   TextEditingController searchController = TextEditingController();
//   bool isSearchMode = false;
//   bool isSearching = false;
//   FocusNode focusNode = FocusNode();
//   @override
//   void initState() {
//     locator<PupilFilterManager>().refreshFilteredPupils();
//     pupils = locator<PupilManager>().allPupils.value;
//     super.initState();
//   }

//   void getPupilsFromServer() async {
//     if (filteredPupils == []) {
//       return;
//     }
//     final List<int> pupilsToFetch = [];
//     for (PupilProxy pupil in filteredPupils!) {
//       pupilsToFetch.add(pupil.internalId);
//     }
//     await locator.get<PupilManager>().fetchPupilsByInternalId(pupilsToFetch);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SchooldayEventListView(this);
//   }
// }
