import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/controller/selectable_category_tree_controller.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/pupil_category_tree.dart';

class SelectableCategoryTreeView extends StatelessWidget {
  final SelectableCategoryTreeController controller;
  const SelectableCategoryTreeView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors.white,
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(Colors.white),
            // overlayColor: MaterialStateProperty.all(Colors.green),
          )),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: backgroundColor,
          title: const Text('Förderung', style: appBarTextStyle),
          // automaticallyImplyLeading: false,
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Bitte eine Kategorie auswählen!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  ...buildPupilCategoryTree(context, controller.widget.pupil,
                      null, 0, null, controller, controller.widget.elementType),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButton: controller.selectedCategoryId != null
            ? FloatingActionButton(
                backgroundColor: backgroundColor,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop(controller.selectedCategoryId);
                })
            : const SizedBox.shrink(),
      ),
    );
  }
}
