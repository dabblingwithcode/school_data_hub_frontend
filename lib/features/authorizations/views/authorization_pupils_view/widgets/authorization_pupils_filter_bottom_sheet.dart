import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsFilterBottomSheet extends WatchingWidget {
  const AuthorizationPupilsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    bool valueYesResponse =
        activeFilters[PupilFilter.authorizationYesResponse]!;
    bool valueNoResponse = activeFilters[PupilFilter.authorizationNoResponse]!;
    bool valueNullResponse =
        activeFilters[PupilFilter.authorizationNullResponse]!;
    bool valueCommentResponse =
        activeFilters[PupilFilter.authorizationCommentResponse]!;
    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          filterHeading(),
          standardFilters(activeFilters),
          const Row(
            children: [
              Text(
                'Antwort:',
                style: subtitle,
              )
            ],
          ),
          const Gap(5),
          Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Ja',
                  style: filterItemsTextStyle,
                ),
                selected: valueYesResponse,
                onSelected: (val) {
                  filterLocator.setFilter(
                      PupilFilter.authorizationYesResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.authorizationNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationNullResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationCommentResponse, false);
                  }
                },
              ),
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Nein',
                  style: filterItemsTextStyle,
                ),
                selected: valueNoResponse,
                onSelected: (val) {
                  filterLocator.setFilter(
                      PupilFilter.authorizationNoResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.authorizationYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationNullResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationCommentResponse, false);
                  }
                },
              ),
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'keine Antwort',
                  style: filterItemsTextStyle,
                ),
                selected: valueNullResponse,
                onSelected: (val) {
                  filterLocator.setFilter(
                      PupilFilter.authorizationNullResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.authorizationYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationCommentResponse, false);
                  }
                },
              ),
              FilterChip(
                padding: filterChipPadding,
                labelPadding: filterChipLabelPadding,
                shape: filterChipShape,
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Kommentar',
                  style: filterItemsTextStyle,
                ),
                selected: valueCommentResponse,
                onSelected: (val) {
                  filterLocator.setFilter(
                      PupilFilter.authorizationCommentResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.authorizationYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.authorizationNullResponse, false);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

showAuthorizationPupilsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const AuthorizationPupilsFilterBottomSheet(),
  );
}
