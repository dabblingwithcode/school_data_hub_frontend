import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/ogs/widgets/dialogs/ogs_pickup_time_dialog.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilOgsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilOgsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(
              Icons.lightbulb,
              color: accentColor,
              size: 24,
            ),
            Gap(5),
            Text('OGS-Informationen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor,
                ))
          ]),
          const Gap(15),
          Row(
            children: [
              const Text('Notbetreuungsberechtigt: '),
              const Gap(5),
              InkWell(
                onTap: () async {
                  final bool? confirm = await confirmationDialog(
                      context,
                      'Notbetreuungsberechtigung ändern',
                      'Notbetreuungsberechtigung für dieses Kind ändern?');
                  if (confirm == false || confirm == null) return;
                  await locator<PupilManager>().patchPupil(
                      pupil.internalId,
                      'emergency_care',
                      pupil.emergencyCare == true ? 'false' : 'true');
                },
                child: Text(
                  pupil.emergencyCare == true ? 'Ja' : 'Nein',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
          if (pupil.ogs == false)
            const Row(
              children: [
                Gap(25),
                Text(
                  'Nicht angemeldet.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: backgroundColor,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    const Gap(25),
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          final String? ogsInfo = await longTextFieldDialog(
                              'OGS Informationen', pupil.ogsInfo, context);
                          if (ogsInfo == null) return;
                          await locator<PupilManager>().patchPupil(
                              pupil.internalId, 'ogs_info', ogsInfo);
                        },
                        onLongPress: () async {
                          if (pupil.ogsInfo == null) return;
                          final bool? confirm = await confirmationDialog(
                              context,
                              'OGS Infos löschen',
                              'OGS Informationen für dieses Kind löschen?');
                          if (confirm == false || confirm == null) return;
                          await locator<PupilManager>()
                              .patchPupil(pupil.internalId, 'ogs_info', null);
                        },
                        child: Text(
                          pupil.ogsInfo == null || pupil.ogsInfo!.isEmpty
                              ? 'keine Infos'
                              : pupil.ogsInfo!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Row(
                  children: [
                    const Gap(25),
                    Row(
                      children: [
                        const Text('Abholzeit:'),
                        const Gap(5),
                        InkWell(
                          onTap: () => pickUpTimeDialog(
                              context, pupil, pupil.pickUpTime),
                          child: Text(
                            pickUpValue(pupil.pickUpTime),
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: backgroundColor),
                          ),
                        ),
                        const Gap(5),
                        const Text('Uhr'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
        ]),
      ),
    );
  }
}
