import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';
import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';
import 'package:schuldaten_hub/features/workbooks/pages/new_workbook_page/new_workbook_page.dart';

class WorkbookCard extends StatelessWidget {
  const WorkbookCard({required this.workbook, super.key});
  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            // onTap: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (ctx) => SchoolListPupils(
            //       workbook,
            //     ),
            //   ));
            // },
            onLongPress: () async {
              if (!locator<SessionManager>().isAdmin.value) {
                informationDialog(context, 'Keine Berechtigung',
                    'Arbeitshefte können nur von Admins bearbeitet werden!');
                return;
              }
              final bool? result = await confirmationDialog(
                  context,
                  'Arbeitsheft löschen',
                  'Arbeitsheft "${workbook.name}" wirklich löschen? ACHTUNG: Alle Arbeitshefte dieser Art werden ebenfalls gelöscht!');
              if (result == true) {
                await locator<WorkbookManager>().deleteWorkbook(workbook.isbn);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5),
              child: Row(
                children: [
                  const Gap(15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(10),
                      InkWell(
                        onTap: () async {
                          final File? file = await uploadImage(context);
                          if (file == null) return;
                          await locator<WorkbookManager>()
                              .postWorkbookFile(file, workbook.isbn);
                        },
                        onLongPress: (workbook.imageUrl == null)
                            ? () {}
                            : () async {
                                if (workbook.imageUrl == null) {
                                  return;
                                }
                                final bool? result = await confirmationDialog(
                                    context, 'Bild löschen', 'Bild löschen?');
                                if (result != true) return;
                                await locator<WorkbookManager>()
                                    .deleteWorkbookFile(workbook.isbn);
                              },
                        child: workbook.imageUrl != null
                            ? Provider<DocumentImageData>.value(
                                updateShouldNotify: (oldValue, newValue) =>
                                    oldValue.documentUrl !=
                                    newValue.documentUrl,
                                value: DocumentImageData(
                                    documentTag:
                                        workbook.imageUrl!.split('/').last,
                                    documentUrl:
                                        '${locator<EnvManager>().env.value.serverUrl}${ApiWorkbookService().getWorkbookImage(workbook.isbn)}',
                                    size: 140),
                                child: const DocumentImage(),
                              )
                            : SizedBox(
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child:
                                      Image.asset('assets/document_camera.png'),
                                ),
                              ),
                      ),
                      const Gap(10),
                    ],
                  ),
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
                                child: InkWell(
                                  onLongPress: (locator<SessionManager>()
                                          .isAdmin
                                          .value)
                                      ? () async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (ctx) => NewWorkbookPage(
                                                workbook.name,
                                                workbook.isbn,
                                                workbook.subject,
                                                workbook.level),
                                          ));
                                        }
                                      : () {},
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      workbook.name!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text('ISBN:'),
                              const Gap(10),
                              Text(
                                workbook.isbn.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text('Kompetenzbereich(e):'),
                              const Gap(10),
                              Text(
                                workbook.subject!,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text('Kompetenzstufe:'),
                              const Gap(10),
                              Text(
                                workbook.level!,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text('Bestand:'),
                              const Gap(10),
                              Text(
                                workbook.amount.toString(),
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
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
