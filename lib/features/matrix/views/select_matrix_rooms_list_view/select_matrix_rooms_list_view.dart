import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/controller/select_matrix_rooms_list_controller.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/widgets/select_matrix_room_card.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/widgets/select_matrix_rooms_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/matrix/views/select_matrix_rooms_list_view/widgets/select_room_list_searchbar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixRoomsListView extends WatchingWidget {
  final SelectMatrixRoomsListController controller;
  final List<MatrixRoom> filteredRoomsInLIst;
  const SelectMatrixRoomsListView(this.controller, this.filteredRoomsInLIst,
      {Key? key})
      : super(key: key);

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
            Text('Räume auswählen', style: appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  scrolledUnderElevation: null,
                  automaticallyImplyLeading: false,
                  leading: const SizedBox.shrink(),
                  backgroundColor: Colors.transparent,
                  collapsedHeight: 110,
                  expandedHeight: 110.0,
                  stretch: false,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    collapseMode: CollapseMode.none,
                    title: selectRoomListSearchBar(
                        context, filteredRoomsInLIst, controller, filtersOn),
                  ),
                ),
                filteredRoomsInLIst.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Keine Ergebnisse',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Your list view items go here
                            return SelectMatrixRoomCard(
                                controller, filteredRoomsInLIst[index]);
                          },
                          childCount: filteredRoomsInLIst.length,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          selectMatrixRoomsListViewBottomNavBar(context, controller, filtersOn),
    );
  }
}
