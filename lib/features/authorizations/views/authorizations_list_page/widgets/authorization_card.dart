import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_page/authorization_pupils_page.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorizations_list_page/widgets/authorization_list_stats_row.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationCard extends WatchingWidget {
  final Authorization authorization;
  const AuthorizationCard({required this.authorization, super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AuthorizationPupilsPage(
                authorization,
              ),
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorization.authorizationName,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: interactiveColor),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 250,
                    child: Text(
                      authorization.authorizationDescription,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Gap(5),
                  authorizationStatsRow(authorization, pupils),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
