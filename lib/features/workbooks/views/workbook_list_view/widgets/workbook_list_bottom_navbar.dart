import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/workbooks/views/new_workbook_view/new_workbook_view.dart';

BottomAppBar workbookListBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          const Spacer(),
          IconButton(
            tooltip: 'zurück',
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Gap(15),
          IconButton(
            tooltip: 'Neues Arbeitsheft',
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewWorkbookView(null, null, null, null),
              ));
            },
          ),
          const Gap(15)
        ],
      ),
    ),
  );
}
