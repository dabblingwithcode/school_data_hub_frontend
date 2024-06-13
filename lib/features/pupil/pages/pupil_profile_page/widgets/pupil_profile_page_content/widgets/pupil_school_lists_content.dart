import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_list_pupils_page/school_list_pupils_page.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_lists_page/school_lists_page.dart';
import 'package:watch_it/watch_it.dart';

class PupilSchoolListsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilSchoolListsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(
              Icons.rule,
              color: accentColor,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const SchoolListsPage(),
                ));
              },
              child: const Text('Listen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            )
          ]),
          const Gap(15),
          PupilSchoolListContentList(pupil: pupil),
        ]),
      ),
    );
  }
}

class PupilSchoolListContentList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilSchoolListContentList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final schoolListLocator = locator<SchoolListManager>();
    final allPupilLists =
        watchValue((SchoolListManager x) => x.pupilSchoolLists);
    final pupilLists =
        schoolListLocator.getPupilListsFromPupilByPupilId(pupil.internalId);
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pupilLists.length,
          itemBuilder: (BuildContext context, int index) {
            final schoolList = schoolListLocator
                .getSchoolListById(pupilLists[index].originList);
            final pupilListEntry = schoolListLocator.getPupilSchoolListEntry(
                pupilId: pupil.internalId,
                listId: pupilLists[index].originList)!;
            return GestureDetector(
              onTap: () {},
              onLongPress: () async {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 10, bottom: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => SchoolListPupilsPage(
                                          schoolList,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      schoolList.listName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: interactiveColor,
                                      ),
                                    ),
                                  ),
                                  const Gap(5),
                                  Text(
                                    maxLines: 2,
                                    schoolList.listDescription,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.close, color: Colors.red[400]),
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          activeColor: Colors.red,
                                          value:
                                              (pupilListEntry.pupilListStatus ==
                                                      false)
                                                  ? true
                                                  : false,
                                          onChanged: (value) async {
                                            await schoolListLocator
                                                .patchPupilList(
                                                    pupil.internalId,
                                                    pupilLists[index]
                                                        .originList,
                                                    false,
                                                    null);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(children: [
                                    Icon(Icons.done, color: Colors.green[400]),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                        activeColor: Colors.green,
                                        value:
                                            (pupilListEntry.pupilListStatus ==
                                                    true)
                                                ? true
                                                : false,
                                        onChanged: (value) async {
                                          await schoolListLocator
                                              .patchPupilList(
                                                  pupil.internalId,
                                                  pupilLists[index].originList,
                                                  true,
                                                  null);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ]),
                                ]),
                          ]),
                      const Gap(5),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kommentar',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                              pupilLists[index].pupilListEntryBy ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ]),
                      const Gap(5),
                      Row(children: [
                        Flexible(
                          child: InkWell(
                            onTap: () async {
                              final String? comment = await longTextFieldDialog(
                                  'Kommentar',
                                  pupilListEntry.pupilListComment ??
                                      'Kommentar eintragen',
                                  context);
                              if (comment == null) {
                                return;
                              }
                              await schoolListLocator.patchPupilList(
                                  pupil.internalId,
                                  pupilLists[index].originList,
                                  null,
                                  comment);
                            },
                            child: Text(
                              pupilListEntry.pupilListComment ??
                                  'kein Kommentar',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: interactiveColor,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const Gap(10)
      ],
    );
  }
}
