import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/common/widgets/custom_list_tiles.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_stats_pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/pupil_profile_page.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_attendance_content.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

import 'package:watch_it/watch_it.dart';

class AttendanceRankingListCard extends WatchingStatefulWidget {
  final PupilProxy pupil;
  const AttendanceRankingListCard(this.pupil, {super.key});

  @override
  State<AttendanceRankingListCard> createState() =>
      _AttendanceRankingListCardState();
}

class _AttendanceRankingListCardState extends State<AttendanceRankingListCard> {
  late CustomExpansionTileController _tileController;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = watch(widget.pupil);
    final List<int> missedHoursForActualReport =
        locator<AttendanceManager>().missedHoursforSemesterOrSchoolyear(pupil);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: InkWell(
                                  onTap: () {
                                    locator<BottomNavManager>()
                                        .setPupilProfileNavPage(3);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PupilProfilePage(pupil: pupil),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '${pupil.firstName} ${pupil.lastName}',
                                    overflow: TextOverflow.ellipsis,
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
                            const Spacer(),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  _tileController.isExpanded
                                      ? _tileController.collapse()
                                      : _tileController.expand();
                                },
                                child: attendanceStats(pupil)),
                            const Gap(20),
                          ],
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Fehlstunden:',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          ' ${missedHoursForActualReport[0].toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(5),
                        const Text(
                          'davon unent:',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          ' ${missedHoursForActualReport[1].toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(15),
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ],
          ),
          CustomListTiles(
              title: null,
              tileController: _tileController,
              widgetList: pupilAttendanceContentList(pupil, context)),
        ],
      ),
    );
  }
}
