import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/matrix/views/matrix_users_list_view/controller/matrix_user_list_controller.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_view/widgets/room_list_filter_bottom_sheet.dart';

import '../../../../pupil/services/pupil_filter_manager.dart';

Widget roomListViewBottomNavBar(BuildContext context, bool filtersOn) {
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
              const Gap(20),
              IconButton(
                tooltip: 'Neuer Raum',
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => const MatrixUsersList(),
                  // ));
                },
              ),
              const Gap(20),
              IconButton(
                tooltip: 'Matrix-Konten',
                icon: const Icon(
                  Icons.people_alt_rounded,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const MatrixUsersList(),
                  ));
                },
              ),
              const Gap(20),
              IconButton(
                  tooltip: 'Zur Startseite',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  icon: const Icon(
                    Icons.home,
                    size: 35,
                  )),
              const Gap(20),
              InkWell(
                onTap: () => showRoomsFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
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
