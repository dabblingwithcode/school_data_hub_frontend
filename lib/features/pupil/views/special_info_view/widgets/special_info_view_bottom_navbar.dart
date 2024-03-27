import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/special_info_view/widgets/special_info_reset_filter_button.dart';

BottomAppBar specialInfoViewBottomNavBar(BuildContext context, bool filtersOn) {
  return BottomAppBar(
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
              locator<PupilBaseManager>().scanNewPupilBase(context);
            },
          ),
          const Gap(30),
          specialInfoResetFilterButton(context, filtersOn),
          const Gap(10)
        ],
      ),
    ),
  );
}
