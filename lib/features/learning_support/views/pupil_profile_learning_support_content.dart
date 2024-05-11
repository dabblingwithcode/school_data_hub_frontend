import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_item_view/controller/new_category_item_controller.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_goal_list.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_statuses_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/dialogs/individual_development_plan_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/dialogs/preschool_revision_dialog.dart';

List<Widget> pupilLearningSupportContentList(
    PupilProxy pupil, BuildContext context) {
  return [
    const Row(
      children: [
        Text(
          'Eingangsuntersuchung: ',
          style: TextStyle(fontSize: 15.0),
        ),
        Gap(5),
      ],
    ),
    const Gap(10),
    Row(
      children: [
        InkWell(
          onTap: () =>
              preschoolRevisionDialog(context, pupil, pupil.preschoolRevision!),
          child: Text(
            preschoolRevisionPredicate(pupil.preschoolRevision!),
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: interactiveColor),
          ),
        )
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Förderebene:', style: TextStyle(fontSize: 15.0)),
        const Gap(10),
        InkWell(
          onTap: () => individualDevelopmentPlanDialog(
              context, pupil, pupil.individualDevelopmentPlan),
          child: Text(
            pupil.individualDevelopmentPlan == 0
                ? 'kein Eintrag'
                : pupil.individualDevelopmentPlan == 1
                    ? 'Förderebene 1'
                    : pupil.individualDevelopmentPlan == 2
                        ? 'Förderebene 2'
                        : 'Förderebene 3',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: interactiveColor),
          ),
        )
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Förderschwerpunkt: ', style: TextStyle(fontSize: 15.0)),
        const Gap(5),
        pupil.specialNeeds == '' || pupil.specialNeeds == null
            ? const Text(
                'keins',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            : Text(
                '${pupil.specialNeeds}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Text('Förderbereiche',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
    const Gap(5),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: actionButtonStyle,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewCategoryItem(
                    appBarTitle: 'Neuer Förderbereich',
                    pupilId: pupil.internalId,
                    goalCategoryId: 0,
                    elementType: 'status',
                  )));
        },
        child: const Text(
          "NEUER FÖRDERBEREICH",
          style: buttonTextStyle,
        ),
      ),
    ),
    const Gap(5),
    ...pupilCategoryStatusesList(pupil, context),
    const Row(
      children: [
        Text(
          'Förderziele',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const Gap(5),
    ...learningSupportGoalList(context, pupil),

    // const Gap(10),
    // ...buildPupilCategoryTree(context, pupil, null, 0, null),
    const Gap(15),
  ];
}
