import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

class SchoolListManager {
  ValueListenable<List<SchoolList>> get schoolLists => _schoolLists;

  ValueListenable<List<PupilList>> get pupilListsInSchoolList =>
      _pupilListsInSchoolList;

  final _pupilListsInSchoolList = ValueNotifier<List<PupilList>>([]);
  final _schoolLists = ValueNotifier<List<SchoolList>>([]);

  final client = locator.get<ApiManager>().dioClient.value;

  SchoolListManager();

  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  final notificationManager = locator<NotificationManager>();
  final ApiSchoolListService apiSchoolListService = ApiSchoolListService();

  SchoolList getSchoolListById(String listId) {
    return _schoolLists.value.firstWhere((element) => element.listId == listId);
  }

  Future<void> fetchSchoolLists() async {
    final List<SchoolList> responseSchoolLists =
        await apiSchoolListService.fetchSchoolLists();

    notificationManager.showSnackBar(NotificationType.success,
        '${responseSchoolLists.length} Schullisten geladen!');

    _schoolLists.value = responseSchoolLists;

    return;
  }

  Future updateSchoolListProperty(String listId, String? name,
      String? description, String? visibility) async {
    final schoolListToUpdate = getSchoolListById(listId);
    final SchoolList updatedSchoolList =
        await apiSchoolListService.updateSchoolListProperty(
            schoolListToUpdate: schoolListToUpdate,
            name: name,
            description: description,
            visibility: visibility);

    List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
    int index =
        updatedSchoolLists.indexWhere((element) => element.listId == listId);
    updatedSchoolLists[index] = updatedSchoolList;
    _schoolLists.value = updatedSchoolLists;

    notificationManager.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich aktualisiert');

    return;
  }

  Future<void> deleteSchoolList(String listId) async {
    final List<SchoolList> updatedSchoolLists =
        await apiSchoolListService.deleteSchoolList(listId);
    _schoolLists.value = updatedSchoolLists;
    notificationManager.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich gelöscht');

    return;
  }

  //- this one does not use the api
  SchoolList getSchoolList(String listId) {
    final SchoolList schoolList =
        _schoolLists.value.where((element) => element.listId == listId).first;
    return schoolList;
  }

  //- this one does not use the api
  List<PupilList> getVisibleSchoolLists(PupilProxy pupil) {
    final Session session = locator<SessionManager>().credentials.value;
    List<PupilList> visiblePupilLists = pupil.pupilLists!
        .where((pupilList) =>
            getSchoolList(pupilList.originList).visibility == 'public' ||
            getSchoolList(pupilList.originList).createdBy == session.username)
        .toList();
    return visiblePupilLists;
  }

  Future<void> postSchoolListWithGroup(String name, String description,
      List<int> pupilIds, String visibility) async {
    final SchoolList newList =
        await apiSchoolListService.postSchoolListWithGroup(
            name: name,
            description: description,
            pupilIds: pupilIds,
            visibility: visibility);

    List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
    updatedSchoolLists.add(newList);
    _schoolLists.value = updatedSchoolLists;

    await locator<PupilManager>().fetchPupilsByInternalId(pupilIds);

    return;
  }

  Future<void> addPupilsToSchoolList(String listId, List<int> pupilIds) async {
    final List<Pupil> responsePupils =
        await apiSchoolListService.addPupilsToSchoolList(listId, pupilIds);

    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    }

    notificationManager.showSnackBar(
        NotificationType.success, 'Schüler erfolgreich hinzugefügt');

    return;
  }

  Future<void> deletePupilsFromSchoolList(
    List<int> pupilIds,
    String listId,
  ) async {
    // The response are the updated pupils whose pupil list was deleted

    final List<Pupil> responsePupils =
        await apiSchoolListService.deletePupilsFromSchoolList(
      pupilIds: pupilIds,
      listId: listId,
    );

    for (Pupil pupil in responsePupils) {
      locator<PupilManager>().updatePupilProxyWithPupil(pupil);
    }
    notificationManager.showSnackBar(
        NotificationType.success, 'Schülereinträge erfolgreich gelöscht');

    return;
  }

  Future<void> patchSchoolListPupil(
      int pupilId, String listId, bool? value, String? comment) async {
    final Pupil responsePupil = await apiSchoolListService.patchSchoolListPupil(
        pupilId: pupilId, listId: listId, value: value, comment: comment);

    locator<PupilManager>().updatePupilProxyWithPupil(responsePupil);

    notificationManager.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich aktualisiert');

    return;
  }

  //- this functions are not calling the Api

  PupilList getPupilSchoolListEntry(int pupilId, String listId) {
    final PupilProxy pupil = locator<PupilManager>()
        .allPupils
        .where((element) => element.internalId == pupilId)
        .first;

    final PupilList pupilSchoolListEntry = pupil.pupilLists!
        .where((element) => element.originList == listId)
        .first;
    return pupilSchoolListEntry;
  }

  List<PupilProxy> getPupilsinSchoolList(String listId) {
    final List<PupilProxy> pupils = locator<PupilManager>().allPupils;
    final List<PupilProxy> listedPupils = pupils
        .where((pupil) => pupil.pupilLists!
            .any((pupilList) => pupilList.originList == listId))
        .toList();
    return listedPupils;
  }

  List<PupilProxy> pupilsInSchoolList(String listId, List<PupilProxy> pupils) {
    List<PupilProxy> pupilsInList = getPupilsinSchoolList(listId);
    return pupils
        .where((pupil) => pupilsInList
            .any((element) => element.internalId == pupil.internalId))
        .toList();
  }
}
