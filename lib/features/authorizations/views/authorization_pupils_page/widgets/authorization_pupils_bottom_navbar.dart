import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_page/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsBottomNavBar extends WatchingWidget {
  final Authorization authorization;

  final List<int> pupilsInAuthorization;
  const AuthorizationPupilsBottomNavBar(
      {required this.pupilsInAuthorization,
      required this.authorization,
      super.key});

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((PupilsFilter x) => x.filtersOn);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
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
              const Gap(30),
              locator<SessionManager>().credentials.value.username ==
                      authorization.createdBy
                  ? IconButton(
                      tooltip: 'Kinder hinzufügen',
                      icon:
                          const Icon(Icons.add, color: Colors.white, size: 30),
                      onPressed: () async {
                        final List<int>? selectedPupilIds =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SelectPupilsListPage(
                              selectablePupils: locator<PupilManager>()
                                  .restOfPupils(pupilsInAuthorization)),
                        ));
                        if (selectedPupilIds == null) {
                          return;
                        }
                        if (selectedPupilIds.isNotEmpty) {
                          locator<AuthorizationManager>()
                              .postPupilAuthorizations(selectedPupilIds,
                                  authorization.authorizationId);
                        }
                      })
                  : const SizedBox.shrink(),
              const Gap(10),
              InkWell(
                onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
                onLongPress: () => locator<PupilsFilter>().resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(10)
            ],
          ),
        ),
      ),
    );
  }
}

BottomAppBar authorizationPupilsBottomNavBar(
    BuildContext context,
    Authorization authorization,
    bool filtersOn,
    List<int> pupilsInAuthorization) {
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
          const Gap(30),
          locator<SessionManager>().credentials.value.username ==
                  authorization.createdBy
              ? IconButton(
                  tooltip: 'Kinder hinzufügen',
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () async {
                    final List<int>? selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SelectPupilsListPage(
                          selectablePupils: locator<PupilManager>()
                              .restOfPupils(pupilsInAuthorization)),
                    ));
                    if (selectedPupilIds == null) {
                      return;
                    }
                    if (selectedPupilIds.isNotEmpty) {
                      locator<AuthorizationManager>().postPupilAuthorizations(
                          selectedPupilIds, authorization.authorizationId);
                    }
                  })
              : const SizedBox.shrink(),
          const Gap(10),
          InkWell(
            onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
            onLongPress: () => locator<PupilsFilter>().resetFilters(),
            child: Icon(
              Icons.filter_list,
              color: filtersOn ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
          ),
          const Gap(10)
        ],
      ),
    ),
  );
}
