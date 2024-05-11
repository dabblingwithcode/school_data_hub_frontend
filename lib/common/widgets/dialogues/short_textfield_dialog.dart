import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

shortTextfieldDialog(
    {required BuildContext context,
    required String title,
    required String labelText,
    required String hintText,
    required bool obscureText}) {
  TextEditingController textEditingController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            //maxLength: 16,

            obscureText: obscureText,
            decoration: InputDecoration(
              //border: InputBorder.none,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: backgroundColor, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: backgroundColor, width: 2),
              ),
              labelStyle: const TextStyle(color: backgroundColor),
              labelText: labelText,
              hintText: hintText,
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
