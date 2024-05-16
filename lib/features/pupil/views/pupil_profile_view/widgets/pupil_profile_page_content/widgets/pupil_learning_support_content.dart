import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_view/learning_support_list_page.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_page_content/widgets/pupil_profile_learning_support_content.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilLearningSupportContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningSupportContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(
              Icons.support_rounded,
              color: Colors.red,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const LearningSupportListPage(),
                ));
              },
              child: const Text('Förderung',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                informationDialog(
                    context,
                    'Förderplan ausdrucken noch nicht freigeschaltet',
                    'Es wird daran gearbeitet - noch ein bisschen Geduld!');
                // await generatePdf(pupil.internalId);
              },
              icon: const Icon(Icons.print_rounded),
              color: backgroundColor,
              iconSize: 24,
            ),
          ]),
          const Gap(15),
          ...pupilLearningSupportContentList(pupil, context),
        ]),
      ),
    );
  }
}
