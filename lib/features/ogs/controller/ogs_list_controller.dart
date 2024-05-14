import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/ogs/ogs_list_view.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:watch_it/watch_it.dart';

class OgsList extends WatchingStatefulWidget {
  const OgsList({Key? key}) : super(key: key);
  @override
  OgsListController createState() => OgsListController();
}

class OgsListController extends State<OgsList> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<PupilFilterManager>().setFilter(PupilFilter.ogs, true);
    super.initState();
  }

  String pickUpValue(String? value) {
    return pickupTimePredicate(value);
  }

  @override
  void dispose() {
    locator<PupilFilterManager>().setFilter(PupilFilter.ogs, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OgsListView(this);
  }
}
