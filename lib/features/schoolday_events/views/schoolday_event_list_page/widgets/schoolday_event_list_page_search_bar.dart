import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter_impl.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_helper_functions.dart';
import 'package:schuldaten_hub/features/schoolday_events/views/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventListSearchBar extends WatchingWidget {
  const SchooldayEventListSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils =
        watchValue((PupilsFilterImplementation x) => x.filteredPupils);
    final filtersOn = watchValue((PupilsFilterImplementation f) => f.filtersOn);

    return Container(
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.00),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_alt_rounded,
                      color: backgroundColor,
                    ),
                    const Gap(10),
                    Text(
                      pupils.length.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'gesamt:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      SchoolEventHelper.getSchooldayEventCount(pupils)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Schule:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      SchoolEventHelper.getSchoolSchooldayEventCount(pupils)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'OGS:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    Text(
                        SchoolEventHelper.getOgsSchooldayEventCount(pupils)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                    child: SearchTextField(
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: locator<PupilFilterManager>()
                            .refreshFilteredPupils)),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    constraints: const BoxConstraints(maxWidth: 800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    context: context,
                    builder: (_) => const SchooldayEventFilterBottomSheet(),
                  ),
                  onLongPress: () =>
                      locator<PupilFilterManager>().resetFilters(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Colors.deepOrange : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
