import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/sliver_app_bar.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_pupil_filters.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupil_list_searchbar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupil_card.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupils_bottom_navbar.dart';

import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsPage extends WatchingWidget {
  final Authorization authorization;

  const AuthorizationPupilsPage(this.authorization, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<PupilProxy> filteredPupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);

    List<PupilProxy> pupilsInList =
        addAuthorizationFiltersToFilteredPupils(filteredPupils, authorization);

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
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  SliverSearchAppBar(
                    height: 110,
                    title: AuthorizationPupilListSearchBar(
                        filtersOn: filtersOn, pupils: pupilsInList),
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
                                  authorization.authorizationId);
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
        filtersOn: filtersOn,
        pupilsInAuthorization: pupilIdsFromPupils(pupilsInList),
      ),
    );
  }
}
