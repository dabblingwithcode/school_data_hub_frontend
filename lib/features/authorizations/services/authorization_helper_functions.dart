import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
// Impo

Map<String, int> authorizationStats(Authorization authorization) {
  int countYes = 0;
  int countNo = 0;
  int countNull = 0;
  int countComment = 0;
  for (PupilAuthorization pupilAuthorization
      in authorization.authorizedPupils) {
    pupilAuthorization.status == true
        ? countYes++
        : pupilAuthorization.status == false
            ? countNo++
            : countNull++;
    pupilAuthorization.comment != null && pupilAuthorization.comment!.isNotEmpty
        ? countComment++
        : countComment;
  }

  return {
    'yes': countYes,
    'no': countNo,
    'null': countNull,
    'comment': countComment
  };
}
