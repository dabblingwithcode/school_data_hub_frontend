import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';

Future<String?> longTextFieldDialog(
    String title, String? textinField, BuildContext parentContext) async {
  return await showDialog(
      context: parentContext,
      builder: (context) {
        return StatefulBuilder(builder: (statefulContext, setState) {
          final TextEditingController textEditingController =
              TextEditingController();
          setState(() {
            textEditingController.text = textinField ?? '';
          });
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: backgroundColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 17),
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      decoration: null,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  textEditingController.dispose();
                  Navigator.of(parentContext).pop(null);
                  return;
                },
                child: const Text(
                  "ZURÜCK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: dangerButtonColor,
                  ),
                ),
              ),
              textinField != null
                  ? TextButton(
                      onPressed: () {
                        String newSpecialInformation = '';

                        textEditingController.dispose();
                        Navigator.of(parentContext).pop(newSpecialInformation);
                      },
                      child: const Text(
                        "LÖSCHEN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: warningButtonColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              TextButton(
                onPressed: () {
                  String? newSpecialInformation = textEditingController.text;

                  if (newSpecialInformation.isEmpty) {
                    return;
                  }

                  textEditingController.dispose();
                  Navigator.of(parentContext).pop(newSpecialInformation);
                },
                child: const Text(
                  "OKAY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: successButtonColor,
                  ),
                ),
              ),
            ],
          );
        });
      });
}
