import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class SchoolEventHelper {
  static int schooldayEventSum(PupilProxy pupil) {
    return pupil.schooldayEvents?.length ?? 0;
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
    if (pupil.schooldayEvents!.any(
        (element) => element.schooldayEventDate.isSameDate(DateTime.now()))) {
      return true;
    }
    return false;
  }

  static int getSchooldayEventCount(List<PupilProxy> pupils) {
    int schooldayEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.schooldayEvents != null) {
        schooldayEvents = schooldayEvents + pupil.schooldayEvents!.length;
      }
    }
    return schooldayEvents;
  }

  static int getSchoolSchooldayEventCount(List<PupilProxy> pupils) {
    int schooldayEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.schooldayEvents != null) {
        for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
          if (schooldayEvent.schooldayEventType == 'rk') {
            schooldayEvents++;
          }
        }
      }
    }
    return schooldayEvents;
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
      if (firstItem == false)
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      schooldayEventReasonText =
          '${schooldayEventReasonText}Gewalt gegen Sachen';
      firstItem = false;
    }
    if (value.contains('äa')) {
      if (firstItem == false)
        schooldayEventReasonText = '$schooldayEventReasonText - ';

      schooldayEventReasonText =
          '${schooldayEventReasonText}Ärgern anderer Kinder';
      firstItem = false;
    }

    if (value.contains('il')) {
      if (firstItem == false)
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      schooldayEventReasonText =
          '${schooldayEventReasonText}Ignorieren von Anweisungen';
      firstItem == false;
    }

    if (value.contains('us')) {
      if (firstItem == false)
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      schooldayEventReasonText =
          '${schooldayEventReasonText}Unterrichtsstörung';
      firstItem = false;
    }

    if (value.contains('ss')) {
      if (firstItem == false)
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      schooldayEventReasonText = '${schooldayEventReasonText}Sonstiges';
      firstItem = false;
    }
    return schooldayEventReasonText;
  }
}
