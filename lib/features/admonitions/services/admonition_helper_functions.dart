import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class SchoolEventHelper {
  static int? admonitionSum(Pupil pupil) {
    return pupil.pupilAdmonitions?.length;
  }

  static int? findAdmonitionIndex(Pupil pupil, DateTime date) {
    final int? foundAdmonitionIndex = pupil.pupilAdmonitions
        ?.indexWhere((datematch) => (datematch.admonishedDay.isSameDate(date)));
    if (foundAdmonitionIndex == null) {
      return null;
    }
    return foundAdmonitionIndex;
  }

  static bool pupilIsAdmonishedToday(Pupil pupil) {
    if (pupil.pupilAdmonitions!.isEmpty) return false;
    if (pupil.pupilAdmonitions!
        .any((element) => element.admonishedDay.isSameDate(DateTime.now()))) {
      return true;
    }
    return false;
  }

  static int getAdmonitionCount(List<Pupil> pupils) {
    int admonitions = 0;
    for (Pupil pupil in pupils) {
      if (pupil.pupilAdmonitions != null) {
        admonitions = admonitions + pupil.pupilAdmonitions!.length;
      }
    }
    return admonitions;
  }

  static int getSchoolAdmonitionCount(List<Pupil> pupils) {
    int admonitions = 0;
    for (Pupil pupil in pupils) {
      if (pupil.pupilAdmonitions != null) {
        for (Admonition admonition in pupil.pupilAdmonitions!) {
          if (admonition.admonitionType == 'rk') {
            admonitions++;
          }
        }
      }
    }
    return admonitions;
  }

  static int getOgsAdmonitionCount(List<Pupil> pupils) {
    int admonitions = 0;
    for (Pupil pupil in pupils) {
      if (pupil.pupilAdmonitions != null) {
        for (Admonition admonition in pupil.pupilAdmonitions!) {
          if (admonition.admonitionType == 'rkogs') {
            admonitions++;
          }
        }
      }
    }
    return admonitions;
  }

  static String getAdmonitionTypeText(String value) {
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

  static String getAdmonitionReasonText(String value) {
    bool firstItem = true;
    String admonitionReasonText = '';

    if (value.contains('gm')) {
      admonitionReasonText = '${admonitionReasonText}Gewalt gegen Menschen';
      firstItem = false;
    }

    if (value.contains('gs')) {
      if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
      admonitionReasonText = '${admonitionReasonText}Gewalt gegen Sachen';
      firstItem = false;
    }
    if (value.contains('äa')) {
      if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';

      admonitionReasonText = '${admonitionReasonText}Ärgern anderer Kinder';
      firstItem = false;
    }

    if (value.contains('il')) {
      if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
      admonitionReasonText =
          '${admonitionReasonText}Ignorieren von Anweisungen';
      firstItem == false;
    }

    if (value.contains('us')) {
      if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
      admonitionReasonText = '${admonitionReasonText}Unterrichtsstörung';
      firstItem = false;
    }

    if (value.contains('ss')) {
      if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
      admonitionReasonText = '${admonitionReasonText}Sonstiges';
      firstItem = false;
    }
    return admonitionReasonText;
  }
}
