import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_content_view.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_head_widget.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_navigation.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileView extends WatchingWidget {
  final PupilProfileController controller;
  const PupilProfileView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pupilProfileNavState =
        watchValue((BottomNavManager x) => x.pupilProfileNavState);

    final PupilProxy pupil = watchValue((PupilManager x) => x.pupils)
        .firstWhere((element) =>
            element.internalId == controller.widget.pupil.internalId);
    // final pupil = findPupilById(controller.widget.pupil.internalId);
    final List<Admonition> admonitions = List.from(pupil.pupilAdmonitions!);
    admonitions.sort((a, b) => b.admonishedDay.compareTo(a.admonishedDay));
    return Scaffold(
      backgroundColor: canvasColor,
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<PupilManager>().fetchThesePupils([pupil]),
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
                                statusBarColor: backgroundColor),
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
                              title: PupilProfileHeadWidget(
                                  pupil: pupil,
                                  pupilProfileController: controller),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: pupilProfileContentView(
                                pupil, admonitions, context, controller),
                          ),
                          const SliverGap(60),
                        ],
                      ),
                    ),
                    pupilProfileNavigation(
                      controller,
                      pupilProfileNavState,

                      MediaQuery.of(context).size.width,
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
