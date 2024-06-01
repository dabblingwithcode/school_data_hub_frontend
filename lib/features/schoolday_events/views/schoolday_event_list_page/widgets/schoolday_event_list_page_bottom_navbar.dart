import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';

import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';

class SchooldayEventListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  const SchooldayEventListPageBottomNavBar(
      {required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Scan Kinder-IDs',
                  icon: const Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 30,
                  ),
                  onPressed: () {
                    locator<PupilIdentityManager>()
                        .scanNewPupilIdentities(context);
                  },
                ),
                const Gap(30),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    constraints: const BoxConstraints(maxWidth: 800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    context: context,
                    builder: (_) => const SchooldayEventFilterBottomSheet(),
                  ),
                  onLongPress: () {
                    locator<SchooldayEventFilterManager>().resetFilters();
                    locator<PupilsFilter>().resetFilters();
                  },
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
      ),
    );
  }
}
