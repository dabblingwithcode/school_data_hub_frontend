import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/pupil_profile_page_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_head_widget.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePage extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
      ),
    );

    return Scaffold(
      backgroundColor: canvasColor,
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().updatePupilList([pupil]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5, right: 5),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        dragStartBehavior: DragStartBehavior.down,
                        slivers: [
                          SliverAppBar(
                            systemOverlayStyle: const SystemUiOverlayStyle(
                                statusBarColor: canvasColor),
                            pinned: false,
                            floating: true,
                            scrolledUnderElevation: null,
                            automaticallyImplyLeading: false,
                            leading: null,
                            backgroundColor: canvasColor,
                            collapsedHeight: 140,
                            expandedHeight: 140.0,
                            stretch: false,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              expandedTitleScale: 1,
                              collapseMode: CollapseMode.none,
                              titlePadding: const EdgeInsets.only(
                                  left: 5, top: 5, right: 5, bottom: 5),
                              title: PupilProfileHeadWidget(pupil: pupil),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: PupilProfilePageContent(
                              pupil: pupil,
                            ),
                          ),
                          const SliverGap(60),
                        ],
                      ),
                    ),
                    PupilProfileNavigation(
                      boxWidth: MediaQuery.of(context).size.width,
                      //MediaQuery.of(context).size.width / 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarProfileLayout(
          bottomNavBar: PupilProfileBottomNavBar()),
    );
  }
}
