import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';

TextField searchTextField(
  String hintText,
  controller,
  Function refreshFunction,
) {
  return TextField(
    focusNode: controller.focusNode,
    controller: locator<SearchManager>().searchController.value,
    textInputAction: TextInputAction.search,
    onChanged: locator<SearchManager>().onSearchEnter,
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
      prefixIcon: locator<SearchManager>().searchState.value
          ? IconButton(
              // tooltip:
              //     L10n.of(context)!.cancel,
              icon: const Icon(
                Icons.close_outlined,
              ),
              onPressed: locator<SearchManager>().cancelSearch,
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
    // decoration: InputDecoration(
    //     filled: true,
    //     fillColor: Colors.white,
    //     contentPadding: const EdgeInsets.only(
    //         left: 15.0,
    //         right: 10.0,
    //         top: 10.0,
    //         bottom: 10.0),
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(7),
    //   borderSide:
    //       BorderSide(color: backgroundColor),
    // // ),
    // labelText: 'Suche',
    // suffixIcon: Icon(Icons.search)),
  );
}
