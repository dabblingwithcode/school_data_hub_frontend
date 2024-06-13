import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/pages/pupil_profile_page/pupil_profile_page.dart';
import 'package:watch_it/watch_it.dart';

typedef OnCardPressCallback = void Function(int id);

class SelectPupilListCard extends WatchingWidget {
  final PupilProxy passedPupil;
  final OnCardPressCallback onCardPress;
  final bool isSelectMode;
  final bool isSelected;
  const SelectPupilListCard(
      {required this.passedPupil,
      required this.onCardPress,
      required this.isSelectMode,
      required this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return GestureDetector(
      onLongPress: () => onCardPress(pupil.internalId),
      onTap: () => isSelectMode ? onCardPress(pupil.internalId) : {},
      child: Card(
          color: isSelected
              ? const Color.fromARGB(255, 197, 212, 255)
              : Colors.white,
          child: Row(
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PupilProfilePage(
                      pupil: pupil,
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
                                '${pupil.firstName} ${pupil.lastName}',
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
