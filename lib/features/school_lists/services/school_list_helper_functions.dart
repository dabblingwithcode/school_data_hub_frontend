import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

String listOwner(String listId) {
  final SchoolList schoolList = locator<SchoolListManager>()
      .schoolLists
      .value
      .firstWhere((element) => element.listId == listId);
  return schoolList.createdBy;
}

String listOwners(SchoolList schoolList) {
  String owners = '';
  if (schoolList.visibility == 'public') {
    return 'HER';
  }
  if (schoolList.visibility == 'private') {
    return '';
  }
  schoolList.visibility.split('*').forEach((element) {
    if (element.isNotEmpty) {
      owners += ' - $element';
    }
  });
  return owners;
}

String shareList(String teacher, SchoolList schoolList) {
  String visibility = schoolList.visibility;
  visibility += '*$teacher';
  return visibility;
}

Map<String, int> schoolListStats(
    SchoolList schoolList, List<PupilProxy> pupilsInList) {
  int countYes = 0;
  int countNo = 0;
  int countNull = 0;
  int countComment = 0;
  for (PupilProxy pupil in pupilsInList) {
    for (PupilList pupilList in schoolList.pupilLists) {
      if (pupilList.listedPupilId == pupil.internalId) {
        pupilList.pupilListStatus == true
            ? countYes++
            : pupilList.pupilListStatus == false
                ? countNo++
                : countNull++;
        pupilList.pupilListComment != null &&
                pupilList.pupilListComment!.isNotEmpty
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
