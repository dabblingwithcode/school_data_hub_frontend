import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

import 'package:schuldaten_hub/features/school_lists/pages/school_list_pupils_page/school_list_pupils_page.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_list_pupils_page/widgets/school_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListCard extends WatchingWidget {
  final SchoolList schoolList;
  const SchoolListCard({required this.schoolList, super.key});

  @override
  Widget build(BuildContext context) {
    final schoolList = watchValue((SchoolListManager x) => x.schoolLists)
        .firstWhere((element) => element.listId == this.schoolList.listId);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SchoolListPupilsPage(
                  schoolList,
                ),
              ));
            },
            onLongPress: () async {
              if (schoolList.createdBy !=
                  locator<SessionManager>().credentials.value.username) {
                informationDialog(context, 'Keine Berechtigung',
                    'Listen können nur von ListenbesiterInnen bearbeitet werden!');
                return;
              }
              final bool? result = await confirmationDialog(
                  context,
                  'Liste löschen',
                  'Liste "${schoolList.listName}" wirklich löschen?');
              if (result == true) {
                await locator<SchoolListManager>()
                    .deleteSchoolList(schoolList.listId);
                if (context.mounted) {
                  informationDialog(
                      context, 'Liste gelöscht', 'Die Liste wurde gelöscht!');
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    schoolList.listName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: interactiveColor),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              schoolList.visibility == 'public'
                                  ? const Icon(
                                      Icons.school_rounded,
                                      color: backgroundColor,
                                    )
                                  : Text(
                                      schoolList.createdBy,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              const Padding(padding: EdgeInsets.only(right: 10))
                            ],
                          ),
                          const Gap(10),
                          Text(
                            schoolList.listDescription,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: schoolListStatsRow(
                                        schoolList,
                                        locator<SchoolListManager>()
                                            .pupilsInSchoolList(
                                          schoolList.listId,
                                          locator<PupilManager>().allPupils,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
