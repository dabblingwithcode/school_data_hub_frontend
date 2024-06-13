import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';
import 'package:schuldaten_hub/features/workbooks/pages/workbook_list_page/workbook_list_view.dart';

class WorkbookList extends StatefulWidget {
  const WorkbookList({
    super.key,
  });

  @override
  WorkbookController createState() => WorkbookController();
}

class WorkbookController extends State<WorkbookList> {
  @override
  void initState() {
    locator<WorkbookManager>().getWorkbooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WorkbookListView(this);
  }
}
