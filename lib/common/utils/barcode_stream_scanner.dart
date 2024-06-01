import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/generic_app_bar.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class BarcodeStreamScanner extends WatchingStatefulWidget {
  const BarcodeStreamScanner({super.key});

  @override
  State<BarcodeStreamScanner> createState() => _BarcodeStreamScannerState();
}

class _BarcodeStreamScannerState extends State<BarcodeStreamScanner> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  int _counter = 0;
  String _lastProcessedQrCode = '';

  Widget _buildBarcodeStream() {
    return StreamBuilder<BarcodeCapture>(
      stream: controller.barcodes,
      builder: (context, snapshot) {
        final barcodes = snapshot.data?.barcodes;

        if (barcodes == null || barcodes.isEmpty) {
          return const Center(
            child: Text(
              'Gerät während des Scanvorgangs still halten!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        }
        final String? newQrCode = barcodes.last.rawValue;
        if (newQrCode != null) {
          if (_lastProcessedQrCode == '' || _lastProcessedQrCode != newQrCode) {
            unawaited(locator<PupilIdentityManager>()
                .addNewPupilIdentities(encryptedIdentitiesAsString: newQrCode));
            _counter++;
            _lastProcessedQrCode = newQrCode;
          }
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: barcodes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gescannte codes: $_counter',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: cancelButtonStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "ABBRECHEN",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: successButtonStyle,
                      onPressed: () {
                        unawaited(locator<PupilManager>().fetchAllPupils());
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SCAN BEENDEN",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.qr_code_scanner_rounded,
        title: 'QR-Code-Stream scannen',
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return Center(
                  child: Text('Error: $error',
                      style: const TextStyle(color: Colors.red)));
            },
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 150,
              color: Colors.black.withOpacity(0.4),
              child: _buildBarcodeStream(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}
