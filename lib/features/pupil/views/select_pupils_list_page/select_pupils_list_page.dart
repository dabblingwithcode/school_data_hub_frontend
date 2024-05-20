import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_page/widgets/select_pupils_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_page/widgets/select_pupils_list_card.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_page/widgets/select_pupils_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class SelectPupilsListPage extends WatchingStatefulWidget {
  final List<PupilProxy>? selectablePupils;

  //final List<PupilProxy> filteredPupilsInLIst;
  const SelectPupilsListPage(
      {required this.selectablePupils,
      //required this.filteredPupilsInLIst,
      Key? key})
      : super(key: key);

  @override
  State<SelectPupilsListPage> createState() => _SelectPupilsListPageState();
}

class _SelectPupilsListPageState extends State<SelectPupilsListPage> {
  List<PupilProxy>? pupils;
  List<PupilProxy>? filteredPupils;
  Map<PupilFilter, bool>? inheritedFilters;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<int> selectedPupilIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    setState(() {
      inheritedFilters = locator<PupilFilterManager>().filterState.value;
      pupils = locator<PupilManager>().allPupils;
    });
    super.initState();
  }

  void search() async {
    if (!isSearching) {
      setState(() {
        isSearching = true;
      });
    }

    if (!isSearchMode) return;
    setState(() {
      isSearching = false;
    });
  }

  void cancelSelect() {
    setState(() {
      selectedPupilIds.clear();
      isSelectMode = false;
    });
  }

  void cancelSearch({bool unfocus = true}) {
    setState(() {
      searchController.clear();
      isSearchMode = false;
      locator<PupilFilterManager>().setSearchText('');
      filteredPupils = List.from(pupils!);
      isSearching = false;
    });

    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onCardPress(int pupilId) {
    if (selectedPupilIds.contains(pupilId)) {
      setState(() {
        selectedPupilIds.remove(pupilId);
        if (selectedPupilIds.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedPupilIds.add(pupilId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedPupilIds.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<PupilProxy> shownPupils =
            locator<PupilFilterManager>().filteredPupils.value;
        isSelectMode = true;
        selectedPupilIds =
            shownPupils.map((pupil) => pupil.internalId).toList();
      } else {
        isSelectMode = false;
        selectedPupilIds.clear();
      }
    });
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;
    locator<PupilFilterManager>().setSearchText(text);
    setState(() {});
  }

  List<int> getSelectedPupilIds() {
    return selectedPupilIds.toList();
  }

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        leading: isSelectMode
            ? IconButton(
                onPressed: () {
                  cancelSelect();
                },
                icon: const Icon(Icons.close))
            : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kind/Kinder auswählen', style: appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 15.0, right: 10.00),
                  child: Row(
                    children: [
                      const Text(
                        'Angezeigt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        widget.selectablePupils?.length.toString() ?? '0',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Text(
                        'Ausgewählt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        selectedPupilIds.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: onSearchEnter,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            hintText: 'Schüler/in suchen',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: isSearchMode
                                ? IconButton(
                                    // tooltip:
                                    //     L10n.of(context)!.cancel,
                                    icon: const Icon(
                                      Icons.close_outlined,
                                    ),
                                    onPressed: cancelSearch,
                                    color: Colors.black45,
                                  )
                                : const Icon(
                                    Icons.search_outlined,
                                    color: Colors.black45,
                                  ),
                            suffixIcon: isSearchMode
                                ? isSearching
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 12,
                                        ),
                                        child: SizedBox.square(
                                          dimension: 24,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox(
                                    width: 0,
                                  ),
                          ),
                        ),
                      ),
                      //---------------------------------
                      InkWell(
                        onTap: () => showSelectPupilsFilterBottomSheet(context),
                        onLongPress: () =>
                            locator<PupilFilterManager>().resetFilters(),
                        // onPressed: () => showBottomSheetFilters(context),
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
                widget.selectablePupils?.isEmpty ?? true
                    ? const Center(
                        child: Text('Keine Ergebnisse'),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: widget.selectablePupils!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SelectPupilListCard(
                                isSelectMode: isSelectMode,
                                isSelected: selectedPupilIds.contains(
                                    widget.selectablePupils![index].internalId),
                                passedPupil: widget.selectablePupils![index],
                                onCardPress: onCardPress,
                              );
                            })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SelectPupilsPageBottomNavBar(
        isSelectAllMode: isSelectAllMode,
        isSelectMode: isSelectMode,
        filtersOn: filtersOn,
        selectedPupilIds: selectedPupilIds,
        cancelSelect: cancelSelect,
        toggleSelectAll: toggleSelectAll,
      ),
    );
  }
}
