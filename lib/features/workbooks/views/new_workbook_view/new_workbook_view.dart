import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
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
  final TextEditingController nameTextFieldController = TextEditingController();
  final TextEditingController isbnTextFieldController = TextEditingController();
  final TextEditingController subjectTextFieldController =
      TextEditingController();
  final TextEditingController level = TextEditingController();
  final TextEditingController amountTextFieldController =
      TextEditingController();

  Set<int> pupilIds = {};
  void postNewWorkbook() async {
    String workbookName = nameTextFieldController.text;
    int workbookIsbn = int.parse(isbnTextFieldController.text);
    String workbookSubject = subjectTextFieldController.text;
    String workbookLevel = level.text;
    int amount = int.parse(amountTextFieldController.text);

    await locator<WorkbookManager>().postWorkbook(
        workbookName, workbookIsbn, workbookSubject, workbookLevel, amount);
  }

  void patchWorkbook() async {
    String workbookName = nameTextFieldController.text;
    int workbookIsbn = int.parse(isbnTextFieldController.text);
    String workbookSubject = subjectTextFieldController.text;
    String workbookLevel = level.text;

    await locator<WorkbookManager>().updateWorkbookProperty(
        workbookName, workbookIsbn, workbookSubject, workbookLevel);
  }

  @override
  Widget build(BuildContext context) {
    nameTextFieldController.text = widget.wbName ?? '';
    if (isbnTextFieldController.text == '') {
      isbnTextFieldController.text = widget.wbIsbn?.toString() ?? '';
    }
    subjectTextFieldController.text = widget.wbSubject ?? '';
    level.text = widget.wbLevel ?? '';
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
                    controller: nameTextFieldController,
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
                    controller: isbnTextFieldController,
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
                    controller: subjectTextFieldController,
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
                    controller: level,
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
                  const Gap(20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 1,
                    maxLines: 1,
                    controller: amountTextFieldController,
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
                      labelText: 'Bestand',
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
                        locator<NotificationManager>().showSnackBar(
                            NotificationType.error,
                            'Dieses Arbeitsheft gibt es schon!');

                        return;
                      }
                      setState(() {
                        isbnTextFieldController.text = scannedIsbn;
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
                                int.parse(isbnTextFieldController.text))) {
                          locator<NotificationManager>().showSnackBar(
                              NotificationType.error,
                              'Dieses Arbeitsheft gibt es schon!');

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
    nameTextFieldController.dispose();
    isbnTextFieldController.dispose();
    subjectTextFieldController.dispose();
    level.dispose();
    amountTextFieldController.dispose();
    super.dispose();
  }
}
