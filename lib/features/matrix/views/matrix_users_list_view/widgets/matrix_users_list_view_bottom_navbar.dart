import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/credit/widgets/credit_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/matrix/views/new_matrix_user_view.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_view/controller/room_list_controller.dart';

import '../../../../pupil/services/pupil_filter_manager.dart';

Widget matrixUsersListViewBottomNavBar(
  BuildContext context,
  bool filtersOn,
) {
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
                tooltip: 'neues Matrix-Konto',
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const NewMatrixUserView(),
                  ));
                },
              ),
              const Gap(20),
              IconButton(
                tooltip: 'Matrix-Räume',
                icon: const Icon(
                  Icons.meeting_room_rounded,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const RoomList(),
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
                onTap: () => showCreditFilterBottomSheet(context),
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
