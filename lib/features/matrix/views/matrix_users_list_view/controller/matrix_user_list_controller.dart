import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filters_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/matrix_users_list_view/matrix_users_list_view.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../pupil/models/pupil.dart';

class MatrixUsersList extends WatchingStatefulWidget {
  const MatrixUsersList({Key? key}) : super(key: key);

  @override
  MatrixUsersListController createState() => MatrixUsersListController();
}

class MatrixUsersListController extends State<MatrixUsersList> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    int userCredit = watchValue((SessionManager x) => x.credentials).credit!;
    bool filtersOn = watchValue((SearchManager x) => x.searchState);
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    List<MatrixUser> matrixUsers = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    );
    return MatrixUsersListView(
        this, userCredit, filtersOn, pupils, matrixUsers);
  }
}
