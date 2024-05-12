class EndpointsMissedClass {
  //- GET
  String getMissedClasses = '/missed_classes/all';
  String getOneMissedClass(int id) {
    return '/missed_classes/$id';
  }

  String getMissedClassesOnDate(DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/schoolday/$missedDate';
  }
  //- POST

  static const postMissedClass = '/missed_classes/new';
  static const postMissedClassList = '/missed_classes/list';

  //- PATCH

  String patchMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/$id/$missedDate';
  }

  //- DELETE

  String deleteMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_classes/$id/$missedDate';
  }
}
