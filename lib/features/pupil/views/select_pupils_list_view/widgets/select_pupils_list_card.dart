import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';
import 'package:watch_it/watch_it.dart';

class SelectPupilListCard extends WatchingWidget {
  final SelectPupilListController controller;
  final PupilProxy passedPupil;

  const SelectPupilListCard(this.controller, this.passedPupil, {super.key});
  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    final PupilProxy pupil = pupils
        .where((element) => element.internalId == passedPupil.internalId)
        .first;

    return GestureDetector(
      onLongPress: () => controller.onCardPress(pupil.internalId),
      onTap: () => controller.isSelectMode
          ? controller.onCardPress(pupil.internalId)
          : {},
      child: Card(
          color: controller.selectedPupilIds.contains(pupil.internalId)
              ? const Color.fromARGB(255, 197, 212, 255)
              : Colors.white,
          child: Row(
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PupilProfile(
                      pupil,
                    ),
                  ));
                },
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '${pupil.firstName!} ${pupil.lastName!}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Gap(5),
                      // Row(
                      //   children: [
                      //     Text('bisjetzt verdient:'),
                      //     Gap(10),
                      //     Text(
                      //       pupil.creditEarned.toString(),
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
