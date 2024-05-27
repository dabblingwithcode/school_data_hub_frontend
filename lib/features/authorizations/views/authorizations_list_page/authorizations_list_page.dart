import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorizations_list_page/widgets/authorization_list_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

import 'package:schuldaten_hub/features/authorizations/views/authorizations_list_page/widgets/authorization_card.dart';

import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationsListPage extends WatchingWidget {
  const AuthorizationsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    List<Authorization> authorizations =
        watchValue((AuthorizationManager x) => x.authorizations);

    //- TODO: implement slivers and separate the search bar from the list

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Einwilligungen',
              style: appBarTextStyle,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<AuthorizationManager>().fetchAuthorizations(),
        child: authorizations.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Es wurden noch keine Eintragelisten angelegt!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 15.0, right: 10.00),
                        child: Row(
                          children: [
                            const Text(
                              'Gesamt:',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              authorizations.length.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchTextField(
                                  searchType: SearchType.authorization,
                                  hintText: 'Liste suchen',
                                  refreshFunction:
                                      locator<AuthorizationManager>()
                                          .fetchAuthorizations),
                            ),
                            //---------------------------------
                            InkWell(
                              onTap: () {},

                              onLongPress: () =>
                                  locator<PupilFilterManager>().resetFilters(),
                              // onPressed: () => showBottomSheetFilters(context),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: filtersOn
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      authorizations.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Keine Ergebnisse',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: authorizations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AuthorizationCard(
                                      authorization: authorizations[index]);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const AuthorizationListBottomNavBar(),
    );
  }
}
