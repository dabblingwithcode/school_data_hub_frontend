class EndpointsCompetence {
  //-POST
  String postNewCompetence = '/competences/new';

  //- GET
  String fetchCompetences = '/competences/all/flat';

  //- PATCH
  String patchCompetence(int competenceId) {
    return '/competences/$competenceId/patch';
  }

  //- DELETE
  String deleteCompetence(int id) {
    return '/competences/$id/delete';
  }

  //- COMPETENCE CHECKS ------------------------------------------------

  //- GET

  String getCompetenceCheckFile(String fileId) {
    return '/competence_checks/$fileId';
  }

  //- POST

  String postCompetenceCheck(int pupilId) {
    return '/competence_checks/$pupilId/new';
  }

  String postCompetenceCheckFile(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId/file';
  }

  //- PATCH

  String patchCompetenceCheck(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId';
  }

  // String patchCompetenceCheckWithFile(String competenceCheckId) {
  //   return '/competence/check/$competenceCheckId';
  // }

  //- DELETE

  String deleteCompetenceCheck(String competenceCheckId) {
    return '/competence_checks/$competenceCheckId';
  }

  String deleteCompetenceCheckFile(String fileId) {
    return '/competence_checks/$fileId';
  }

  //- COMPETENCE GOALS -------------------------------------------------

  //- POST
  String postCompetenceGoal(int pupilId) {
    return '/competence_goals/new/$pupilId';
  }

  //- PATCH
  String patchCompetenceGoal(String competenceGoalId) {
    return '/competence_goals/$competenceGoalId';
  }

  //- DELETE
  String deleteCompetenceGoal(String competenceGoalId) {
    return '/competence_goals/$competenceGoalId/delete';
  }
}
