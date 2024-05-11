import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/models/schoolday_models/schoolday.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/statistics_view.dart';
import 'package:watch_it/watch_it.dart';

class Statistics extends WatchingStatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  StatisticsController createState() => StatisticsController();
}

class StatisticsController extends State<Statistics> {
  final List<PupilProxy> pupils = locator<PupilManager>().pupils.value;
  Map<String, int> languageOccurrences = {};
  Map<String, DateTime> enrollments = {};
  @override
  void initState() {
    calculateLanguageOccurrences();

    super.initState();
  }

  calculateLanguageOccurrences() {
    for (PupilProxy pupil in pupils) {
      languageOccurrences[pupil.language!] =
          (languageOccurrences[pupil.language] ?? 0) + 1;
    }
  }

  List<PupilProxy> pupilsNotSpeakingGerman(List<PupilProxy> givenPupils) {
    return givenPupils.where((pupil) => pupil.language != 'Deutsch').toList();
  }

  List<PupilProxy> pupilsNotEnrolledOnDate(List<PupilProxy> givenPupils) {
    return givenPupils.where((pupil) {
      return !(pupil.pupilSince!.month == 8 && pupil.pupilSince!.day == 1);
    }).toList();
  }

  List<PupilProxy> pupilsEnrolledAfterDate(DateTime date) {
    return pupils.where((pupil) => pupil.pupilSince!.isAfter(date)).toList();
  }

  List<PupilProxy> pupilsEnrolledBetweenDates(
      DateTime startDate, DateTime endDate) {
    return pupils
        .where((pupil) =>
            pupil.pupilSince!.isAfter(startDate) &&
            pupil.pupilSince!.isBefore(endDate))
        .toList();
  }

  List<PupilProxy> pupilsInaGivenGroup(String group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.group == group) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsInOGS(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.ogs == true) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> malePupils(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.gender == 'm') {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> femalePupils(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.gender == 'w') {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsWithLanguageSupport(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list

      if (pupil.migrationSupportEnds != null) {
        if (hasLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsHadLanguageSupport(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list
      if (pupil.migrationSupportEnds != null) {
        if (hadLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<PupilProxy> schoolyearInaGivenGroup(
      List<PupilProxy> group, String schoolyear) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.schoolyear == schoolyear) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSupportInaGivenGroup(
      List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSpecialNeedsInaGivenGroup(
      List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> specialNeedsInAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.specialNeeds != null) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan1InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.individualDevelopmentPlan == 1) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan2InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.individualDevelopmentPlan == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan3InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.individualDevelopmentPlan == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionNotAvailable(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 0) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionOk(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 1) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSupport(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSpecialNeeds(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preschoolRevision == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<MissedClass> totalMissedClasses(List<PupilProxy> pupils) {
    List<MissedClass> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        for (MissedClass missedClass in pupil.pupilMissedClasses!) {
          missedClasses.add(missedClass);
        }
      }
    }
    return missedClasses;
  }

  List<MissedClass> totalUnexcusedMissedClasses(List<PupilProxy> pupils) {
    List<MissedClass> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        for (MissedClass missedClass in pupil.pupilMissedClasses!) {
          if (missedClass.excused == true) {
            missedClasses.add(missedClass);
          }
        }
      }
    }

    return missedClasses;
  }

  List<MissedClass> totalContactedMissedClasses(List<PupilProxy> pupils) {
    List<MissedClass> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        for (MissedClass missedClass in pupil.pupilMissedClasses!) {
          if (missedClass.contacted != '0') {
            missedClasses.add(missedClass);
          }
        }
      }
    }
    return missedClasses;
  }

  double averageMissedClassesperPupil(List<PupilProxy> pupils) {
    double totalMissedClasses = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        totalMissedClasses += pupil.pupilMissedClasses!.length;
      }
    }
    return totalMissedClasses / pupils.length;
  }

  double averageUnexcusedMissedClassesperPupil(List<PupilProxy> pupils) {
    double totalMissedClasses = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        for (MissedClass missedClass in pupil.pupilMissedClasses!) {
          if (missedClass.excused == true) {
            totalMissedClasses++;
          }
        }
      }
    }
    return totalMissedClasses / pupils.length;
  }

  double percentageMissedSchooldays(double amountOfmissedClasses) {
    List<Schoolday> schooldays = locator<SchooldayManager>().schooldays.value;
    int schooldaysUntiltoday = 0;
    for (Schoolday schoolday in schooldays) {
      if (schoolday.schoolday.isBeforeDate(DateTime.now())) {
        schooldaysUntiltoday++;
      }
    }
    return amountOfmissedClasses / schooldaysUntiltoday * 100;
  }

  Map<String, int> groupStatistics(List<PupilProxy> pupils) {
    Map<String, int> groupStatistics = {};
    for (PupilProxy pupil in pupils) {
      groupStatistics[pupil.group!] = (groupStatistics[pupil.group!] ?? 0) + 1;
    }
    return groupStatistics;
  }

  @override
  Widget build(BuildContext context) {
    return StatisticsView(this);
  }
}
