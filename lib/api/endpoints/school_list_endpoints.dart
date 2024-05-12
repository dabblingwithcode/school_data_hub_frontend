class EndpointsSchoolList {
  //- SCHOOL LISTS -//

  //- GET
  static const getSchoolLists = '/school_lists/all/flat';
  static const getSchoolListWithPupils = '/school_lists/all';

  //- POST
  static const postSchoolListWithGroup = '/school_lists/list';
  static const postSchoolList = '/school_lists/all';

  //- PATCH
  String patchSchoolList(String listId) {
    return '/school_lists/$listId/patch';
  }

  //- DELETE
  String deleteSchoolList(String listId) {
    return '/school_lists/$listId';
  }

  //- PUPIL LISTS -//

  //- POST
  String addPupilsToSchoolList(String listId) {
    return '/school_lists/$listId/pupils';
  }

  //-PATCH
  String patchPupilSchoolList(int pupilId, String listId) {
    return '/pupil_lists/$pupilId/$listId';
  }

  //-DELETE
  String deletePupilsFromSchoolList(String listId) {
    return '/pupil_lists/$listId/delete_pupils';
  }
}
