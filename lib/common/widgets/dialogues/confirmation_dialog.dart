import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Future<bool?> confirmationDialog(
    BuildContext context, String title, String message) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Abbrechen',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Return false to indicate cancellation
            },
          ),
          TextButton(
            child: const Text(
              'Okay',
              style: TextStyle(color: backgroundColor),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Return true to indicate confirmation
            },
          ),
        ],
      );
    },
  );
}
