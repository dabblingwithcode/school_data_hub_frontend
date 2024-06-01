import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';

Future<void> printMatrixCredentials(
    String matrixDomain, MatrixUser matrixUser, String password) async {
  final pdf = pw.Document();
  final String matrixId =
      matrixUser.id!.replaceAll("@", "").replaceAll(":hermannschule.de", "");
  String qrPassword = password.substring(0, password.length - 4);
  String pin = password.substring(password.length - 4);
  final String domain =
      matrixDomain.replaceAll("https://", "").replaceAll("/", "");
  final String qrCodeData = "$matrixId:$domain*$qrPassword";
  logger.i('QR Code Data: $qrCodeData');
  final String encryptedQrCodeData = customEncrypter.encrypt(qrCodeData);
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(children: [
          pw.Text('Zugangsdaten - gut aufbewahren!'),
          pw.Text('Matrix User: ${matrixUser.displayName}'),
          pw.Text('PIN: $pin'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
          pw.BarcodeWidget(
            data: encryptedQrCodeData,
            width: 60,
            height: 60,
            barcode: pw.Barcode.qrCode(),
            drawText: false,
          ),
        ]),
      ),
    ),
  );

  final file = File("HP_credentials_${matrixUser.displayName}.pdf");
  await file.writeAsBytes(await pdf.save());
}
