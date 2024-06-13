import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/common/widgets/filter_button.dart';
import 'package:schuldaten_hub/features/pupil/pages/special_info_page/widgets/special_info_filter_bottom_sheet.dart';

class SpecialInfoListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  const SpecialInfoListPageBottomNavBar({required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
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
              const FilterButton(
                isSearchBar: false,
                showBottomSheetFunction: showSpecialInfoFilterBottomSheet,
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
