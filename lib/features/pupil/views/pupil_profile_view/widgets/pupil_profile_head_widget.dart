import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_set_avatar.dart';

part 'pupil_profile_head_widget.g.dart';

@swidget
Widget pupilProfileHeadWidget(
    Pupil pupil, BuildContext context, PupilProfileController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          GestureDetector(
            onLongPressStart: (details) {
              final offset = details.globalPosition;
              final position = RelativeRect.fromLTRB(
                  offset.dx, offset.dy, offset.dx, offset.dy);
              showMenu(
                context: context,
                position: position,
                items: [
                  PopupMenuItem(
                    child: pupil.avatarUrl == null
                        ? const Text('Foto hochladen')
                        : const Text('Foto ersetzen'),
                    onTap: () => setAvatar(context, pupil),
                  ),
                  if (pupil.avatarUrl != null)
                    PopupMenuItem(
                      child: const Text('Foto löschen'),
                      onTap: () async {
                        await controller.deleteAvatar();
                      },
                    ),
                ],
              );
            },
            child: AvatarWithBadges(pupil: pupil, size: 100),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(10),
            Row(
              children: [
                Align(
                  child: Text(
                    '${pupil.firstName}',
                    //textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${pupil.lastName} ',
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'FE  ${pupil.individualDevelopmentPlan}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                const Gap(15),
                pupil.specialNeeds != null
                    ? Text(
                        '${pupil.schoolyear}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: schoolyearColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      )
                    : const SizedBox.shrink(),
                const Gap(15),
                if (pupil.specialInformation != null)
                  const Icon(
                    Icons.warning_rounded,
                    color: Colors.red,
                  ),
                if (locator<SessionManager>().isAdmin.value ==
                    true) ...<Widget>[
                  const Gap(10),
                  Text(
                    '${pupil.internalId}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )
                ]
              ],
            ),
            const Gap(2),
            Row(
              children: [
                const Icon(Icons.attach_money),
                const Gap(5),
                Text(
                  pupil.credit.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              ],
            ),
          ],
        ),
      )
    ],
  );
}
