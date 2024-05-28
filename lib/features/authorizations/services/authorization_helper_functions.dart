import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:collection/collection.dart'; // Impo

Map<String, int> authorizationStats(
    Authorization authorization, List<PupilProxy> pupilsInList) {
  int countYes = 0;
  int countNo = 0;
  int countNull = 0;
  int countComment = 0;
  for (PupilProxy pupil in pupilsInList) {
    // if the pupil has a list with the same id as the current list
    if (pupil.pupilLists != null) {
      // ...

      PupilAuthorization? listMatch = pupil.authorizations?.firstWhereOrNull(
          (element) =>
              element.originAuthorization == authorization.authorizationId);
      if (listMatch != null) {
        listMatch.status == true
            ? countYes++
            : listMatch.status == false
                ? countNo++
                : countNull++;
        listMatch.comment != null && listMatch.comment!.isNotEmpty
            ? countComment++
            : countComment;
      }
    }
  }
  return {
    'yes': countYes,
    'no': countNo,
    'null': countNull,
    'comment': countComment
  };
}
