import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/credit/services/credit_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/credit/credit_list_page/widgets/credit_filter_bottom_sheet.dart';

class CreditListSearchBar extends StatelessWidget {
  final List<PupilProxy> pupils;
  final bool filtersOn;
  const CreditListSearchBar(
      {required this.pupils, required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
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
                    pupils.length.toString(),
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
                  Text(
                    totalGeneratedCredit(pupils).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'in Umlauf: ',
                    style: TextStyle(
                        fontSize: 13,
                        color: backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  Text(
                    totalFluidCredit(pupils).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
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
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: locator<PupilsFilter>().refreshs)),
                InkWell(
                  onTap: () => showCreditFilterBottomSheet(context),
                  onLongPress: () => locator<PupilsFilter>().resetFilters(),
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
}
