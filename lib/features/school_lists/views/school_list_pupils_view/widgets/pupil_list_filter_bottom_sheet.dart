import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilListFilterBottomSheet extends WatchingWidget {
  const PupilListFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    bool valueYesResponse = activeFilters[PupilFilter.schoolListYesResponse]!;
    bool valueNoResponse = activeFilters[PupilFilter.schoolListNoResponse]!;
    bool valueNullResponse = activeFilters[PupilFilter.schoolListNullResponse]!;
    bool valueCommentResponse =
        activeFilters[PupilFilter.schoolListCommentResponse]!;
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
                      PupilFilter.schoolListYesResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.schoolListNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListNullResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListCommentResponse, false);
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
                      PupilFilter.schoolListNoResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.schoolListYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListNullResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListCommentResponse, false);
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
                      PupilFilter.schoolListNullResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.schoolListYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListCommentResponse, false);
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
                      PupilFilter.schoolListCommentResponse, val);

                  if (val) {
                    filterLocator.setFilter(
                        PupilFilter.schoolListYesResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListNoResponse, false);
                    filterLocator.setFilter(
                        PupilFilter.schoolListNullResponse, false);
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

showPupilListFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const PupilListFilterBottomSheet(),
  );
}

// showPupilListFilterBottomSheet(BuildContext context, activeFilters) {
//   bool valueA1 = activeFilters[PupilFilter.A1]!;
//   bool valueA2 = activeFilters[PupilFilter.A2]!;
//   bool valueA3 = activeFilters[PupilFilter.A3]!;
//   bool valueB1 = activeFilters[PupilFilter.B1]!;
//   bool valueB2 = activeFilters[PupilFilter.B2]!;
//   bool valueB3 = activeFilters[PupilFilter.B3]!;
//   bool valueB4 = activeFilters[PupilFilter.B4]!;
//   bool valueC1 = activeFilters[PupilFilter.C1]!;
//   bool valueC2 = activeFilters[PupilFilter.C2]!;
//   bool valueC3 = activeFilters[PupilFilter.C3]!;
//   bool valueE1 = activeFilters[PupilFilter.E1]!;
//   bool valueE2 = activeFilters[PupilFilter.E2]!;
//   bool valueE3 = activeFilters[PupilFilter.E3]!;
//   bool valueS3 = activeFilters[PupilFilter.S3]!;
//   bool valueS4 = activeFilters[PupilFilter.S4]!;

//   final filterLocator = locator<PupilFilterManager>();

//   return showModalBottomSheet(
//       constraints: const BoxConstraints(maxWidth: 800),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const Text(
//                     'Filter',
//                     style: title,
//                   ),
//                   const Spacer(),
//                   IconButton.filled(
//                       iconSize: 35,
//                       color: Colors.amber,
//                       onPressed: () {
//                         locator<PupilFilterManager>().resetFilters();

//                         //Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.restart_alt_rounded)),
//                 ],
//               ),
//               const Row(
//                 children: [
//                   Text(
//                     'Jahrgang',
//                     style: subtitle,
//                   )
//                 ],
//               ),
//               const Gap(5),
//               Wrap(
//                 spacing: 5,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'E1',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueE1,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.E1, val);
//                           controller(() {
//                             valueE1 = filterLocator
//                                 .filterState.value[PupilFilter.E1]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'E2',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueE2,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.E2, val);
//                           controller(() {
//                             valueE2 = filterLocator
//                                 .filterState.value[PupilFilter.E2]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'E3',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueE3,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.E3, val);
//                           controller(() {
//                             valueE3 = filterLocator
//                                 .filterState.value[PupilFilter.E3]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'S3',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueS3,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.S3, val);
//                           controller(() {
//                             valueS3 = filterLocator
//                                 .filterState.value[PupilFilter.S3]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'S4',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueS4,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.S4, val);
//                           controller(() {
//                             valueS4 = filterLocator
//                                 .filterState.value[PupilFilter.S4]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const Row(
//                 children: [
//                   Text(
//                     'Klasse',
//                     style: subtitle,
//                   )
//                 ],
//               ),
//               const Gap(5),
//               Wrap(
//                 spacing: 5,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'A1',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueA1,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.A1, val);
//                           controller(() {
//                             valueA1 = filterLocator
//                                 .filterState.value[PupilFilter.A1]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'A2',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueA2,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.A2, val);
//                           controller(() {
//                             valueA2 = filterLocator
//                                 .filterState.value[PupilFilter.A2]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'A3',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueA3,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.A3, val);
//                           controller(() {
//                             valueA3 = filterLocator
//                                 .filterState.value[PupilFilter.A3]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'B1',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueB1,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.B1, val);
//                           controller(() {
//                             valueB1 = filterLocator
//                                 .filterState.value[PupilFilter.B1]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'B2',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueB2,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.B2, val);
//                           controller(() {
//                             valueB2 = filterLocator
//                                 .filterState.value[PupilFilter.B2]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'B3',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueB3,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.B3, val);
//                           controller(() {
//                             valueB3 = filterLocator
//                                 .filterState.value[PupilFilter.B3]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'B4',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueB4,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.B4, val);
//                           controller(() {
//                             valueB4 = filterLocator
//                                 .filterState.value[PupilFilter.B4]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'C1',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueC1,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.C1, val);
//                           controller(() {
//                             valueC1 = filterLocator
//                                 .filterState.value[PupilFilter.C1]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'C2',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueC2,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.C2, val);
//                           controller(() {
//                             valueC2 = filterLocator
//                                 .filterState.value[PupilFilter.C2]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                   StatefulBuilder(
//                     builder: (BuildContext context, controller) {
//                       return FilterChip(
//                         selectedColor: filterChipSelectedColor,
//                         checkmarkColor: filterChipSelectedCheckColor,
//                         backgroundColor: filterChipUnselectedColor,
//                         label: const Text(
//                           'C3',
//                           style: filterItemsTextStyle,
//                         ),
//                         selected: valueC3,
//                         onSelected: (val) {
//                           filterLocator.setFilter(PupilFilter.C3, val);
//                           controller(() {
//                             valueC3 = filterLocator
//                                 .filterState.value[PupilFilter.C3]!;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       });
// }
