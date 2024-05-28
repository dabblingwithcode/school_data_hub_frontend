import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/pupil_schoolday_event_content_list.dart';

class PupilSchooldayEventsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilSchooldayEventsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color.fromARGB(255, 239, 66, 66),
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const SchooldayEventListPage(),
                ));
              },
              child: const Text('Ereignisse',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            )
          ]),
          const Gap(15),
          SchooldayEventsContentList(pupil: pupil),
        ]),
      ),
    );
  }
}
