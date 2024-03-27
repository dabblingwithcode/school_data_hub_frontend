import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';

List<Widget> pupilInfosContentList(Pupil pupil, BuildContext context) {
  List<Pupil> pupilSiblings = siblings(pupil);
  return [
    const Row(
      children: [
        Text('Besondere Infos:', style: TextStyle(fontSize: 18.0)),
        Gap(5),
      ],
    ),
    const Gap(5),
    InkWell(
      onTap: () async {
        final String? specialInformation = await longTextFieldDialog(
            'Besondere Infos', pupil.specialInformation, context);
        if (specialInformation == null) return;
        await locator<PupilManager>().patchPupil(
            pupil.internalId, 'special_information', specialInformation);
      },
      onLongPress: () async {
        if (pupil.specialInformation == null) return;
        final bool? confirm = await confirmationDialog(
            context,
            'Besondere Infos löschen',
            'Besondere Informationen für dieses Kind löschen?');
        if (confirm == false || confirm == null) return;
        await locator<PupilManager>()
            .patchPupil(pupil.internalId, 'special_information', null);
      },
      child: Row(
        children: [
          Flexible(
            child: pupil.specialInformation != null
                ? Text(pupil.specialInformation!,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor))
                : const Text(
                    'keine Informationen',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Geschlecht:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        Text(pupil.gender! == 'm' ? 'männlich' : 'weiblich',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Geburtsdatum:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        Text(pupil.birthday!.formatForUser(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Aufnahmedatum:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        Text(pupil.pupilSince!.formatForUser(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    ),
    const Gap(10),
    pupilSiblings.isNotEmpty
        ? const Row(
            children: [
              Text(
                'Geschwister:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          )
        : const SizedBox.shrink(),
    pupilSiblings.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupilSiblings.length,
            itemBuilder: (context, int index) {
              Pupil sibling = pupilSiblings[index];
              return Column(
                children: [
                  const Gap(5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PupilProfile(
                          sibling,
                        ),
                      ));
                    },
                    child: Row(
                      children: [
                        avatarImage(sibling, 30),
                        const Gap(10),
                        Text(
                          sibling.firstName!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        Text(
                          sibling.lastName!,
                          style: const TextStyle(),
                        ),
                        const Gap(20),
                        Text(
                          sibling.group!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: groupColor),
                        ),
                        const Gap(20),
                        Text(
                          sibling.schoolyear!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: schoolyearColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })
        : const SizedBox.shrink(),
  ];
}
