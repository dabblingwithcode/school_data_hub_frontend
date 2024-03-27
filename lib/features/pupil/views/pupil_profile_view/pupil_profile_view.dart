import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_content_view.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_head_widget.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_navigation.dart';
import 'package:watch_it/watch_it.dart';

class PupilDetailsView extends WatchingWidget {
  final PupilProfileController controller;
  const PupilDetailsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pupilProfileNavState =
        watchValue((BottomNavManager x) => x.pupilProfileNavState);
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final passedPupil = controller.widget.pupil;
    final pupil = pupils
        .firstWhere((element) => element.internalId == passedPupil.internalId);
    final List<Admonition> admonitions = List.from(pupil.pupilAdmonitions!);
    admonitions.sort((a, b) => b.admonishedDay.compareTo(a.admonishedDay));
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<PupilManager>().fetchThesePupils([pupil]),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5, right: 5),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
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
                            title: pupilProfileHeadWidget(
                                pupil, context, controller),
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
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: pupilProfileNavigation(
                        controller,
                        pupilProfileNavState,
                        MediaQuery.of(context).size.width / 5)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: pupilProfileBottomNavBar(context)),
    );
  }
}
