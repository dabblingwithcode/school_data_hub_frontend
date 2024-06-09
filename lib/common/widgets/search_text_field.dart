import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class SearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const SearchTextField(
      {required this.searchType,
      required this.hintText,
      required this.refreshFunction,
      super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final pupilsFilter = locator<PupilsFilter>();

  final searchManager = locator<SearchManager>();
  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textFilter = watch(locator<PupilsFilter>().textFilter);
    if (locator<PupilsFilter>().textFilter.text == '') {
      textEditingController.clear();
    }
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) =>
          locator<PupilsFilter>().textFilter.setFilterText(value),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: searchManager.searchState.value
            ? IconButton(
                icon: const Icon(
                  Icons.close_outlined,
                ),
                onPressed: searchManager.cancelSearch,
                color: Colors.black45,
              )
            : IconButton(
                onPressed: () => widget.refreshFunction,
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black45,
                ),
              ),
        suffixIcon: const SizedBox(
          width: 0,
        ),
      ),
    );
  }
}
