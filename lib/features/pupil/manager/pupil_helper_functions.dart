import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

// ? we should move this functions to the pupil manager in future

// TODO: these should be enums

String preschoolRevisionPredicate(int value) {
  switch (value) {
    case 0:
      return 'nicht vorhanden';
    case 1:
      return "unauffällig";
    case 2:
      return "Förderbedarf";
    case 3:
      return "AO-SF prüfen";
    default:
      return "Falscher Wert im Server";
  }
}

String pickUpValue(String? value) {
  return pickupTimePredicate(value);
}

String pickupTimePredicate(String? value) {
  switch (value) {
    case null:
      return 'k.A.';
    case '0':
      return '14:00';
    case '1':
      return "14:00";
    case '2':
      return "15:00";
    case '3':
      return "16:00";
    default:
      return "Falscher Wert im Server";
  }
}

String communicationPredicate(String? value) {
  switch (value) {
    case null:
      return 'keine Angabe';
    case '0':
      return 'nicht';
    case '1':
      return "einfache Anliegen";
    case '2':
      return "komplexere Informationen";
    case '3':
      return "ohne Probleme";
    case '4':
      return "unbekannt";
    default:
      return "Falscher Wert im Server";
  }
}

// TODO: Should these be getters in PupilProxy?

bool hasLanguageSupport(DateTime? endOfSupport) {
  if (endOfSupport != null) {
    return endOfSupport.isAfter(DateTime.now());
  }
  return false;
}

bool hadLanguageSupport(DateTime? endOfSupport) {
  if (endOfSupport != null) {
    return endOfSupport.isBefore(DateTime.now());
  }
  return false;
}

// TODO: Migrate to pupilsWithBirthdaySinceDate an remove this function

List<PupilProxy> pupilsWithBirthdayInTheLastSevenDays() {
  final List<PupilProxy> pupils = locator<PupilManager>().allPupils;
  final DateTime now = DateTime.now();

  List<PupilProxy> pupilsWithBirthdayInTheLastSevenDays = [];
  final int currentDay = now.day;
  final int currentMonth = now.month;

  for (PupilProxy pupil in pupils) {
    /// TODO, das geht einfacher und wäre warhscheinlich besser als Filter  zu implementieren

    // Extract day and month from birthday and current date
    final int pupilBirthDay = pupil.birthday.day;
    final int pupilBirthMonth = pupil.birthday.month;

    // Check if birthday falls within the last seven days (including today)
    final bool isBirthdayTodayOrInLastSevenDays = (currentMonth ==
                pupilBirthMonth &&
            // Check for birthdays within the current month
            (currentDay >=
                    pupilBirthDay && // Birthday falls on or after current day
                currentDay - pupilBirthDay <=
                    6) || // Within 6 days of the current day
        (currentMonth - pupilBirthMonth ==
                1 && // Birthday in the previous month
            currentDay < pupilBirthDay && // Current day is before birthday
            currentDay +
                    DateUtils.getDaysInMonth(now.year, currentMonth - 1) -
                    pupilBirthDay <=
                6));

    if (isBirthdayTodayOrInLastSevenDays) {
      pupilsWithBirthdayInTheLastSevenDays.add(pupil);
    }
  }
  int currentYear = DateTime.now().year;

  pupilsWithBirthdayInTheLastSevenDays.sort((a, b) {
    int aDayOfYear = DateTime(currentYear, a.birthday.month, a.birthday.day)
        .difference(DateTime(currentYear, 1, 1))
        .inDays;
    int bDayOfYear = DateTime(currentYear, b.birthday.month, b.birthday.day)
        .difference(DateTime(currentYear, 1, 1))
        .inDays;
    return bDayOfYear.compareTo(aDayOfYear);
  });
  return pupilsWithBirthdayInTheLastSevenDays;
}
