// ignore_for_file: constant_identifier_names

enum SearchType { pupil, room, matrixUser, list, authorization, workbook }

enum SnackBarType { success, error, warning, info }

enum CompetenceFilter { E1, E2, S3, S4 }

Map<CompetenceFilter, bool> initialCompetenceFilterValues = {
  CompetenceFilter.E1: false,
  CompetenceFilter.E2: false,
  CompetenceFilter.S3: false,
  CompetenceFilter.S4: false
};

enum AdmonitionFilter {
  sevenDays,
  redCard,
  redCardOgs,
  redCardsentHome,
  parentsMeeting,
  otherEvent,
  violenceAgainstThings,
  violenceAgainstPersons,
  annoy,
  ignoreInstructions,
  disturbLesson,
  other,
  processed,
}

Map<AdmonitionFilter, bool> initialAdmonitionFilterValues = {
  AdmonitionFilter.sevenDays: false,
  AdmonitionFilter.redCard: false,
  AdmonitionFilter.redCardOgs: false,
  AdmonitionFilter.redCardsentHome: false,
  AdmonitionFilter.parentsMeeting: false,
  AdmonitionFilter.otherEvent: false,
  AdmonitionFilter.violenceAgainstThings: false,
  AdmonitionFilter.violenceAgainstPersons: false,
  AdmonitionFilter.annoy: false,
  AdmonitionFilter.ignoreInstructions: false,
  AdmonitionFilter.disturbLesson: false,
  AdmonitionFilter.other: false,
  AdmonitionFilter.processed: false,
};

enum PupilSortMode {
  sortByName,
  sortByMissedExcused,
  sortByMissedUnexcused,
  sortByContacted,
  sortByLate,
  sortByCredit,
  sortByCreditEarned,
  sortByGoneHome,
  sortByAdmonitions,
  sortByLastAdmonition,
  sortByLastNonProcessedAdmonition,
}

Map<PupilSortMode, bool> initialSortModeValues = {
  PupilSortMode.sortByName: true,
  PupilSortMode.sortByMissedExcused: false,
  PupilSortMode.sortByMissedUnexcused: false,
  PupilSortMode.sortByContacted: false,
  PupilSortMode.sortByLate: false,
  PupilSortMode.sortByCredit: false,
  PupilSortMode.sortByCreditEarned: false,
  PupilSortMode.sortByGoneHome: false,
  PupilSortMode.sortByAdmonitions: false,
  PupilSortMode.sortByLastAdmonition: false,
  PupilSortMode.sortByLastNonProcessedAdmonition: false
};

enum PupilFilter {
  E1,
  E2,
  E3,
  S3,
  S4,
  A1,
  A2,
  A3,
  B1,
  B2,
  B3,
  B4,
  C1,
  C2,
  C3,
  late,
  missed,
  home,
  unexcused,
  contacted,
  goneHome,
  present,
  notPresent,
  specialNeeds,
  ogs,
  notOgs,
  specialInfo,
  migrationSupport,
  preSchoolRevision0,
  preSchoolRevision1,
  preSchoolRevision2,
  preSchoolRevision3,
  developmentPlan1,
  developmentPlan2,
  developmentPlan3,
  fiveYears,
  communicationPupil,
  communicationTutor1,
  communicationTutor2,
  justGirls,
  justBoys,
  schoolListYesResponse,
  schoolListNoResponse,
  schoolListNullResponse,
  schoolListCommentResponse,
  authorizationYesResponse,
  authorizationNoResponse,
  authorizationNullResponse,
  authorizationCommentResponse,
  supportAreaMotorics,
  supportAreaLanguage,
  supportAreaMath,
  supportAreaGerman,
  supportAreaEmotions,
  supportAreaLearning,
}

Map<PupilFilter, bool> initialFilterValues = {
  PupilFilter.E1: false,
  PupilFilter.E2: false,
  PupilFilter.E3: false,
  PupilFilter.S3: false,
  PupilFilter.S4: false,
  PupilFilter.A1: false,
  PupilFilter.A2: false,
  PupilFilter.A3: false,
  PupilFilter.B1: false,
  PupilFilter.B2: false,
  PupilFilter.B3: false,
  PupilFilter.B4: false,
  PupilFilter.C1: false,
  PupilFilter.C2: false,
  PupilFilter.C3: false,
  PupilFilter.late: false,
  PupilFilter.missed: false,
  PupilFilter.home: false,
  PupilFilter.unexcused: false,
  PupilFilter.contacted: false,
  PupilFilter.goneHome: false,
  PupilFilter.present: false,
  PupilFilter.notPresent: false,
  PupilFilter.specialNeeds: false,
  PupilFilter.ogs: false,
  PupilFilter.notOgs: false,
  PupilFilter.specialInfo: false,
  PupilFilter.migrationSupport: false,
  PupilFilter.preSchoolRevision0: false,
  PupilFilter.preSchoolRevision1: false,
  PupilFilter.preSchoolRevision2: false,
  PupilFilter.preSchoolRevision3: false,
  PupilFilter.developmentPlan1: false,
  PupilFilter.developmentPlan2: false,
  PupilFilter.developmentPlan3: false,
  PupilFilter.fiveYears: false,
  PupilFilter.communicationPupil: false,
  PupilFilter.communicationTutor1: false,
  PupilFilter.communicationTutor2: false,
  PupilFilter.justBoys: false,
  PupilFilter.justGirls: false,
  PupilFilter.schoolListYesResponse: false,
  PupilFilter.schoolListNoResponse: false,
  PupilFilter.schoolListNullResponse: false,
  PupilFilter.schoolListCommentResponse: false,
  PupilFilter.authorizationYesResponse: false,
  PupilFilter.authorizationNoResponse: false,
  PupilFilter.authorizationNullResponse: false,
  PupilFilter.authorizationCommentResponse: false,
  PupilFilter.supportAreaMotorics: false,
  PupilFilter.supportAreaLanguage: false,
  PupilFilter.supportAreaMath: false,
  PupilFilter.supportAreaGerman: false,
  PupilFilter.supportAreaEmotions: false,
  PupilFilter.supportAreaLearning: false,
};