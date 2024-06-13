import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/learning_support/pages/goal_category_list_page/controller/category_list_controller.dart';
import 'package:schuldaten_hub/features/learning_support/pages/goal_category_list_page/widgets/category_tree.dart';
import 'package:watch_it/watch_it.dart';

class CategoryListView extends WatchingWidget {
  final CategoryListController controller;
  const CategoryListView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'Förderkategorien',
          style: appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 10, right: 10, bottom: 10),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(children: [
                ...buildCategoryTree(null, 0, null),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
