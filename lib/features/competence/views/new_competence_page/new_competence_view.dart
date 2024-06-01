import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class NewCompetenceView extends StatefulWidget {
  final int parentCompetence;

  const NewCompetenceView({super.key, required this.parentCompetence});

  @override
  NewCompetenceViewState createState() => NewCompetenceViewState();
}

class NewCompetenceViewState extends State<NewCompetenceView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  final TextEditingController textField3Controller = TextEditingController();

  void postNewCompetence() async {
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;
    String text3 = textField3Controller.text;
    await locator<CompetenceManager>()
        .postNewCompetence(widget.parentCompetence, text1, text2, text3);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Neue Kompetenz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: <Widget>[
                Text(
                  'Übergeordnete Kompetenz: ${locator<CompetenceManager>().getCompetence(widget.parentCompetence).competenceName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: textField1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Name der Kompetenz',
                    labelStyle: TextStyle(color: backgroundColor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor),
                    ),
                  ),
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 1,
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Jahrgang / Jahrgänge',
                    labelStyle: TextStyle(color: backgroundColor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor),
                    ),
                  ),
                ),
                const Gap(20),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField3Controller,
                  decoration: const InputDecoration(
                    labelText: 'Indikatoren',
                    labelStyle: TextStyle(color: backgroundColor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: successButtonColor,
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    postNewCompetence();
                  },
                  child: const Text(
                    'SENDEN',
                    style: buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: dangerButtonColor,
                      minimumSize: const Size.fromHeight(60)),
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
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
