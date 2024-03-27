import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class PatchCompetenceView extends StatefulWidget {
  final Competence competence;

  const PatchCompetenceView({super.key, required this.competence});

  @override
  PatchCompetenceViewState createState() => PatchCompetenceViewState();
}

class PatchCompetenceViewState extends State<PatchCompetenceView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  final TextEditingController textField3Controller = TextEditingController();

  void postPatchCompetence() async {
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;
    String text3 = textField3Controller.text;
    await locator<CompetenceManager>()
        .patchCompetence(widget.competence.competenceId, text1, text2, text3);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      textField1Controller.text = widget.competence.competenceName;
      if (widget.competence.competenceLevel != null) {
        textField2Controller.text = widget.competence.competenceLevel!;
      } else {
        textField2Controller.clear();
      }
      if (widget.competence.indicators != null) {
        textField3Controller.text = widget.competence.indicators!;
      } else {
        textField3Controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Kompetenz überarbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: <Widget>[
                const Text(
                  'Kompetenz überarbeiten:',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                      backgroundColor: const Color.fromARGB(255, 47, 202, 76),
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    postPatchCompetence();
                  },
                  child: const Text(
                    'SENDEN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 67, 67),
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
