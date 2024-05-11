import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/ogs/controller/ogs_list_controller.dart';
import 'package:schuldaten_hub/features/ogs/widgets/ogs_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

Widget ogsListSearchBar(BuildContext context, List<PupilProxy> pupils,
    OgsListController controller, bool filtersOn) {
  return Container(
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      children: [
        const Gap(5),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.people_alt_rounded,
                color: backgroundColor,
              ),
              const Gap(5),
              Text(
                pupils.length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: searchTextField(
                      SearchType.pupil,
                      'Schüler/in suchen',
                      controller,
                      locator<PupilFilterManager>().refreshFilteredPupils)),
              InkWell(
                onTap: () => showOgsFilterBottomSheet(context),
                onLongPress: () {
                  locator<PupilFilterManager>().resetFilters();

                  locator<PupilFilterManager>()
                      .setFilter(PupilFilter.ogs, true);
                  locator<PupilFilterManager>().filtersOnSwitch(false);
                },
                // onPressed: () => showBottomSheetFilters(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
