import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_language_communication_values_widget.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/language_dialog.dart';

List<Widget> pupilLanguageContentList(PupilProxy pupil, BuildContext context) {
  return [
    Row(
      children: [
        const Text('Familiensprache:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        Text(pupil.language!,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Erstförderung:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        Text(
            pupil.migrationSupportEnds != null
                ? 'bis : ${pupil.migrationSupportEnds!.formatForUser()}'
                : 'keine',
            style:
                const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Text(
          'Deutsch - Sprachkompetenz',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Text(
          'Kind:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    ),
    const Gap(10),
    InkWell(
      onTap: () => languageDialog(
          context, pupil, 'communication_pupil', pupil.communicationPupil),
      onLongPress: () => locator<PupilManager>()
          .patchPupil(pupil.internalId, 'communication_pupil', null),
      child: pupil.communicationPupil == null
          ? const Text(
              'kein Eintrag',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor),
            )
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    InkWell(
                      child: Container(
                          child:
                              communicationValues(pupil.communicationPupil!)),
                    )
                  ],
                ),
              ),
            ),
    ),
    const Gap(10),
    const Row(
      children: [
        Text(
          'Mutter / TutorIn 1:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    ),
    const Gap(10),
    InkWell(
      onTap: () => languageDialog(
          context, pupil, 'communication_tutor1', pupil.communicationTutor1),
      onLongPress: () => locator<PupilManager>()
          .patchPupil(pupil.internalId, 'communication_tutor1', null),
      child: pupil.communicationTutor1 == null
          ? const Text(
              'kein Eintrag',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor),
            )
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    InkWell(
                      child: Container(
                          child:
                              communicationValues(pupil.communicationTutor1!)),
                    )
                  ],
                ),
              ),
            ),
    ),
    const Gap(10),
    const Row(
      children: [
        Text(
          'Vater / TutorIn 2:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    ),
    const Gap(10),
    InkWell(
      onTap: () => languageDialog(
          context, pupil, 'communication_tutor2', pupil.communicationTutor2),
      onLongPress: () => locator<PupilManager>()
          .patchPupil(pupil.internalId, 'communication_tutor2', null),
      child: pupil.communicationTutor2 == null
          ? const Text(
              'kein Eintrag',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor),
            )
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    InkWell(
                      child: Container(
                          child:
                              communicationValues(pupil.communicationTutor2!)),
                    )
                  ],
                ),
              ),
            ),
    ),
    const Gap(10)
  ];
}
