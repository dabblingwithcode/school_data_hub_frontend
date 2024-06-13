import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/filter_button.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:schuldaten_hub/features/pupil/pages/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_list_pupils_page/widgets/pupil_list_filter_bottom_sheet.dart';

class SchoolListPupilsPageBottomNavBar extends StatelessWidget {
  final String listId;

  final List<int> pupilsInList;
  const SchoolListPupilsPageBottomNavBar(
      {required this.listId, required this.pupilsInList, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(9),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              if (locator<SchoolListManager>()
                          .getSchoolListById(listId)
                          .visibility !=
                      'public' ||
                  locator<SessionManager>().credentials.value.username ==
                      locator<SchoolListManager>()
                          .getSchoolListById(listId)
                          .createdBy)
                Row(
                  children: [
                    const Gap(30),
                    IconButton(
                        tooltip: 'Liste teilen',
                        onPressed: () async {
                          final String? visibility = await shortTextfieldDialog(
                              context: context,
                              title: 'Liste teilen mit...',
                              labelText: 'Kürzel eingeben',
                              hintText: 'Kürzel eingeben',
                              obscureText: false);
                          if (visibility != null) {
                            locator<SchoolListManager>()
                                .updateSchoolListProperty(
                                    listId, null, null, visibility);
                          }
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 30,
                        )),
                  ],
                ),
              const Gap(30),
              IconButton(
                tooltip: 'Kinder hinzufügen',
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () async {
                  final List<int> selectedPupilIds =
                      await Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SelectPupilsListPage(
                                selectablePupils: locator<PupilManager>()
                                    .restOfPupils(pupilsInList)),
                          )) ??
                          [];
                  if (selectedPupilIds.isNotEmpty) {
                    locator<SchoolListManager>().addPupilsToSchoolList(
                      listId,
                      selectedPupilIds,
                    );
                  }
                },
              ),
              const Gap(30),
              const FilterButton(
                isSearchBar: false,
                showBottomSheetFunction: showPupilListFilterBottomSheet,
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
