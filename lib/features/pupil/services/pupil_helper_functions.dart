import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_base.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

Pupil findPupilById(int pupilId) {
  final pupils = locator<PupilManager>().pupils.value;
  final Pupil pupil =
      pupils.singleWhere((element) => element.internalId == pupilId);
  return pupil;
}

List<Pupil> pupilsFromPupilIds(List<int> pupilIds) {
  List<Pupil> pupilsfromPupilIds = [];
  final pupils = locator<PupilManager>().pupils.value;
  pupilsfromPupilIds =
      pupils.where((element) => pupilIds.contains(element.internalId)).toList();
  return pupilsfromPupilIds;
}

List<int> pupilIdsFromPupils(List<Pupil> pupils) {
  List<int> pupilIds = [];
  for (Pupil pupil in pupils) {
    pupilIds.add(pupil.internalId);
  }
  return pupilIds;
}

List<int> restOfPupils(List<int> pupilIds) {
  List<int> restOfPupils = [];
  final pupils = locator<PupilManager>().pupils.value;
  for (Pupil pupil in pupils) {
    if (!pupilIds.contains(pupil.internalId)) {
      restOfPupils.add(pupil.internalId);
    }
  }
  return restOfPupils;
}

Pupil pupilCopiedWith(Pupil namedPupil, Pupil updatedPupil) {
  final Pupil pupil = updatedPupil.copyWith(
    firstName: namedPupil.firstName,
    lastName: namedPupil.lastName,
    group: namedPupil.group,
    schoolyear: namedPupil.schoolyear,
    specialNeeds: namedPupil.specialNeeds,
    gender: namedPupil.gender,
    language: namedPupil.language,
    family: namedPupil.family,
    birthday: namedPupil.birthday,
    migrationSupportEnds: namedPupil.migrationSupportEnds,
    pupilSince: namedPupil.pupilSince,
  );
  return pupil;
}

Pupil patchPupilWithPupilbaseData(PupilBase pupilbase, Pupil pupil) {
  return pupil.copyWith(
    firstName: pupilbase.name,
    lastName: pupilbase.lastName,
    group: pupilbase.group,
    schoolyear: pupilbase.schoolyear,
    specialNeeds: pupilbase.specialNeeds,
    gender: pupilbase.gender,
    language: pupilbase.language,
    family: pupilbase.family,
    birthday: pupilbase.birthday,
    migrationSupportEnds: pupilbase.migrationSupportEnds,
    pupilSince: pupilbase.pupilSince,
  );
}

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

List<Pupil> siblings(Pupil pupil) {
  if (pupil.family == null) {
    return [];
  }
  List<Pupil> pupilSiblings = [];
  final pupils = locator<PupilManager>().pupils.value;
  pupilSiblings =
      pupils.where((element) => element.family == pupil.family).toList();
  pupilSiblings.remove(pupil);
  return pupilSiblings;
}

bool hasLanguageSupport(DateTime? date) {
  if (date != null) {
    return date.isAfter(DateTime.now());
  }
  return false;
}

bool hadLanguageSupport(DateTime? date) {
  if (date != null) {
    return date.isBefore(DateTime.now());
  }
  return false;
}

List<Pupil> pupilsWithBirthdayInTheLastSevenDays() {
  final List<Pupil> pupils = locator<PupilManager>().pupils.value;
  final DateTime now = DateTime.now();

  List<Pupil> pupilsWithBirthdayInTheLastSevenDays = [];
  final int currentDay = now.day;
  final int currentMonth = now.month;

  for (Pupil pupil in pupils) {
    if (pupil.birthday != null) {
      // Extract day and month from birthday and current date
      final int pupilBirthDay = pupil.birthday!.day;
      final int pupilBirthMonth = pupil.birthday!.month;

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
  }
  int currentYear = DateTime.now().year;
  pupilsWithBirthdayInTheLastSevenDays.sort((a, b) {
    int aDayOfYear = DateTime(currentYear, a.birthday!.month, a.birthday!.day)
        .difference(DateTime(currentYear, 1, 1))
        .inDays;
    int bDayOfYear = DateTime(currentYear, b.birthday!.month, b.birthday!.day)
        .difference(DateTime(currentYear, 1, 1))
        .inDays;
    return bDayOfYear.compareTo(aDayOfYear);
  });
  return pupilsWithBirthdayInTheLastSevenDays;
}
