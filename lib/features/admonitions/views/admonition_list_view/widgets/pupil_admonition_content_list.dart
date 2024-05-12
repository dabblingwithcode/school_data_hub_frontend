import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_reason_chips.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_type_icon.dart';
import 'package:schuldaten_hub/features/admonitions/views/new_admonition_view/new_admonition_view.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

List<Widget> pupilAdmonitionsContentList(
  PupilProxy pupil,
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
              if (filteredAdmonitions[index].processed) {
                locator<SnackBarManager>().showSnackBar(
                    SnackBarType.error, 'Ereignis wurde bereits bearbeitet!');

                return;
              }
              bool? confirm = await confirmationDialog(
                  context, 'Ereignis löschen', 'Das Ereignis löschen?');
              if (confirm! == false) return;
              await locator<AdmonitionManager>()
                  .deleteAdmonition(filteredAdmonitions[index].admonitionId);
              locator<SnackBarManager>().showSnackBar(
                  SnackBarType.success, 'Das Ereignis wurde gelöscht!');
            },
            child: Card(
              color: cardInCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: filteredAdmonitions[index].processed
                      ? Border.all(
                          color: Colors
                              .green, // Specify the color of the border here
                          width: 3, // Specify the width of the border here
                        )
                      : null,
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
                                                      context: context,
                                                      title: 'Erstellt von:',
                                                      labelText:
                                                          'Kürzel eingeben',
                                                      hintText:
                                                          'Kürzel eingeben',
                                                      obscureText: false);
                                              if (admonishingUser != null) {
                                                await locator<
                                                        AdmonitionManager>()
                                                    .patchAdmonition(
                                                        filteredAdmonitions[
                                                                index]
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
                          //- Image for event processing description
                          if (filteredAdmonitions[index].fileUrl != null)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final File? file =
                                        await uploadImage(context);
                                    if (file == null) return;
                                    await locator<AdmonitionManager>()
                                        .postAdmonitionFile(
                                            file,
                                            filteredAdmonitions[index]
                                                .admonitionId,
                                            true);
                                    locator<SnackBarManager>().showSnackBar(
                                        SnackBarType.success,
                                        'Vorfall geändert!');
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
                                            filteredAdmonitions[index]
                                                .admonitionId,
                                            filteredAdmonitions[index].fileUrl!,
                                            true);
                                    locator<SnackBarManager>().showSnackBar(
                                        SnackBarType.success,
                                        'Dokument gelöscht!');
                                  },
                                  child: filteredAdmonitions[index]
                                              .processedFileUrl !=
                                          null
                                      ? DocumentImage(
                                          documentTag:
                                              '${locator<EnvManager>().env.value.serverUrl}${EndpointsAdmonition().getAdmonitionFile(filteredAdmonitions[index].admonitionId)}',
                                          documentUrl:
                                              filteredAdmonitions[index]
                                                  .fileUrl,
                                          size: 70)
                                      : SizedBox(
                                          height: 70,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.asset(
                                                'assets/document_camera.png'),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          const Gap(10),
                          //- Image for Event description
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
                                          filteredAdmonitions[index]
                                              .admonitionId,
                                          false);
                                  locator<SnackBarManager>().showSnackBar(
                                    SnackBarType.success,
                                    'Ereignis gespeichert!',
                                  );
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
                                          filteredAdmonitions[index]
                                              .admonitionId,
                                          filteredAdmonitions[index].fileUrl!,
                                          false);
                                  locator<SnackBarManager>().showSnackBar(
                                      SnackBarType.success,
                                      'Dokument gelöscht!');
                                },
                                child: filteredAdmonitions[index].fileUrl !=
                                        null
                                    ? DocumentImage(
                                        documentTag:
                                            '${locator<EnvManager>().env.value.serverUrl}${EndpointsAdmonition().getAdmonitionFile(filteredAdmonitions[index].admonitionId)}',
                                        documentUrl:
                                            filteredAdmonitions[index].fileUrl,
                                        size: 70)
                                    : SizedBox(
                                        height: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                              locator<SnackBarManager>().showSnackBar(
                                  SnackBarType.success,
                                  'Ereignis als bearbeitet markiert!');
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
                                              context: context,
                                              title: 'Bearbeitet von:',
                                              labelText: 'Kürzel eingeben',
                                              hintText: 'Kürzel eingeben',
                                              obscureText: false);
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
          ),
        );
      },
    ),
  ];
}
