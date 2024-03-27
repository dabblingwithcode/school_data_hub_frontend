import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

shortTextfieldDialog(BuildContext context, String title, String labelText) {
  TextEditingController textEditingController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        content: Container(
          decoration: BoxDecoration(
            border: Border.all(color: backgroundColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              //maxLength: 16,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Kürzel eingeben',
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: cancelButtonStyle,
              child: const Text(
                'ABBRECHEN',
                style: buttonTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                textEditingController.dispose();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: successButtonStyle,
              child: const Text(
                'OKAY',
                style: buttonTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text);
                textEditingController.dispose();
              },
            ),
          ),
        ],
      );
    },
  );
}
