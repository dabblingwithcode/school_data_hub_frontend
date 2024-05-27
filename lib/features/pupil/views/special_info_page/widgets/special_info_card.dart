import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_page/pupil_profile_page.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoCard extends WatchingWidget {
  final PupilProxy pupil;
  const SpecialInfoCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Row(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => PupilProfilePage(
                                          pupil: pupil,
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      '${pupil.firstName} ${pupil.lastName}',
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
                          const Row(
                            children: [
                              Text('Besondere Informationen:'),
                              Gap(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 15),
                          child: Text(
                            pupil.specialInformation ?? 'keine Infos',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
