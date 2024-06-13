import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/sliver_search_app_bar.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/pages/authorization_pupils_page/widgets/authorization_pupil_list_searchbar.dart';
import 'package:schuldaten_hub/features/authorizations/filters/pupil_authorization_filters.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/pages/authorization_pupils_page/widgets/authorization_pupil_card.dart';
import 'package:schuldaten_hub/features/authorizations/pages/authorization_pupils_page/widgets/authorization_pupils_bottom_navbar.dart';

import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsPage extends WatchingWidget {
  final Authorization authorization;

  const AuthorizationPupilsPage(this.authorization, {super.key});

  @override
  Widget build(BuildContext context) {
    final filters = watchValue((PupilFilterManager x) => x.filterState);

    final thisAuthorization =
        watchValue((AuthorizationManager x) => x.authorizations).firstWhere(
            (authorization) =>
                authorization.authorizationId ==
                this.authorization.authorizationId);

    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);

    final List<PupilAuthorization> pupilAuthorizations =
        addAuthorizationFiltersToPupilAuthorizations(
            thisAuthorization.authorizedPupils);

    List<PupilProxy> pupilsInList = filteredPupils
        .where((pupil) => pupilAuthorizations
            .any((pupilAuth) => pupilAuth.pupilId == pupil.internalId))
        .toList();

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list, color: Colors.white),
            const Gap(5),
            Text(authorization.authorizationName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<AuthorizationManager>().fetchAuthorizations(),
        child: Center(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  SliverSearchAppBar(
                    height: 110,
                    title:
                        AuthorizationPupilListSearchBar(pupils: pupilsInList),
                  ),
                  pupilsInList.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Keine Ergebnisse',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // Your list view items go here
                              return AuthorizationPupilCard(
                                  pupilsInList[index].internalId,
                                  authorization);
                            },
                            childCount: pupilsInList
                                .length, // Adjust this based on your data
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AuthorizationPupilsBottomNavBar(
        authorization: authorization,
        pupilsInAuthorization:
            locator<PupilManager>().pupilIdsFromPupils(pupilsInList),
      ),
    );
  }
}
