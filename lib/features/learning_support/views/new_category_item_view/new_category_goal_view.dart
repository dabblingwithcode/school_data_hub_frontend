import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_item_view/controller/new_category_item_controller.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/controller/selectable_category_tree_controller.dart';

import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_status_dropdown.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_tree_ancestors_names.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';

class NewCategoryGoalView extends StatelessWidget {
  final NewCategoryGoalController controller;
  const NewCategoryGoalView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        focusColor: backgroundColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(controller.widget.appBarTitle),
        ),
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Row(
                      children: [
                        Text('Förderkategorie',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const Gap(10),
                    controller.goalCategoryId == null ||
                            controller.goalCategoryId == 0
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: backgroundColor,
                                minimumSize: const Size.fromHeight(60)),
                            onPressed: () async {
                              final int? categoryId = await Navigator.of(
                                      context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) => SelectableCategoryTree(
                                          findPupilById(
                                              controller.widget.pupilId),
                                          controller.widget.elementType)));
                              if (categoryId == null) {
                                return;
                              }
                              controller.setGoalCategoryId(categoryId);
                            },
                            child: const Text('KATEGORIE AUSWÄHLEN'),
                          )
                        : InkWell(
                            // onLongPress: () async {
                            //   final int? categoryId = await Navigator.of(
                            //           context)
                            //       .push(MaterialPageRoute(
                            //           builder: (ctx) => SelectableCategoryTree(
                            //               findPupilById(
                            //                   controller.widget.pupilId))));
                            //   if (categoryId == null) {
                            //     return;
                            //   }
                            //   controller.setGoalCategoryId(categoryId);
                            // },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: locator<GoalManager>().getCategoryColor(
                                  controller.goalCategoryId!,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, bottom: 8),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    ...categoryTreeAncestorsNames(
                                      controller.goalCategoryId!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const Gap(10),
                    controller.goalCategoryId == null
                        ? const SizedBox.shrink()
                        : controller.goalCategoryId == 0
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      locator<GoalManager>()
                                          .getGoalCategory(
                                              controller.goalCategoryId!)
                                          .categoryName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: locator<GoalManager>()
                                            .getCategoryColor(
                                                controller.goalCategoryId!),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    const Gap(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            (controller.widget.appBarTitle ==
                                    'Neues Förderziel')
                                ? 'Förderziel'
                                : 'Status',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const Gap(10),
                    if (controller.widget.appBarTitle ==
                        'Neues Förderziel') ...[
                      TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: controller.textField1Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: backgroundColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: backgroundColor, width: 2),
                          ),
                          labelStyle: TextStyle(color: backgroundColor),
                          labelText: 'Beschreibung des Zieles',
                        ),
                      ),
                      const Gap(20),
                      const Row(
                        children: [
                          Text('Strategien',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      const Gap(10),
                    ],
                    TextField(
                      minLines: 3,
                      maxLines: 4,
                      controller: controller.textField2Controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: backgroundColor, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: backgroundColor, width: 2),
                        ),
                        labelStyle: const TextStyle(color: backgroundColor),
                        labelText: (controller.widget.appBarTitle ==
                                'Neues Förderziel')
                            ? 'Hilfen für das Erreichen des Zieles'
                            : 'Beschreibung des Status',
                      ),
                    ),
                    const Gap(20),
                    if (controller.widget.appBarTitle != 'Neues Förderziel')
                      Row(
                        children: [
                          const Text(
                            'Eine Farbe auswählen:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                },
                                value: controller.categoryStatusValue,
                                items: categoryStatusItems,
                                onChanged: (newValue) {
                                  controller.setCategoryStatusValue(newValue!);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.amber[800],
                          minimumSize: const Size.fromHeight(60)),
                      onPressed: () {
                        if (controller.widget.appBarTitle ==
                            'Neues Förderziel') {
                          controller.postCategoryGoal();
                        } else {
                          locator<GoalManager>().postCategoryStatus(
                              findPupilById(controller.widget.pupilId),
                              controller.goalCategoryId!,
                              controller.categoryStatusValue,
                              controller.textField2Controller.text);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'SENDEN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Gap(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 235, 67, 67),
                          minimumSize: const Size.fromHeight(60)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ABBRECHEN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
