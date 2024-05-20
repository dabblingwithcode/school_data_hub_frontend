import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_page/widgets/special_info_filter_bottom_sheet.dart';

Widget specialInfoResetFilterButton(BuildContext context, bool filtersOn) {
  return InkWell(
    onTap: () => showSpecialInfoFilterBottomSheet(context),
    onLongPress: () {
      locator<PupilFilterManager>().resetFilters();

      locator<PupilFilterManager>().setFilter(PupilFilter.specialInfo, true);
      locator<PupilFilterManager>().filtersOnSwitch(false);
    },
    child: Icon(
      Icons.filter_list,
      color: filtersOn ? Colors.deepOrange : Colors.white,
      size: 30,
    ),
  );
}
