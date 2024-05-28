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
    // if the pupil has a list with the same id as the current list
    if (pupil.pupilLists != null) {
      PupilList? listMatch = pupil.pupilLists
          ?.firstWhere((element) => element.originList == schoolList.listId);
      if (listMatch != null) {
        listMatch.pupilListStatus == true
            ? countYes++
            : listMatch.pupilListStatus == false
                ? countNo++
                : countNull++;
      }
      listMatch!.pupilListComment != null &&
              listMatch.pupilListComment!.isNotEmpty
          ? countComment++
          : countComment;
    }
  }
  return {
    'yes': countYes,
    'no': countNo,
    'null': countNull,
    'comment': countComment
  };
}
