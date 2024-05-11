import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/special_info_list_view.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoList extends WatchingStatefulWidget {
  const SpecialInfoList({Key? key}) : super(key: key);
  @override
  SpecialInfoListController createState() => SpecialInfoListController();
}

class SpecialInfoListController extends State<SpecialInfoList> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<PupilFilterManager>().setFilter(PupilFilter.specialInfo, true);
    super.initState();
  }

  String pickUpValue(String? value) {
    return pickupTimePredicate(value);
  }

  @override
  void dispose() {
    locator<PupilFilterManager>().setFilter(PupilFilter.specialInfo, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpecialInfoListView(this);
  }
}
