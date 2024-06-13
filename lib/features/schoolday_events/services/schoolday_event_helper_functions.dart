import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/filters/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_manager.dart';

class SchooldayEventsCount {
  final int totalSchooldayEvents;
  final int totalLessonSchooldayEvents;
  final int totalOgsSchooldayEvents;
  final int totalSentHomeSchooldayEvents;
  final int totalParentsMeetingSchooldayEvents;

  SchooldayEventsCount(
      {required this.totalSchooldayEvents,
      required this.totalLessonSchooldayEvents,
      required this.totalOgsSchooldayEvents,
      required this.totalSentHomeSchooldayEvents,
      required this.totalParentsMeetingSchooldayEvents});
}

class SchoolDayEventHelper {
  static int schooldayEventSum(PupilProxy pupil) {
    return locator<SchooldayEventFilterManager>()
        .filteredSchooldayEvents(pupil)
        .length;
  }

  static bool isAuthorizedToChangeStatus(SchooldayEvent schooldayEvent) {
    if (locator<SessionManager>().isAdmin.value == true ||
        schooldayEvent.admonishingUser ==
            locator<SessionManager>().credentials.value.username) {
      return true;
    }
    return false;
  }

  static DateTime getPupilLastSchooldayEventDate(PupilProxy pupil) {
    final List<SchooldayEvent> schooldayEvents =
        locator<SchooldayEventFilterManager>().filteredSchooldayEvents(pupil);
    if (schooldayEvents.isEmpty) {
      // if schoolday events is empty, we return a mock date
      return DateTime(2017, 9, 7, 17);
    }
    return getLastSchoolEventDate(schooldayEvents);
  }

  static int? findSchooldayEventIndex(PupilProxy pupil, DateTime date) {
    final int? foundSchooldayEventIndex = pupil.schooldayEvents?.indexWhere(
        (datematch) => (datematch.schooldayEventDate.isSameDate(date)));
    if (foundSchooldayEventIndex == null) {
      return null;
    }
    return foundSchooldayEventIndex;
  }

  static bool pupilIsAdmonishedToday(PupilProxy pupil) {
    if (pupil.schooldayEvents!.isEmpty) return false;
    if (pupil.schooldayEvents!.any((element) =>
        element.schooldayEventDate.isSameDate(DateTime.now()) &&
        (element.schooldayEventType == SchooldayEventType.admonition.value ||
            element.schooldayEventType ==
                SchooldayEventType.afternoonCareAdmonition.value ||
            element.schooldayEventType ==
                SchooldayEventType.admonitionAndBanned.value))) {
      return true;
    }
    return false;
  }

  static SchooldayEventsCount getSchooldayEventsCount(List<PupilProxy> pupils) {
    int totalSchooldayEvents = 0;
    int teachingSchooldayEvents = 0;
    int ogsSchooldayEvents = 0;
    int sentHomeSchooldayEvents = 0;
    int parentsMeetingSchooldayEvents = 0;

    for (PupilProxy pupil in pupils) {
      final pupilSchooldayEvents =
          locator<SchooldayEventFilterManager>().filteredSchooldayEvents(pupil);

      totalSchooldayEvents = totalSchooldayEvents + pupilSchooldayEvents.length;
      teachingSchooldayEvents = teachingSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.schooldayEventType ==
                  SchooldayEventType.admonition.value)
              .length;
      ogsSchooldayEvents = ogsSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.schooldayEventType ==
                  SchooldayEventType.afternoonCareAdmonition.value)
              .length;
      sentHomeSchooldayEvents = sentHomeSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.schooldayEventType ==
                  SchooldayEventType.admonitionAndBanned.value)
              .length;
      parentsMeetingSchooldayEvents = parentsMeetingSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.schooldayEventType ==
                  SchooldayEventType.parentsMeeting.value)
              .length;
    }

    return SchooldayEventsCount(
        totalSchooldayEvents: totalSchooldayEvents,
        totalLessonSchooldayEvents: teachingSchooldayEvents,
        totalOgsSchooldayEvents: ogsSchooldayEvents,
        totalSentHomeSchooldayEvents: sentHomeSchooldayEvents,
        totalParentsMeetingSchooldayEvents: parentsMeetingSchooldayEvents);
  }

  static DateTime getLastSchoolEventDate(List<SchooldayEvent> schooldayEvents) {
    schooldayEvents
        .sort((a, b) => b.schooldayEventDate.compareTo(a.schooldayEventDate));
    return schooldayEvents.first.schooldayEventDate;
  }

  static int getOgsSchooldayEventCount(List<PupilProxy> pupils) {
    int schooldayEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.schooldayEvents != null) {
        for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
          if (schooldayEvent.schooldayEventType == 'rkogs') {
            schooldayEvents++;
          }
        }
      }
    }
    return schooldayEvents;
  }

  static String getSchooldayEventTypeText(String value) {
    switch (value) {
      case 'choose':
        return 'bitte wählen';
      case 'rk':
        return '';
      case 'rkogs':
        return 'OGS';
      case 'other':
        return 'Sonstiges';
      case 'Eg':
        return 'Elterngespräch';
      default:
        return '';
    }
  }

  static String getSchooldayEventReasonText(String value) {
    bool firstItem = true;
    String schooldayEventReasonText = '';

    if (value.contains('gm')) {
      schooldayEventReasonText =
          '${schooldayEventReasonText}Gewalt gegen Menschen';
      firstItem = false;
    }

    if (value.contains('gs')) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Gewalt gegen Sachen';
      firstItem = false;
    }
    if (value.contains('äa')) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }

      schooldayEventReasonText =
          // ignore: unnecessary_brace_in_string_interps
          '${schooldayEventReasonText}Ärgern anderer Kinder';
      firstItem = false;
    }

    if (value.contains('il')) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Ignorieren von Anweisungen';
      firstItem == false;
    }

    if (value.contains('us')) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Unterrichtsstörung';
      firstItem = false;
    }

    if (value.contains('ss')) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText = '${schooldayEventReasonText}Sonstiges';
      firstItem = false;
    }
    return schooldayEventReasonText;
  }
}
