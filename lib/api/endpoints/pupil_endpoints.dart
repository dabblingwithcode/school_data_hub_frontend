part of '../endpoints.dart';

class EndpointsPupil {
  //- POST
  static const postPupil = '/pupils/new';
  static const exportPupilsTxt = '/import/pupils/txt';

  //- GET
  static const getAllPupils = '/pupils/all';
  static const getPupilsFlat = '/pupils/all/flat';
  static const getPupils = '/pupils/list';

  String getOnePupil(int id) {
    return '/pupils/$id';
  }

  String getPupilAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  //- PATCH
  String patchPupil(int id) {
    return '/pupils/$id';
  }

  static const patchSiblings = '/pupils/patch_siblings';

  String patchPupilhWithAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  //- DELETE
  String deletePupil(int pupilId) {
    return '/pupils/$pupilId';
  }

  String deletePupilAvatar(int pupilId) {
    return '/pupils/$pupilId/avatar';
  }
}
