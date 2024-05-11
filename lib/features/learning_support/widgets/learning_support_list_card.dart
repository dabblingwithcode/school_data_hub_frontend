import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/common/widgets/list_tile.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_view/controller/learning_support_list_controller.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/dialogs/individual_development_plan_dialog.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_goal_list.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/learning_support_goals_batches.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportCard extends WatchingStatefulWidget {
  final LearningSupportListController controller;
  final PupilProxy passedPupil;
  const LearningSupportCard(this.controller, this.passedPupil, {super.key});

  @override
  State<LearningSupportCard> createState() => _LearningSupportCardState();
}

class _LearningSupportCardState extends State<LearningSupportCard> {
  final CustomExpansionTileController _tileController =
      CustomExpansionTileController();
  @override
  Widget build(BuildContext context) {
    PupilProxy pupil = widget.passedPupil;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                locator<BottomNavManager>()
                                    .setPupilProfileNavPage(8);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => PupilProfile(
                                    pupil,
                                  ),
                                ));
                              },
                              child: Text(
                                '${pupil.firstName!} ${pupil.lastName!}',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Text('ärztl. U.:'),
                        const Gap(10),
                        Text(
                          widget.controller
                              .preschoolRevision(pupil.preschoolRevision!),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    if (pupil.pupilCategoryStatuses!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          _tileController.isExpanded
                              ? _tileController.collapse()
                              : _tileController.expand();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...learningSupportCategoryStatusBatches(pupil),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const Gap(8),
              InkWell(
                onTap: () {
                  _tileController.isExpanded
                      ? _tileController.collapse()
                      : _tileController.expand();
                },
                onLongPress: () async {
                  individualDevelopmentPlanDialog(
                      context, pupil, pupil.individualDevelopmentPlan);
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Ebene'),
                    Center(
                      child: Text(
                        pupil.individualDevelopmentPlan.toString(),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                    Text(
                      pupil.specialNeeds != null
                          ? pupil.specialNeeds!.length == 4
                              ? '${pupil.specialNeeds!.substring(0, 2)} ${pupil.specialNeeds!.substring(2, 4)}'
                              : pupil.specialNeeds!.substring(0, 2)
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: groupColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(15),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: listTiles(
                null,
                context,
                _tileController,
                learningSupportGoalList(
                  context,
                  pupil,
                )),
          )
        ],
      ),
    );
  }
}
