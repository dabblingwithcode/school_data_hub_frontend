import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/controller/authorization_pupils_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

List<Widget> pupilAuthorizationsContentList(PupilProxy pupil) {
  final authorizationLocator = locator<AuthorizationManager>();
  return [
    ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pupil.authorizations!.length,
      itemBuilder: (BuildContext context, int index) {
        final Authorization authorization = authorizationLocator
            .getAuthorization(pupil.authorizations![index].originAuthorization);
        final PupilAuthorization pupilAuthorization =
            authorizationLocator.getPupilAuthorization(pupil.internalId,
                pupil.authorizations![index].originAuthorization);
        return GestureDetector(
            onTap: () {},
            onLongPress: () async {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) => AuthorizationPupils(
                                            authorization,
                                          ),
                                        ));
                                      },
                                      child: Row(children: [
                                        (Text(authorization.authorizationName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: interactiveColor))),
                                      ]),
                                    ),
                                    const Gap(5),
                                    Row(children: [
                                      Flexible(
                                        child: Text(
                                          authorization
                                              .authorizationDescription,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      const Gap(5),
                                    ]),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final File? file =
                                          await uploadImage(context);
                                      if (file == null) return;
                                      await locator<AuthorizationManager>()
                                          .postAuthorizationFile(
                                              file,
                                              pupil.internalId,
                                              authorization.authorizationId);
                                      locator<NotificationManager>().showSnackBar(
                                          NotificationType.success,
                                          'Die Einwilligung wurde geändert!');
                                    },
                                    onLongPress: (pupilAuthorization.fileUrl ==
                                            null)
                                        ? () {}
                                        : () async {
                                            if (pupilAuthorization.fileUrl ==
                                                null) return;
                                            final bool? result =
                                                await confirmationDialog(
                                                    context,
                                                    'Dokument löschen',
                                                    'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
                                            if (result != true) return;
                                            await locator<
                                                    AuthorizationManager>()
                                                .deleteAuthorizationFile(
                                              pupil.internalId,
                                              authorization.authorizationId,
                                              pupilAuthorization.fileUrl!,
                                            );
                                            locator<NotificationManager>()
                                                .showSnackBar(
                                                    NotificationType.success,
                                                    'Die Einwilligung wurde geändert!');
                                          },
                                    child: pupilAuthorization.fileUrl != null
                                        ? DocumentImage(
                                            documentTag:
                                                '${locator<EnvManager>().env.value.serverUrl}${EndpointsAuthorization().getPupilAuthorizationFile(pupil.internalId, authorization.authorizationId)}',
                                            documentUrl:
                                                pupilAuthorization.fileUrl,
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
                            ],
                          ),
                          const Gap(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Kommentar',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                //- TO-DO BACKEND: model needs a modifedBy field
                                // if (pupilAuthorization.createdBy != null)
                                //   Text(pupilAuthorization.createdBy!,
                                //       style: const TextStyle(
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.bold,
                                //       )),
                                const Gap(5),
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Checkbox(
                                    activeColor: Colors.red,
                                    value: (pupilAuthorization.status == null ||
                                            pupilAuthorization.status == true)
                                        ? false
                                        : true,
                                    onChanged: (value) async {
                                      await authorizationLocator
                                          .patchPupilAuthorization(
                                              pupil.internalId,
                                              pupil.authorizations![index]
                                                  .originAuthorization,
                                              false,
                                              null);
                                    },
                                  ),
                                ),
                                const Gap(10),
                                const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    value: pupilAuthorization.status ?? false,
                                    onChanged: (value) async {
                                      await authorizationLocator
                                          .patchPupilAuthorization(
                                              pupil.internalId,
                                              pupil.authorizations![index]
                                                  .originAuthorization,
                                              value,
                                              null);
                                    },
                                  ),
                                ),
                              ]),
                          const Gap(5),
                          Row(children: [
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  final String? comment =
                                      await longTextFieldDialog(
                                          'Kommentar',
                                          pupilAuthorization.comment ??
                                              'Kommentar eintragen',
                                          context);
                                  if (comment == null) {
                                    return;
                                  }
                                  await locator<AuthorizationManager>()
                                      .patchPupilAuthorization(
                                          pupil.internalId,
                                          pupilAuthorization
                                              .originAuthorization,
                                          null,
                                          comment);
                                },
                                child: Text(
                                  pupilAuthorization.comment ??
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
                          const Gap(5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    ),
  ];
}
