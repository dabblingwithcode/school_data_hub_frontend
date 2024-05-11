import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';

TextField searchTextField(
  SearchType searchType,
  String hintText,
  controller,
  Function refreshFunction,
) {
  final searchManager = locator<SearchManager>();
  searchManager.setSearchType(searchType);
  return TextField(
    focusNode: controller.focusNode,
    controller: searchManager.searchController.value,
    textInputAction: TextInputAction.search,
    onChanged: searchManager.onSearchEnter,
    decoration: InputDecoration(
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      filled: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      hintText: hintText,
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
              onPressed: () => refreshFunction,
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
