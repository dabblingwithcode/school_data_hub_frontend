import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

double boxHeight = 35;
Widget pupilProfileNavigation(PupilProfileController controller,
    int pupilProfileNavState, double passedBoxWidth) {
  double boxWidth = passedBoxWidth / 5;
  return Theme(
    data: Theme.of(controller.context).copyWith(
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
                      backgroundColor: controller.navigationBackgroundColor(0),
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
                          side: BorderSide(color: backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(1),
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
                          side: BorderSide(color: backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(2),
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
                          side: BorderSide(color: backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(3),
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
                      backgroundColor: controller.navigationBackgroundColor(4),
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
                      backgroundColor: controller.navigationBackgroundColor(5),
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
                        backgroundColor:
                            controller.navigationBackgroundColor(6)),
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
                        backgroundColor:
                            controller.navigationBackgroundColor(7)),
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
                        backgroundColor:
                            controller.navigationBackgroundColor(8)),
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
                        backgroundColor:
                            controller.navigationBackgroundColor(9)),
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

  // return SegmentedButton(segments: [
  //   ButtonSegment(
  //     value: 1,
  //     label: Text(
  //       'Info',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 2,
  //     label: Text(
  //       'Sprache',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 3,
  //     label: Text(
  //       'Guthaben',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 4,
  //     label: Text(
  //       'Vorfälle',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 5,
  //     label: Text(
  //       'Fehlzeiten',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  // ], selected: const {
  //   2
  // });
}
