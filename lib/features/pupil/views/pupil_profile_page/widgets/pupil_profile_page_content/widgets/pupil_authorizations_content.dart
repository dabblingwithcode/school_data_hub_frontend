import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorizations_list_page/authorizations_list_page.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_page/widgets/pupil_authorizations_content_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilAuthorizationsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilAuthorizationsContent({required this.pupil, super.key});

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
              Icons.fact_check_rounded,
              color: backgroundColor,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AuthorizationsListPage(),
                ));
              },
              child: const Text('Einwilligungen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            )
          ]),
          const Gap(15),
          PupilAuthorizationsContentList(pupil: pupil),
        ]),
      ),
    );
  }
}
