import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> changeCreditDialog(BuildContext context, PupilProxy pupil) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "";
                        },
                        decoration: const InputDecoration(hintText: "?"),
                      ),
                    ),
                  ],
                )),
            title: const Text(
              'Guthaben ändern',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: actionButtonStyle,
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: buttonTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: cancelButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int amount = -int.parse(_textEditingController.text);
                      locator<PupilManager>()
                          .patchPupil(pupil.internalId, 'credit', amount);
                      // Do something like updating SharedPreferences or User Settings etc.
                      _textEditingController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "MINUS",
                    style: buttonTextStyle,
                  ),
                ),
              ),
              ElevatedButton(
                style: successButtonStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int amount = int.parse(_textEditingController.text);
                    locator<SessionManager>().changeSessionCredit(-amount);
                    locator<PupilManager>()
                        .patchPupil(pupil.internalId, 'credit', amount);
                    // Do something like updating SharedPreferences or User Settings etc.
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  "PLUS",
                  style: buttonTextStyle,
                ),
              ),
            ],
          );
        });
      });
}
