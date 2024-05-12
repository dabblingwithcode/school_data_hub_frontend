class EndpointsAuthorization {
  static const String getAuthorizations = '/authorizations/all';
  static const String getAuthorizationsFlat = '/authorizations/all/flat';
  String deleteAuthorization(int id) {
    return '/authorizations/$id';
  }

  String patchAuthorization(int id) {
    return '/authorizations/$id';
  }

  String postAuthorization(int id) {
    return '/pupil/$id/authorization';
  }

  static const String postAuthorizationWithPupilsFromList =
      '/authorizations/new/list';

  static const String postAuthorizationWithAllPupils =
      '/authorizations/new/all';

  //-PUPIL AUTHORIZATIONS -------------------------------------------

  String getPupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }

  String postPupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/new';
  }

  String postPupilAuthorizations(String authorizationId) {
    return '/pupil_authorizations/$authorizationId/list';
  }

  String deletePupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId';
  }

  String patchPupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId';
  }

  String patchPupilAuthorizationWithFile(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }

  String deletePupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil_authorizations/$pupilId/$authorizationId/file';
  }
}
