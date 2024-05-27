import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/common/widgets/custom_list_tiles.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/pupil_profile_page.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_credit_content.dart';

import 'package:watch_it/watch_it.dart';

class CreditListCard extends WatchingStatefulWidget {
  final PupilProxy passedPupil;
  const CreditListCard(this.passedPupil, {super.key});

  @override
  State<CreditListCard> createState() => _CreditListCardState();
}

class _CreditListCardState extends State<CreditListCard> {
  late CustomExpansionTileController _tileController;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    PupilProxy pupil = widget.passedPupil;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Column(
        children: [
          Row(
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
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                locator<BottomNavManager>()
                                    .setPupilProfileNavPage(2);
                                Navigator.of(context).push(MaterialPageRoute(
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
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text('bisjetzt verdient:'),
                                const Gap(10),
                                Text(
                                  pupil.creditEarned.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  _tileController.isExpanded
                      ? _tileController.collapse()
                      : _tileController.expand();
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Credit'),
                    Center(
                      child: Text(
                        pupil.credit.toString(),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
          CustomListTiles(
              title: null,
              tileController: _tileController,
              widgetList: pupilCreditContentList(pupil, context))
        ],
      ),
    );
  }
}
