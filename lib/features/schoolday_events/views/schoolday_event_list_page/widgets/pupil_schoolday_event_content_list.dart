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
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_reason_chips.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_type_icon.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/new_schoolday_event_page/new_schoolday_event_page.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventsContentList extends WatchingWidget {
  final PupilProxy pupil;
  const SchooldayEventsContentList({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final pupil = watch(this.pupil);
    final List<SchooldayEvent> filteredSchooldayEvents =
        locator<SchooldayEventFilterManager>().filteredSchooldayEvents(pupil);
    return Column(children: [
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
                builder: (ctx) => NewSchooldayEventPage(
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
        itemCount: filteredSchooldayEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                //- TO-DO: change schooldayEvent
              },
              onLongPress: () async {
                if (filteredSchooldayEvents[index].processed) {
                  locator<NotificationManager>().showSnackBar(
                      NotificationType.error,
                      'Ereignis wurde bereits bearbeitet!');

                  return;
                }
                bool? confirm = await confirmationDialog(
                    context, 'Ereignis löschen', 'Das Ereignis löschen?');
                if (confirm! == false) return;
                await locator<SchooldayEventManager>().deleteSchooldayEvent(
                    filteredSchooldayEvents[index].schooldayEventId);
                locator<NotificationManager>().showSnackBar(
                    NotificationType.success, 'Das Ereignis wurde gelöscht!');
              },
              child: Card(
                color: cardInCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: !filteredSchooldayEvents[index].processed
                        ? Border.all(
                            color: Colors
                                .orangeAccent, // Specify the color of the border here
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('dd.MM.yyyy')
                                              .format(
                                                  filteredSchooldayEvents[index]
                                                      .schooldayEventDate)
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Gap(5),
                                        SchooldayEventTypeIcon(
                                            category:
                                                filteredSchooldayEvents[index]
                                                    .schooldayEventType)
                                      ],
                                    ),
                                  ),
                                  const Gap(5),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 5,
                                    children: [
                                      ...schooldayEventReasonChips(
                                          filteredSchooldayEvents[index]
                                              .schooldayEventReason),
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
                                                          SchooldayEventManager>()
                                                      .patchSchooldayEvent(
                                                    schooldayEventId:
                                                        filteredSchooldayEvents[
                                                                index]
                                                            .schooldayEventId,
                                                    admonisher: admonishingUser,
                                                    processed: null,
                                                  );
                                                }
                                              },
                                              child: Text(
                                                filteredSchooldayEvents[index]
                                                    .admonishingUser,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: backgroundColor),
                                              ),
                                            )
                                          : Text(
                                              filteredSchooldayEvents[index]
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
                            if (filteredSchooldayEvents[index].processed)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final File? file =
                                          await uploadImage(context);
                                      if (file == null) return;
                                      await locator<SchooldayEventManager>()
                                          .patchSchooldayEventWithFile(
                                              file,
                                              filteredSchooldayEvents[index]
                                                  .schooldayEventId,
                                              true);
                                      locator<NotificationManager>()
                                          .showSnackBar(
                                              NotificationType.success,
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
                                      await locator<SchooldayEventManager>()
                                          .deleteSchooldayEventFile(
                                              filteredSchooldayEvents[index]
                                                  .schooldayEventId,
                                              filteredSchooldayEvents[index]
                                                  .fileUrl!,
                                              true);
                                      locator<NotificationManager>()
                                          .showSnackBar(
                                              NotificationType.success,
                                              'Dokument gelöscht!');
                                    },
                                    child: filteredSchooldayEvents[index]
                                                .processedFileUrl !=
                                            null
                                        ? DocumentImage(
                                            documentTag:
                                                '${filteredSchooldayEvents[index].processedFileUrl}',
                                            documentUrl:
                                                '${locator<EnvManager>().env.value.serverUrl}${ApiSchooldayEventService().getSchooldayEventProcessedFileUrl(filteredSchooldayEvents[index].schooldayEventId)}',
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
                                    final File? file =
                                        await uploadImage(context);
                                    if (file == null) return;
                                    await locator<SchooldayEventManager>()
                                        .patchSchooldayEventWithFile(
                                            file,
                                            filteredSchooldayEvents[index]
                                                .schooldayEventId,
                                            false);
                                    locator<NotificationManager>().showSnackBar(
                                      NotificationType.success,
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
                                    await locator<SchooldayEventManager>()
                                        .deleteSchooldayEventFile(
                                            filteredSchooldayEvents[index]
                                                .schooldayEventId,
                                            filteredSchooldayEvents[index]
                                                .fileUrl!,
                                            false);
                                    locator<NotificationManager>().showSnackBar(
                                        NotificationType.success,
                                        'Dokument gelöscht!');
                                  },
                                  child: filteredSchooldayEvents[index]
                                              .fileUrl !=
                                          null
                                      ? DocumentImage(
                                          documentTag:
                                              '${filteredSchooldayEvents[index].fileUrl}',
                                          documentUrl:
                                              '${locator<EnvManager>().env.value.serverUrl}${ApiSchooldayEventService().getSchooldayEventFileUrl(filteredSchooldayEvents[index].schooldayEventId)}',
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
                                await locator<SchooldayEventManager>()
                                    .patchSchooldayEvent(
                                        schooldayEventId:
                                            filteredSchooldayEvents[index]
                                                .schooldayEventId,
                                        processed: true);
                                locator<NotificationManager>().showSnackBar(
                                    NotificationType.success,
                                    'Ereignis als bearbeitet markiert!');
                              },
                              onLongPress: () async {
                                bool? confirm = await confirmationDialog(
                                    context,
                                    'Ereignis unbearbeitet?',
                                    'Ereignis als unbearbeitet markieren?');
                                if (confirm! == false) return;
                                await locator<SchooldayEventManager>()
                                    .patchSchooldayEvent(
                                  schooldayEventId:
                                      filteredSchooldayEvents[index]
                                          .schooldayEventId,
                                  processed: false,
                                  processedBy: 'none',
                                );
                              },
                              child: Text(
                                  filteredSchooldayEvents[index].processed
                                      ? 'Bearbeitet von'
                                      : 'Nicht bearbeitet',
                                  style: const TextStyle(
                                      fontSize: 16, color: backgroundColor)),
                            ),
                            const Gap(10),
                            if (filteredSchooldayEvents[index].processedBy !=
                                null)
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
                                          await locator<SchooldayEventManager>()
                                              .patchSchooldayEvent(
                                            schooldayEventId:
                                                filteredSchooldayEvents[index]
                                                    .schooldayEventId,
                                            processedBy: processingUser,
                                          );
                                        }
                                      },
                                      child: Text(
                                        filteredSchooldayEvents[index]
                                            .processedBy!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: interactiveColor),
                                      ),
                                    )
                                  : Text(
                                      filteredSchooldayEvents[index]
                                          .processedBy!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                            if (filteredSchooldayEvents[index].processedAt !=
                                null)
                              const Gap(10),
                            if (filteredSchooldayEvents[index].processedAt !=
                                null)
                              locator<SessionManager>().isAdmin.value
                                  ? InkWell(
                                      onTap: () async {
                                        final DateTime? newDate =
                                            await selectDate(
                                                context, DateTime.now());

                                        if (newDate != null) {
                                          await locator<SchooldayEventManager>()
                                              .patchSchooldayEvent(
                                                  schooldayEventId:
                                                      filteredSchooldayEvents[
                                                              index]
                                                          .schooldayEventId,
                                                  processedAt: newDate);
                                        }
                                      },
                                      child: Text(
                                        'am ${filteredSchooldayEvents[index].processedAt!.formatForUser()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: interactiveColor),
                                      ),
                                    )
                                  : Text(
                                      'am ${filteredSchooldayEvents[index].processedAt!.formatForUser()}',
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
    ]);
  }
}
