import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_helper_functions.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_page/widgets/pupil_list_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_page/widgets/school_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListPupilsPageSearchBar extends WatchingWidget {
  final SchoolList schoolList;
  final List<PupilProxy> pupils;

  const SchoolListPupilsPageSearchBar(
      {required this.pupils, required this.schoolList, super.key});

  @override
  Widget build(BuildContext context) {
    final bool filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    return Container(
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.00),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schoolList.listDescription,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        schoolListStatsRow(schoolList, pupils),
                        const Gap(10),
                        const Icon(
                          Icons.school_rounded,
                          color: backgroundColor,
                        ),
                        const Gap(10),
                        schoolList.visibility != 'public'
                            ? Text(
                                schoolList.createdBy,
                                style: const TextStyle(
                                    color: backgroundColor,
                                    fontWeight: FontWeight.bold),
                              )
                            : const SizedBox.shrink(),
                        Text(
                          listOwners(schoolList),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                    child: SearchTextField(
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: locator<PupilsFilter>().refreshs)),
                InkWell(
                  onTap: () => showPupilListFilterBottomSheet(context),
                  onLongPress: () => locator<PupilsFilter>().resetFilters(),
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
}
