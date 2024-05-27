import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_attendance_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_authorizations_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_credit_content.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_infos_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_communication_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_learning_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_learning_support_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_ogs_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_school_lists_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_schoolday_events_content.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePageContent extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    int navState = watchValue((BottomNavManager x) => x.pupilProfileNavState);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (navState == 0) PupilInfosContent(pupil: pupil),
          if (navState == 1) PupilCommunicationContent(pupil: pupil),
          if (navState == 2) PupilCreditContent(pupil: pupil),
          if (navState == 3) PupilAttendanceContent(pupil: pupil),
          if (navState == 4) PupilSchooldayEventsContent(pupil: pupil),
          if (navState == 5) PupilOgsContent(pupil: pupil),
          if (navState == 6) PupilSchoolListsContent(pupil: pupil),
          if (navState == 7) PupilAuthorizationsContent(pupil: pupil),
          if (navState == 8) PupilLearningSupportContent(pupil: pupil),
          if (navState == 9) PupilLearningContent(pupil: pupil),
          const Gap(20),
        ],
      ),
    );
  }
}
