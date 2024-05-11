import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/ogs/widgets/dialogs/ogs_pickup_time_dialog.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

List<Widget> pupilOgsContentList(PupilProxy pupil, BuildContext context) {
  return [
    Row(
      children: [
        const Text('Abholzeit:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        InkWell(
          onTap: () => pickUpTimeDialog(context, pupil, pupil.pickUpTime),
          child: Text(pickupTimePredicate(pupil.pickUpTime),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor)),
        ),
        const Gap(5),
        const Text('Uhr', style: TextStyle(fontSize: 18.0)),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Text('OGS Infos:', style: TextStyle(fontSize: 18.0)),
        Gap(5),
      ],
    ),
    const Gap(5),
    InkWell(
      onTap: () async {
        final String? ogsInfo = await longTextFieldDialog(
            'OGS Informationen', pupil.ogsInfo, context);
        if (ogsInfo == null) return;
        await locator<PupilManager>()
            .patchPupil(pupil.internalId, 'ogs_info', ogsInfo);
      },
      onLongPress: () async {
        if (pupil.ogsInfo == null) return;
        final bool? confirm = await confirmationDialog(context,
            'OGS Infos löschen', 'OGS Informationen für dieses Kind löschen?');
        if (confirm == false || confirm == null) return;
        await locator<PupilManager>()
            .patchPupil(pupil.internalId, 'ogs_info', null);
      },
      child: Row(
        children: [
          Flexible(
            child: pupil.ogsInfo != null
                ? Text(pupil.ogsInfo!,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 20,
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
  ];
}
