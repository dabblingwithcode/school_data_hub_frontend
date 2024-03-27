part of '../endpoints.dart';

class EndpointsSchoolday {
  //- GET
  static const getSchooldaysWithChildren = '/schooldays/all';
  static const getSchooldays = '/schooldays/all/flat';

  String getOneSchoolday(DateTime date) {
    return '/schooldays/${date.formatForJson()}';
  }

  //- POST
  static const postSchoolday = '/schooldays/new';
  static const postMultipleSchooldays = '/schooldays/new/list';

  //- DELETE
  String deleteSchoolday(DateTime date) {
    return '/schooldays/${date.formatForJson()}';
  }

  static const deleteSchooldays = '/schooldays/delete/list';
}
