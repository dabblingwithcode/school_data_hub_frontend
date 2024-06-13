import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/common/widgets/filter_button.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/features/credit/credit_list_page/widgets/credit_filter_bottom_sheet.dart';

class CreditListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  const CreditListPageBottomNavBar({required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget creditListViewBottomNavBar(BuildContext context, bool filtersOn) {
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
              const FilterButton(
                  isSearchBar: false,
                  showBottomSheetFunction: showCreditFilterBottomSheet),
              const Gap(15)
            ],
          ),
        ),
      ),
    ),
  );
}
