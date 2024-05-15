import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/school_list_stats_row.dart';

class SchoolListCard extends StatelessWidget {
  final SchoolList schoolList;
  const SchoolListCard({required this.schoolList, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SchoolListPupils(
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
                              Text(
                                schoolList.visibility == 'public'
                                    ? 'HER'
                                    : schoolList.createdBy,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(right: 10))
                            ],
                          ),
                          const Gap(5),
                          Text(
                            schoolList.listDescription,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const Gap(10),
                          schoolListStatsRow(
                              schoolList,
                              locator<SchoolListManager>().pupilsInSchoolList(
                                schoolList.listId,
                                locator<PupilManager>().allPupils,
                              )),
                          const Column(
                            children: [],
                          )
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
