import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/landing_bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/ogs/widgets/dialogs/ogs_pickup_time_dialog.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/pages/pupil_profile_page/pupil_profile_page.dart';

import 'package:watch_it/watch_it.dart';

class OgsCard extends WatchingWidget {
  final PupilProxy pupil;
  const OgsCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    final pupil = watch<PupilProxy>(this.pupil);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarWithBadges(pupil: pupil, size: 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: InkWell(
                                    onTap: () {
                                      locator<BottomNavManager>()
                                          .setPupilProfileNavPage(5);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => PupilProfilePage(
                                          pupil: pupil,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      '${pupil.firstName} ${pupil.lastName}',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(25),
                          const Row(
                            children: [
                              Text('Ogs Infos:'),
                              Gap(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //const Gap(20),
                          const Text('Abholzeit:'),
                          Center(
                            child: InkWell(
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
                          ),
                          const Text('Uhr'),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
