import 'package:flutter/material.dart';

import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_item_page/new_category_item_view.dart';

class NewCategoryItem extends StatefulWidget {
  final String appBarTitle;
  final int pupilId;
  final int goalCategoryId;
  final String elementType;

  const NewCategoryItem(
      {super.key,
      required this.appBarTitle,
      required this.pupilId,
      required this.goalCategoryId,
      required this.elementType});

  @override
  NewCategoryGoalController createState() => NewCategoryGoalController();
}

class NewCategoryGoalController extends State<NewCategoryItem> {
  @override
  void initState() {
    super.initState();
    goalCategoryId = widget.goalCategoryId;
  }

  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  int? goalCategoryId;
  String categoryStatusValue = 'white';
  void setGoalCategoryId(int id) {
    setState(() {
      goalCategoryId = id;
    });
  }

  void setCategoryStatusValue(String value) {
    setState(() {
      categoryStatusValue = value;
    });
  }

  Future postCategoryGoal() async {
    if (goalCategoryId == null) {
      return;
    }
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;

    await locator<GoalManager>()
        .postNewCategoryGoal(goalCategoryId!, widget.pupilId, text1, text2);
  }

  @override
  Widget build(BuildContext context) {
    return NewCategoryGoalView(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
