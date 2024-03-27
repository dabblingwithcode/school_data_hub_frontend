import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/selectable_category_tree_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class SelectableCategoryTree extends StatefulWidget {
  final Pupil pupil;
  final String elementType;
  const SelectableCategoryTree(
    this.pupil,
    this.elementType, {
    Key? key,
  }) : super(key: key);

  @override
  SelectableCategoryTreeController createState() =>
      SelectableCategoryTreeController();
}

class SelectableCategoryTreeController extends State<SelectableCategoryTree> {
  int? selectedCategoryId;

  void selectCategory(int id) {
    setState(() {
      selectedCategoryId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectableCategoryTreeView(this);
  }
}
