import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/landing_bottom_nav_bar.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileNavigation extends WatchingStatefulWidget {
  final double boxWidth;
  const PupilProfileNavigation({required this.boxWidth, super.key});

  @override
  State<PupilProfileNavigation> createState() => _PupilProfileNavigationState();
}

class _PupilProfileNavigationState extends State<PupilProfileNavigation> {
  // final CustomExpansionTileController infoTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController languageTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController creditTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController attendanceTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController schooldayEventTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController ogsTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController learningSupportTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController learningTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController pupilSchoolListTileController =
  //     CustomExpansionTileController();
  // final CustomExpansionTileController pupilAuthoritationTileController =
  //     CustomExpansionTileController();

  Color navigationBackgroundColor(int page) {
    return page == locator<BottomNavManager>().pupilProfileNavState.value
        ? Colors.white
        : backgroundColor;
  }

  Color navigationBackgroundActive = accentColor;
  Color navigationIconInactive = Colors.white;
  Color navigationIconActive = Colors.white;

  // void expandTile(int tile) {
  //   List<CustomExpansionTileController> tileControllers = [
  //     infoTileController,
  //     languageTileController,
  //     creditTileController,
  //     attendanceTileController,
  //     schooldayEventTileController,
  //     ogsTileController,
  //     learningSupportTileController,
  //     learningTileController,
  //     pupilSchoolListTileController,
  //     pupilAuthoritationTileController
  //   ];

  //   for (int i = 0; i < tileControllers.length; i++) {
  //     if (i == tile) {
  //       tileControllers[i].isExpanded
  //           ? tileControllers[i].collapse()
  //           : tileControllers[i].expand();
  //       continue;
  //     }
  //     tileControllers[i].collapse();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final int pupilProfileNavState =
        watchValue((BottomNavManager x) => x.pupilProfileNavState);
    //double boxHeight = 35;
    return Theme(
      data: Theme.of(context).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ))),
      child: Center(
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //- Information Button - top left border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: navigationBackgroundColor(0),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 0) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(0);
                      },
                      child: Icon(
                        Icons.info_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                0
                            ? backgroundColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Language Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side:
                                BorderSide(color: backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(1),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 1) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(1);
                      },
                      child: Icon(
                        Icons.language_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                1
                            ? groupColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Credit Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side:
                                BorderSide(color: backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(2),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 2) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(2);
                      },
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                2
                            ? accentColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Attendance Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side:
                                BorderSide(color: backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(3),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 3) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(3);
                      },
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                3
                            ? Colors.grey[800]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- SchooldayEvent Button - bottom right border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: navigationBackgroundColor(4),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 4) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(4);
                      },
                      child: Icon(
                        Icons.warning_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                4
                            ? accentColor
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //- OGS Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(5),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 5) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(5);
                      },
                      child: Text(
                        'OGS',
                        style: TextStyle(
                            color: locator<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    5
                                ? backgroundColor
                                : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  //- Lists Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(6)),
                      onPressed: () {
                        if (pupilProfileNavState == 6) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(6);
                      },
                      child: Icon(
                        Icons.rule,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                6
                            ? Colors.grey[600]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Authorization Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(7)),
                      onPressed: () {
                        if (pupilProfileNavState == 7) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(7);
                      },
                      child: Icon(
                        Icons.fact_check_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                7
                            ? Colors.grey[600]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Learning supporn button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(8)),
                      onPressed: () {
                        if (pupilProfileNavState == 8) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(8);
                      },
                      child: Icon(
                        Icons.support_rounded,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                8
                            ? const Color.fromARGB(255, 245, 75, 75)
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Learning Button - bottom right border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(9)),
                      onPressed: () {
                        if (pupilProfileNavState == 9) return;
                        locator<BottomNavManager>().setPupilProfileNavPage(9);
                      },
                      child: Icon(
                        Icons.lightbulb,
                        color: locator<BottomNavManager>()
                                    .pupilProfileNavState
                                    .value ==
                                9
                            ? accentColor
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
