import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/authorizations/pages/authorizations_list_page/authorizations_list_page.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/main_menu_button.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_list_pupils_page/school_list_pupils_page.dart';
import 'package:schuldaten_hub/features/school_lists/pages/school_lists_page/school_lists_page.dart';

import 'package:watch_it/watch_it.dart';

class SchoolListsMenuPage extends WatchingWidget {
  const SchoolListsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          locale.checkLists,
          style: appBarTextStyle,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 380,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MainMenuButton(
                  destinationPage: const SchoolListsPage(),
                  buttonIcon: const Icon(
                    Icons.rule,
                    size: 50,
                    color: gridViewColor,
                  ),
                  buttonText: locale.lists),
              MainMenuButton(
                  destinationPage: const AuthorizationsListPage(),
                  buttonIcon: const Icon(
                    Icons.fact_check_rounded,
                    size: 50,
                    color: gridViewColor,
                  ),
                  buttonText: locale.authorizations)
            ],
          ),
        ),
      ),
    );
  }
}
