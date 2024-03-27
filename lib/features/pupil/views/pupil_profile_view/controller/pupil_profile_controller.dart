import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/pupil_profile_view.dart';

class PupilProfile extends StatefulWidget {
  final Pupil pupil;

  const PupilProfile(
    this.pupil, {
    Key? key,
  }) : super(key: key);

  @override
  PupilProfileController createState() => PupilProfileController();
}

class PupilProfileController extends State<PupilProfile> {
  final CustomExpansionTileController infoTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController languageTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController creditTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController attendanceTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController admonitionTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController ogsTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController learningSupportTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController learningTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController pupilSchoolListTileController =
      CustomExpansionTileController();
  final CustomExpansionTileController pupilAuthoritationTileController =
      CustomExpansionTileController();

  Color navigationBackgroundColor(int page) {
    return page == locator<BottomNavManager>().pupilProfileNavState.value
        ? Colors.white
        : backgroundColor;
  }

  Color navigationBackgroundActive = accentColor;
  Color navigationIconInactive = Colors.white;
  Color navigationIconActive = Colors.white;

  void expandTile(int tile) {
    List<CustomExpansionTileController> tileControllers = [
      infoTileController,
      languageTileController,
      creditTileController,
      attendanceTileController,
      admonitionTileController,
      ogsTileController,
      learningSupportTileController,
      learningTileController,
      pupilSchoolListTileController,
      pupilAuthoritationTileController
    ];

    for (int i = 0; i < tileControllers.length; i++) {
      if (i == tile) {
        tileControllers[i].isExpanded
            ? tileControllers[i].collapse()
            : tileControllers[i].expand();
        continue;
      }
      tileControllers[i].collapse();
    }
  }

  deleteAvatar() async {
    await locator<PupilManager>().deleteAvatarImage(
        widget.pupil.internalId, widget.pupil.internalId.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
      ),
    );
    return PupilDetailsView(this);
  }
}
