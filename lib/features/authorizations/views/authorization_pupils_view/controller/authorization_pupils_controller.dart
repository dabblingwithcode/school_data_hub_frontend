import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';

import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/authorization_pupils_view.dart';

class AuthorizationPupils extends StatefulWidget {
  final Authorization authorization;

  const AuthorizationPupils(
    this.authorization, {
    Key? key,
  }) : super(key: key);

  @override
  AuthorizationPupilsController createState() =>
      AuthorizationPupilsController();
}

class AuthorizationPupilsController extends State<AuthorizationPupils> {
  FocusNode focusNode = FocusNode();

  final filterLocator = locator<PupilFilterManager>();

  @override
  void initState() {
    //locator<PupilFilterManager>().refreshFilteredPupils();
    super.initState();
  }

  List<Pupil> addAuthorizationFiltersToFilteredPupils(List<Pupil> pupils) {
    List<Pupil> filteredPupils = [];
    for (Pupil pupil in pupils) {
      bool toList = true;
      // Check first if the filtered pupil is in the authorization. If not, continue with next one.
      final PupilAuthorization? pupilAuthorization = pupil.authorizations!
          .firstWhereOrNull((pupilAuthorization) =>
              pupilAuthorization.originAuthorization ==
              widget.authorization.authorizationId);
      if (pupilAuthorization == null) {
        continue;
      }
      // This one is - let's apply the authorization filters
      if (filterLocator
              .filterState.value[PupilFilter.authorizationYesResponse]! &&
          pupilAuthorization.status == true) {
        toList = true;
      } else if (!filterLocator
          .filterState.value[PupilFilter.authorizationYesResponse]!) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationNoResponse]! &&
          pupilAuthorization.status == false) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationNoResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationNullResponse]! &&
          pupilAuthorization.status == null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationNullResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationCommentResponse]! &&
          pupilAuthorization.status != null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationCommentResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (toList) {
        filteredPupils.add(pupil);
      }
    }
    return filteredPupils;
  }

  @override
  Widget build(BuildContext context) {
    return AuthorizationPupilsView(this, widget.authorization);
  }
}
