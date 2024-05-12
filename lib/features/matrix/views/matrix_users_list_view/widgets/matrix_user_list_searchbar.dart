import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filters_manager.dart';
import 'package:schuldaten_hub/features/matrix/views/matrix_users_list_view/controller/matrix_user_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:schuldaten_hub/features/credit/widgets/credit_filter_bottom_sheet.dart';

Widget matrixUserListSearchBar(
    BuildContext context,
    List<MatrixUser> matrixUsers,
    MatrixUsersListController controller,
    bool filtersOn) {
  return Container(
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      children: [
        const Gap(5),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.people_alt_rounded,
                  color: backgroundColor,
                ),
                const Gap(10),
                Text(
                  matrixUsers.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Gap(10),
                const Text(
                  'BIP:',
                  style: TextStyle(
                      fontSize: 13,
                      color: backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                // Text(
                //   controller.totalGeneratedCredit(pupils).toString(),
                //   style: const TextStyle(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
                const Gap(10),
                const Text(
                  'in Umlauf: ',
                  style: TextStyle(
                      fontSize: 13,
                      color: backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                // Text(
                //   controller.totalFluidCredit(pupils).toString(),
                //   style: const TextStyle(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: SearchTextField(
                      searchType: SearchType.matrixUser,
                      hintText: 'Schüler/in suchen',
                      refreshFunction: locator<MatrixPolicyFilterManager>()
                          .filterUsersWithSearchText)),
              InkWell(
                onTap: () => showCreditFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
                // onPressed: () => showBottomSheetFilters(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
