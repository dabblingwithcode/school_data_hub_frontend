import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/pupil_list_filter_bottom_sheet.dart';

class SchoolListPupilsPageBottomNavBar extends StatelessWidget {
  final String listId;
  final bool filtersOn;
  final List<int> pupilsInList;
  const SchoolListPupilsPageBottomNavBar(
      {required this.filtersOn,
      required this.listId,
      required this.pupilsInList,
      super.key});

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
              const Gap(15),
              if (locator<SchoolListManager>()
                          .getSchoolListById(listId)
                          .visibility !=
                      'public' ||
                  locator<SessionManager>().credentials.value.username ==
                      locator<SchoolListManager>()
                          .getSchoolListById(listId)
                          .createdBy)
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
                            .patchSchoolList(listId, null, null, visibility);
                      }
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 30,
                    )),
              const Gap(15),
              IconButton(
                tooltip: 'Kinder hinzufügen',
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () async {
                  final List<int> selectedPupilIds =
                      await Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                SelectPupilList(restOfPupils(pupilsInList)),
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
              const Gap(15),
              InkWell(
                onTap: () => showPupilListFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(10)
            ],
          ),
        ),
      ),
    );
  }
}
