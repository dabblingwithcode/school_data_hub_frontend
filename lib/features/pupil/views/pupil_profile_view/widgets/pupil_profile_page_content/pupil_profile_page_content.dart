import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_attendance_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_authorizations_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_credit_content.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_infos_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_communication_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_learning_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_learning_support_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_ogs_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_school_lists_content.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_schoolday_events_content.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';

class PupilProfilePageContent extends StatelessWidget {
  final PupilProxy pupil;
  final List<SchooldayEvent> schooldayEvents;

  const PupilProfilePageContent(
      {required this.pupil, required this.schooldayEvents, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (locator<BottomNavManager>().pupilProfileNavState.value == 0)
            PupilInfosContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 1)
            PupilCommunicationContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 2)
            PupilCreditContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 3)
            PupilAttendanceContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 4)
            PupilSchooldayEventsContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 5)
            PupilOgsContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 6)
            PupilSchoolListsContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 7)
            PupilAuthorizationsContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 8)
            PupilLearningSupportContent(pupil: pupil),
          if (locator<BottomNavManager>().pupilProfileNavState.value == 9)
            PupilLearningContent(pupil: pupil),
          const Gap(20),
        ],
      ),
    );
  }
}
