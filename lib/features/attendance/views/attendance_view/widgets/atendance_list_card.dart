import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/attendance_dropdown_menu_items.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/late_in_minutes_dialog.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/multiple_entries_dialog.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/returned_time_picker.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceCard extends WatchingWidget {
  final AttendanceListController controller;
  final PupilProxy passedPupil;
  const AttendanceCard(this.controller, this.passedPupil, {super.key});
  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    final PupilProxy pupil = pupils
        .where((element) => element.internalId == passedPupil.internalId)
        .first;
    final attendanceManager = locator<AttendanceManager>();
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    String dropdownMissedValue = setMissedTypeValue(pupil.internalId, thisDate);
    bool? excusedValue = setExcusedValue(pupil.internalId, thisDate);
    String dropdownContactedValue =
        setContactedValue(pupil.internalId, thisDate);
    bool? returnedValue = setReturnedValue(pupil.internalId, thisDate);
    String? createdModifiedValue(pupilId) {
      return setCreatedModifiedValue(pupilId, thisDate);
    }

    if (Platform.isAndroid) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1.0,
          margin: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: GestureDetector(
                  onLongPress: () => createMissedClassList(context, pupil),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PupilProfile(
                        pupil,
                      ),
                    ));
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: InkWell(
                                  onTap: () {
                                    locator<BottomNavManager>()
                                        .setPupilProfileNavPage(3);
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => PupilProfile(
                                        pupil,
                                      ),
                                    ));
                                  },
                                  child: Text(
                                    '${pupil.firstName!} ${pupil.lastName!}',
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Gap(20),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                },
                                value: dropdownMissedValue,
                                items: missedTypeMenuItems,
                                onChanged: (newValue) async {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  if (dropdownMissedValue == newValue) {
                                    return;
                                  }
                                  if (newValue == 'late') {
                                    final int minutesLate =
                                        await minutesLateDialog(context);
                                    attendanceManager.changeLateTypeValue(
                                        pupil.internalId,
                                        newValue!,
                                        thisDate,
                                        minutesLate);
                                  } else {
                                    attendanceManager.changeMissedTypeValue(
                                        pupil.internalId, newValue!, thisDate);
                                  }
                                },
                              ),
                            ),
                            const Gap(8),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: excusedCheckColor,
                              value: excusedValue,
                              onChanged: (bool? newvalue) {
                                attendanceManager.changeExcusedValue(
                                    pupil.internalId, thisDate, newvalue!);
                              },
                            ),
                            const Gap(4),
                            (dropdownMissedValue == 'missed' &&
                                        excusedValue == true) ||
                                    dropdownContactedValue != '0' ||
                                    returnedValue == true
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_downward)),
                                        onTap: () {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                        },
                                        value: dropdownContactedValue,
                                        items: dropdownContactedMenuItems,
                                        onChanged: (newValue) {
                                          if (dropdownContactedValue ==
                                                  newValue ||
                                              excusedValue == false) {
                                            return;
                                          }
                                          attendanceManager
                                              .changeContactedValue(
                                                  pupil.internalId,
                                                  newValue!,
                                                  thisDate);
                                        }),
                                  )
                                : Container(
                                    height: 45,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                            const Gap(4),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: goneHomeColor,
                              value: returnedValue ?? false,
                              onChanged: (bool? newValue) async {
                                if (dropdownMissedValue == 'missed') {
                                  return;
                                }
                                if (newValue == true) {
                                  final String? returnedTime =
                                      await returnedDayTime(context);
                                  debug
                                      .warning('returned time : $returnedTime');
                                  if (returnedTime == null) {
                                    return;
                                  }
                                  attendanceManager.changeReturnedValue(
                                      pupil.internalId,
                                      newValue!,
                                      thisDate,
                                      returnedTime);
                                  return;
                                }
                                attendanceManager.changeReturnedValue(
                                    pupil.internalId,
                                    newValue!,
                                    thisDate,
                                    null);
                              },
                            ),
                          ],
                        ),
                        Row(children: [
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: createdModifiedValue(pupil.internalId) !=
                                      null
                                  ? Text(
                                      createdModifiedValue(pupil.internalId)!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: const BoxDecoration(
                                  color: excusedCheckColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    'U',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const Gap(18),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    'K',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const Gap(19),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: const BoxDecoration(
                                  color: homeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    'H',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                        const Gap(15),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
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
              child: GestureDetector(
                onLongPress: () => createMissedClassList(context, pupil),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PupilProfile(
                      pupil,
                    ),
                  ));
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      .setPupilProfileNavPage(3);
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (ctx) => PupilProfile(
                                      pupil,
                                    ),
                                  ));
                                },
                                child: Text(
                                  '${pupil.firstName!} ${pupil.lastName!}',
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const Gap(2),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_downward)),
                                  onTap: () {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  value: dropdownMissedValue,
                                  items: missedTypeMenuItems,
                                  onChanged: (newValue) async {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                    if (dropdownMissedValue == newValue) {
                                      return;
                                    }
                                    if (newValue == 'missed' &&
                                        returnedValue == true) {
                                      locator<NotificationManager>().showSnackBar(
                                          NotificationType.error,
                                          'Ein Kind, das abgeholt wurde, gilt nicht als fehlend für den Tag!');

                                      return;
                                    }
                                    if (newValue == 'late') {
                                      final int minutesLate =
                                          await minutesLateDialog(context);
                                      attendanceManager.changeLateTypeValue(
                                          pupil.internalId,
                                          newValue!,
                                          thisDate,
                                          minutesLate);
                                    } else {
                                      attendanceManager.changeMissedTypeValue(
                                          pupil.internalId,
                                          newValue!,
                                          thisDate);
                                    }
                                  },
                                ),
                              ),
                              //const Gap(20),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child:
                                      createdModifiedValue(pupil.internalId) !=
                                              null
                                          ? Text(
                                              createdModifiedValue(
                                                  pupil.internalId)!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Column(
                            children: [
                              const Gap(10),
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: excusedCheckColor,
                                value: excusedValue,
                                onChanged: (bool? newvalue) {
                                  attendanceManager.changeExcusedValue(
                                      pupil.internalId, thisDate, newvalue!);
                                },
                              ),
                              const Gap(8),
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: const BoxDecoration(
                                  color: excusedCheckColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    'U',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Column(children: [
                            (dropdownMissedValue == 'missed' &&
                                        excusedValue == true) ||
                                    dropdownContactedValue != '0' ||
                                    returnedValue == true
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_downward)),
                                        onTap: () {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                        },
                                        value: dropdownContactedValue,
                                        items: dropdownContactedMenuItems,
                                        onChanged: (newValue) {
                                          if (dropdownContactedValue ==
                                                  newValue ||
                                              excusedValue == false) {
                                            return;
                                          }
                                          attendanceManager
                                              .changeContactedValue(
                                                  pupil.internalId,
                                                  newValue!,
                                                  thisDate);
                                        }),
                                  )
                                : Container(
                                    height: 48,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                            const Gap(2),
                            Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'K',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                          const Gap(5),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(10),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: goneHomeColor,
                                  value: returnedValue ?? false,
                                  onChanged: (bool? newValue) async {
                                    if (newValue == true) {
                                      if (dropdownMissedValue == 'missed') {
                                        locator<NotificationManager>().showSnackBar(
                                            NotificationType.error,
                                            'Ein fehlendes Kind kann nicht abgeholt werden!');
                                        return;
                                      }
                                      final String? returnedTime =
                                          await returnedDayTime(context);
                                      debug.warning(
                                          'returned time : $returnedTime');
                                      if (returnedTime == null) {
                                        return;
                                      }
                                      attendanceManager.changeReturnedValue(
                                          pupil.internalId,
                                          newValue!,
                                          thisDate,
                                          returnedTime);
                                      return;
                                    }
                                    attendanceManager.changeReturnedValue(
                                        pupil.internalId,
                                        newValue!,
                                        thisDate,
                                        null);
                                  },
                                ),
                                const Gap(8),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                    color: homeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'H',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      const Gap(15),
                    ]),
              ),
            ),
          ],
        ),
      );
    }
  }
}
