import 'package:collection/collection.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

final filterLocator = locator<PupilFilterManager>();

List<PupilProxy> addAuthorizationFiltersToFilteredPupils(
  List<PupilProxy> pupils,
  Authorization authorization,
) {
  List<PupilProxy> filteredPupils = [];

  for (PupilProxy pupil in pupils) {
    // Check first if the filtered pupil is in the authorization. If not, continue with next one.

    final PupilAuthorization? pupilAuthorization = pupil.authorizations!
        .firstWhereOrNull((pupilAuthorization) =>
            pupilAuthorization.originAuthorization ==
            authorization.authorizationId);

    if (pupilAuthorization == null) {
      continue;
    }
    // This one is - let's apply the authorization filters

    if (filterLocator
            .filterState.value[PupilFilter.authorizationYesResponse]! &&
        pupilAuthorization.status == false) {
      continue;
    }
    if (filterLocator.filterState.value[PupilFilter.authorizationNoResponse]! &&
        pupilAuthorization.status == true) {
      continue;
    }
    if (filterLocator
            .filterState.value[PupilFilter.authorizationNullResponse]! &&
        pupilAuthorization.status != null) {
      continue;
    }
    if (filterLocator
            .filterState.value[PupilFilter.authorizationCommentResponse]! &&
        pupilAuthorization.comment == null) {
      continue;
    }

    filteredPupils.add(pupil);
  }
  return filteredPupils;
}
