import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/admonition_list_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionList extends WatchingStatefulWidget {
  const AdmonitionList({Key? key}) : super(key: key);

  @override
  AdmonitionListController createState() => AdmonitionListController();
}

class AdmonitionListController extends State<AdmonitionList> {
  List<PupilProxy>? pupils;
  List<PupilProxy>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<PupilFilterManager>().refreshFilteredPupils();
    pupils = locator<PupilManager>().pupils.value;
    super.initState();
  }

  void getPupilsFromServer() async {
    if (filteredPupils == []) {
      return;
    }
    final List<int> pupilsToFetch = [];
    for (PupilProxy pupil in filteredPupils!) {
      pupilsToFetch.add(pupil.internalId);
    }
    await locator.get<PupilManager>().fetchPupilsById(pupilsToFetch);
  }

  @override
  Widget build(BuildContext context) {
    return AdmonitionListView(this);
  }
}
