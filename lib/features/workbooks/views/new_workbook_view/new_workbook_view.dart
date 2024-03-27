import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';

import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';

class NewWorkbookView extends StatefulWidget {
  final String? wbName;
  final int? wbIsbn;
  final String? wbSubject;
  final String? wbLevel;
  const NewWorkbookView(this.wbName, this.wbIsbn, this.wbSubject, this.wbLevel,
      {super.key});

  @override
  NewWorkbookViewState createState() => NewWorkbookViewState();
}

class NewWorkbookViewState extends State<NewWorkbookView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  final TextEditingController textField3Controller = TextEditingController();
  final TextEditingController textField4Controller = TextEditingController();

  Set<int> pupilIds = {};
  void postNewWorkbook() async {
    String workbookName = textField1Controller.text;
    int workbookIsbn = int.parse(textField2Controller.text);
    String workbookSubject = textField3Controller.text;
    String workbookLevel = textField4Controller.text;

    await locator<WorkbookManager>().postWorkbook(
        workbookName, workbookIsbn, workbookSubject, workbookLevel);
    if (context.mounted) {
      snackbarSuccess(context, 'Neues Arbeitsheft erstellt!');
    }
  }

  void patchWorkbook() async {
    String workbookName = textField1Controller.text;
    int workbookIsbn = int.parse(textField2Controller.text);
    String workbookSubject = textField3Controller.text;
    String workbookLevel = textField4Controller.text;

    await locator<WorkbookManager>().patchWorkbook(
        workbookName, workbookIsbn, workbookSubject, workbookLevel);
    if (context.mounted) {
      snackbarSuccess(context, 'Arbeitsheft geändert!');
    }
  }

  @override
  Widget build(BuildContext context) {
    textField1Controller.text = widget.wbName ?? '';
    if (textField2Controller.text == '') {
      textField2Controller.text = widget.wbIsbn?.toString() ?? '';
    }
    textField3Controller.text = widget.wbSubject ?? '';
    textField4Controller.text = widget.wbLevel ?? '';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Center(
          child: Text(
            (widget.wbIsbn != null)
                ? 'Arbeitsheft bearbeiten'
                : 'Neues Arbeitsheft',
            style: appBarTextStyle,
          ),
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 2,
                    maxLines: 2,
                    controller: textField1Controller,
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
                      labelText: 'Name des Heftes',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 1,
                    maxLines: 1,
                    controller: textField2Controller,
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
                      labelText: 'ISBN',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 1,
                    maxLines: 1,
                    controller: textField3Controller,
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
                      labelText: 'Fach',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: textField4Controller,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                      labelText: 'Kompetenzstufe',
                    ),
                  ),
                  const Gap(30),
                  ElevatedButton(
                    style: actionButtonStyle,
                    onPressed: () async {
                      final String? scannedIsbn =
                          await scanner(context, 'Isbn code scannen');
                      debug.info('Scanned ISBN: $scannedIsbn');
                      if (scannedIsbn == null) {
                        return;
                      }
                      if (locator<WorkbookManager>().workbooks.value.any(
                          (element) =>
                              element.isbn == int.parse(scannedIsbn))) {
                        if (context.mounted) {
                          snackbarError(
                              context, 'Dieses Arbeitsheft gibt es schon!');
                        }
                        return;
                      }
                      setState(() {
                        textField2Controller.text = scannedIsbn;
                      });
                    },
                    child: const Text(
                      'ISBN SCANNEN',
                      style: buttonTextStyle,
                    ),
                  ),
                  const Gap(15),
                  ElevatedButton(
                    style: successButtonStyle,
                    onPressed: () {
                      if (widget.wbIsbn != null) {
                        patchWorkbook();
                        Navigator.pop(context);
                        return;
                      }
                      {
                        if (locator<WorkbookManager>().workbooks.value.any(
                            (element) =>
                                element.isbn ==
                                int.parse(textField2Controller.text))) {
                          snackbarError(
                              context, 'Dieses Arbeitsheft gibt es schon!');
                          return;
                        }
                        postNewWorkbook();
                        Navigator.pop(context);
                        return;
                      }
                    },
                    child: const Text(
                      'SENDEN',
                      style: buttonTextStyle,
                    ),
                  ),
                  const Gap(15),
                  ElevatedButton(
                    style: cancelButtonStyle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ABBRECHEN',
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    textField3Controller.dispose();
    textField4Controller.dispose();
    super.dispose();
  }
}
