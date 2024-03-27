import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Widget infinityAsyncButton(Future function) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      //margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: appStyleButtonColor,
            minimumSize: const Size.fromHeight(50)),
        onPressed: () async {
          await function;
        },
        child: const Text(
          "EINLOGGEN",
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    ),
  );
}
