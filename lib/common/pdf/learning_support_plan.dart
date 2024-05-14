import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:schuldaten_hub/features/pupil/manager/pupil_helper_functions.dart';

Future generatePdf(int pupilId) async {
  final pdf = pw.Document();
  final pupil = findPupilById(pupilId);
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(children: [
        pw.Row(children: [
          pw.Text(pupil.firstName!),
        ])
      ]),
    ),
  );

  final file = File('Förderplan_${pupil.firstName}.pdf');
  await file.writeAsBytes(await pdf.save());
}
