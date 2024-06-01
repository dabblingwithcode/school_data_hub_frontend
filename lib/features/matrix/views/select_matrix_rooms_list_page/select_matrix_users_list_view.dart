import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_users_list_view/controller/select_matrix_users_list_controller.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_users_list_view/widgets/select_matrix_user_list_card.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_users_list_view/widgets/select_matrix_users_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_users_list_view/widgets/select_matrix_users_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixUsersListView extends WatchingWidget {
  final SelectMatrixUsersListController controller;
  final List<PupilProxy> filteredPupilsInLIst;
  const SelectMatrixUsersListView(this.controller, this.filteredPupilsInLIst,
      {super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        leading: controller.isSelectMode
            ? IconButton(
                onPressed: () {
                  controller.cancelSelect();
                },
                icon: const Icon(Icons.close))
            : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kind/Kinder auswählen', style: appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 15.0, right: 10.00),
                  child: Row(
                    children: [
                      const Text(
                        'Angezeigt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        filteredPupilsInLIst.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Text(
                        'Ausgewählt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        controller.selectedPupilIds.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: controller.focusNode,
                          controller: controller.searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: controller.onSearchEnter,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            hintText: 'Schüler/in suchen',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: controller.isSearchMode
                                ? IconButton(
                                    // tooltip:
                                    //     L10n.of(context)!.cancel,
                                    icon: const Icon(
                                      Icons.close_outlined,
                                    ),
                                    onPressed: controller.cancelSearch,
                                    color: Colors.black45,
                                  )
                                : const Icon(
                                    Icons.search_outlined,
                                    color: Colors.black45,
                                  ),
                            suffixIcon: controller.isSearchMode
                                ? controller.isSearching
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 12,
                                        ),
                                        child: SizedBox.square(
                                          dimension: 24,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox(
                                    width: 0,
                                  ),
                          ),
                        ),
                      ),
                      //---------------------------------
                      InkWell(
                        onTap: () =>
                            showSelectMatrixUsersFilterBottomSheet(context),
                        onLongPress: () =>
                            locator<PupilFilterManager>().resetFilters(),
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
                filteredPupilsInLIst.isEmpty
                    ? const Center(
                        child: Text('Keine Ergebnisse'),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: filteredPupilsInLIst.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SelectMatrixUserCard(
                                controller,
                                filteredPupilsInLIst[index],
                              );
                            })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          selectMatrixUsersListViewBottomNavBar(context, controller, filtersOn),
    );
  }
}
