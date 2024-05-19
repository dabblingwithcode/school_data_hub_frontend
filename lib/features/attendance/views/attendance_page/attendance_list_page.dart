import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/widgets/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_page/widgets/atendance_list_card.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_page/widgets/attendance_list_search_bar.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_page/widgets/attendance_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceListPage extends WatchingStatefulWidget {
  const AttendanceListPage({Key? key}) : super(key: key);
  @override
  State<AttendanceListPage> createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    locator<AttendanceManager>().fetchMissedClassesOnASchoolday(
        locator<SchooldayManager>().thisDate.value);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      locator<AttendanceManager>().fetchMissedClassesOnASchoolday(
          locator<SchooldayManager>().thisDate.value);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<PupilProxy> pupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: InkWell(
          onTap: () async => setThisDate(context, thisDate),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.today_rounded,
                color: schooldayIsToday(thisDate)
                    ? const Color.fromARGB(255, 83, 196, 55)
                    : Colors.white,
                size: 30,
              ),
              const Gap(10),
              Text(
                thisDateAsString(context, thisDate),
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<AttendanceManager>()
            .fetchMissedClassesOnASchoolday(thisDate),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverSearchAppBar(
                    height: 110,
                    title: AttendanceListSearchBar(
                        pupils: pupils,
                        thisDate: thisDate,
                        filtersOn: filtersOn)),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => AttendanceCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AttendanceListPageBottomNavBar(
          filtersOn: filtersOn, thisDate: thisDate),
    );
  }
}
