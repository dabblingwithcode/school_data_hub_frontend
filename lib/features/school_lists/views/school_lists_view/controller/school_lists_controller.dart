import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_lists_view/school_lists_view.dart';

class SchoolLists extends StatefulWidget {
  const SchoolLists({
    Key? key,
  }) : super(key: key);

  @override
  SchoolListsController createState() => SchoolListsController();
}

class SchoolListsController extends State<SchoolLists> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    locator<SchoolListManager>().fetchSchoolLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SchoolListsView(this);
  }
}
