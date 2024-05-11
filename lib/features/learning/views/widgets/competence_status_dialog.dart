import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_status_dropdown.dart';

final GlobalKey<FormState> _categoryStatusKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future competenceStatusDialog(
    PupilProxy pupil, int goalCategoryId, BuildContext parentContext) async {
  return await showDialog(
      context: parentContext,
      builder: (context) {
        String categoryStatusValue = 'white';
        return StatefulBuilder(builder: (statefulContext, setState) {
          return AlertDialog(
            content: Form(
                key: _categoryStatusKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                        keyboardType: TextInputType.multiline,
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "";
                        },
                        decoration: const InputDecoration(hintText: "?"),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Eine Farbe auswählen:'),
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
                              value: categoryStatusValue,
                              items: categoryStatusItems,
                              onChanged: (newValue) {
                                setState(() {
                                  categoryStatusValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            title: const Text('Neuer Kategoriestatus'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(parentContext).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  if (_categoryStatusKey.currentState!.validate()) {
                    locator<GoalManager>().postCategoryStatus(
                        pupil,
                        goalCategoryId,
                        categoryStatusValue,
                        _textEditingController.text);

                    _textEditingController.clear();
                    Navigator.of(parentContext).pop();
                  }
                },
                child: const Text(
                  "OKAY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
      });
}
