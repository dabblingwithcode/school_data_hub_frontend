import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/models/schoolday_models/schoolday.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/pages/attendance_page/widgets/atendance_list_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class SchooldaysCalendar extends StatefulWidget {
  const SchooldaysCalendar({super.key});

  @override
  SchooldaysCalendarState createState() => SchooldaysCalendarState();
}

class SchooldaysCalendarState extends State<SchooldaysCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  List<Schoolday> schooldays = locator<SchooldayManager>().schooldays.value;

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 10, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 10, DateTime.now().day);
  List<String> _getEventsForDay(DateTime day) {
    if (schooldays.any((element) => element.schoolday == day)) {
      return ['Schule'];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<MissedClass> missedClasses =
        locator<AttendanceManager>().getMissedClassesOnADay(_selectedDay!);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        title: const Center(child: Text('Schultage', style: appBarTextStyle)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar<String>(
                selectedDayPredicate: (day) {
                  // check if the day is in schooldays
                  bool isSchoolday = schooldays
                      .any((element) => element.schoolday.isSameDate(day));
                  return isSchoolday;
                },
                locale: 'de_DE',
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                calendarBuilders: CalendarBuilders(
                  singleMarkerBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // selectedBuilder: (context, day, focusedDay) => Container(
                  //     margin: const EdgeInsets.all(4.0),
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Theme.of(context).primaryColor,
                  //         borderRadius: BorderRadius.circular(25.0)),
                  //     child: Text(
                  //       day.day.toString(),
                  //       style: TextStyle(color: Colors.white),
                  //     )),
                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                eventLoader: _getEventsForDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onDayLongPressed: (selectedDay, focusedDay) {
                  snackbarInfo(context,
                      ' Selected day: ${selectedDay.formatForUser()}, focused day: ${focusedDay.formatForUser()}');
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ),
              //const Gap(20),
              _selectedDay != null
                  ? Row(
                      children: [
                        const Gap(15),
                        Text(
                            DateFormat('EEEE',
                                    Localizations.localeOf(context).toString())
                                .format(_selectedDay!),
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const Gap(5),
                        Text(' ${_selectedDay?.formatForUser()}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const Gap(40),
                        Text(
                            missedClasses
                                .where((missedClass) =>
                                    missedClass.missedType == 'missed')
                                .length
                                .toString(),
                            style: const TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.bold)),
                        const Gap(20)
                      ],
                    )
                  : const Row(
                      children: [
                        Gap(15),
                        Text('Kein Tag ausgewählt',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: missedClasses.length,
                  itemBuilder: (context, index) {
                    return AttendanceCard(
                        missedClasses[index].missedPupilId, _selectedDay!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
