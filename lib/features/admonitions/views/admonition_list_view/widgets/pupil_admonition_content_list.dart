import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_reason_chips.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_type_icon.dart';
import 'package:schuldaten_hub/features/admonitions/views/new_admonition_view/new_admonition_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_filter_manager.dart';

List<Widget> pupilAdmonitionsContentList(
  Pupil pupil,
  BuildContext context,
) {
  final List<Admonition> filteredAdmonitions =
      locator<AdmonitionFilterManager>().filteredAdmonitions(pupil);
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: actionButtonStyle,
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewAdmonitionView(
                pupilId: pupil.internalId,
              ),
            ));
          },
          child: const Text(
            "NEUES EREIGNIS",
            style: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
    ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredAdmonitions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: GestureDetector(
            onTap: () {
              //- TO-DO: change admonition
            },
            onLongPress: () async {
              bool? confirm = await confirmationDialog(
                  context, 'Ereignis löschen', 'Das Ereignis löschen?');
              if (confirm! == false) return;
              await locator<AdmonitionManager>()
                  .deleteAdmonition(filteredAdmonitions[index].admonitionId);
              if (context.mounted) {
                snackbarSuccess(context, 'Das Ereignis wurde gelöscht!');
              }
            },
            child: Card(
              color: cardInCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd.MM.yyyy')
                                          .format(filteredAdmonitions[index]
                                              .admonishedDay)
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Gap(5),
                                    admonitionTypeIcon(
                                        filteredAdmonitions[index]
                                            .admonitionType)
                                  ],
                                ),
                              ),
                              const Gap(5),
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 5,
                                children: [
                                  ...admonitionReasonChip(
                                      filteredAdmonitions[index]
                                          .admonitionReason),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  const Text('Erstellt von:',
                                      style: TextStyle(fontSize: 16)),
                                  const Gap(5),
                                  locator<SessionManager>().isAdmin.value
                                      ? InkWell(
                                          onTap: () async {
                                            final String? admonishingUser =
                                                await shortTextfieldDialog(
                                                    context,
                                                    'Erstellt von:',
                                                    'Kürzel eingeben');
                                            if (admonishingUser != null) {
                                              await locator<AdmonitionManager>()
                                                  .patchAdmonition(
                                                      filteredAdmonitions[index]
                                                          .admonitionId,
                                                      admonishingUser,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null);
                                            }
                                          },
                                          child: Text(
                                            filteredAdmonitions[index]
                                                .admonishingUser,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: backgroundColor),
                                          ),
                                        )
                                      : Text(
                                          filteredAdmonitions[index]
                                              .admonishingUser,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                  const Gap(10),
                                ],
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                final File? file = await uploadImage(context);
                                if (file == null) return;
                                await locator<AdmonitionManager>()
                                    .postAdmonitionFile(
                                  file,
                                  filteredAdmonitions[index].admonitionId,
                                );
                                if (context.mounted) {
                                  snackbarSuccess(context, 'Vorfall geändert!');
                                }
                              },
                              onLongPress: () async {
                                bool? confirm = await confirmationDialog(
                                    context,
                                    'Dokument löschen',
                                    'Dokument löschen?');
                                if (confirm == null || confirm == false) {
                                  return;
                                }
                                await locator<AdmonitionManager>()
                                    .deleteAdmonitionFile(
                                        filteredAdmonitions[index].admonitionId,
                                        filteredAdmonitions[index].fileUrl!);
                                if (context.mounted) {
                                  snackbarSuccess(context, 'Vorfall geändert!');
                                }
                              },
                              child: filteredAdmonitions[index].fileUrl != null
                                  ? documentImage(
                                      '${locator<EnvManager>().env.value.serverUrl}${EndpointsAdmonition().getAdmonitionFile(filteredAdmonitions[index].admonitionId)}',
                                      filteredAdmonitions[index].fileUrl,
                                      70)
                                  : SizedBox(
                                      height: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                            'assets/document_camera.png'),
                                      ),
                                    ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            bool? confirm = await confirmationDialog(
                                context,
                                'Ereignis bearbeitet?',
                                'Ereignis als bearbeitet markieren?');
                            if (confirm! == false) return;
                            await locator<AdmonitionManager>()
                                .patchAdmonitionAsProcessed(
                                    filteredAdmonitions[index].admonitionId,
                                    true);
                            if (context.mounted) {
                              snackbarSuccess(context, 'Ereignis markiert');
                            }
                          },
                          onLongPress: () async {
                            bool? confirm = await confirmationDialog(
                                context,
                                'Ereignis unbearbeitet?',
                                'Ereignis als unbearbeitet markieren?');
                            if (confirm! == false) return;
                            await locator<AdmonitionManager>()
                                .patchAdmonitionAsProcessed(
                                    filteredAdmonitions[index].admonitionId,
                                    false);
                          },
                          child: Text(
                              !filteredAdmonitions[index].processed
                                  ? 'Nicht bearbeitet'
                                  : 'Bearbeitet von',
                              style: const TextStyle(
                                  fontSize: 16, color: backgroundColor)),
                        ),
                        const Gap(10),
                        if (filteredAdmonitions[index].processedBy != null)
                          locator<SessionManager>().isAdmin.value
                              ? InkWell(
                                  onTap: () async {
                                    final String? processingUser =
                                        await shortTextfieldDialog(
                                            context,
                                            'Bearbeitet von:',
                                            'Kürzel eingeben');
                                    if (processingUser != null) {
                                      await locator<AdmonitionManager>()
                                          .patchAdmonition(
                                              filteredAdmonitions[index]
                                                  .admonitionId,
                                              null,
                                              null,
                                              null,
                                              null,
                                              processingUser,
                                              null);
                                    }
                                  },
                                  child: Text(
                                    filteredAdmonitions[index].processedBy!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: interactiveColor),
                                  ),
                                )
                              : Text(
                                  filteredAdmonitions[index].processedBy!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        if (filteredAdmonitions[index].processedAt != null)
                          const Gap(10),
                        if (filteredAdmonitions[index].processedAt != null)
                          locator<SessionManager>().isAdmin.value
                              ? InkWell(
                                  onTap: () async {
                                    final DateTime newDate = await selectDate(
                                        context, DateTime.now());

                                    if (newDate != null) {
                                      await locator<AdmonitionManager>()
                                          .patchAdmonition(
                                              filteredAdmonitions[index]
                                                  .admonitionId,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              newDate);
                                    }
                                  },
                                  child: Text(
                                    'am ${filteredAdmonitions[index].processedAt!.formatForUser()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: interactiveColor),
                                  ),
                                )
                              : Text(
                                  'am ${filteredAdmonitions[index].processedAt!.formatForUser()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ];
}
