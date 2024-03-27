import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';

showQrCarousel(
    Map<String, String> qrMap, bool autoPlay, BuildContext context) async {
  final mediaQuery = MediaQuery.of(context);
  double maxHeight;
  final maxWidth = mediaQuery.size.width; // Adjust the multiplier as needed
  if (mediaQuery.orientation == Orientation.landscape) {
    maxHeight = mediaQuery.size.height * 0.9;
  } else {
    maxHeight = mediaQuery.size.height * 0.6;
  }

  List<Map<String, String>> myListOfMaps = [];

  // Transforming myMap into a List<Map<String, String>>
  qrMap.forEach((key, value) {
    myListOfMaps.add({key: value});
  });
  await showDialog(
      context: context,
      builder: (context) {
        return CarouselSlider(
          options: CarouselOptions(
            viewportFraction:
                (mediaQuery.orientation == Orientation.landscape) ? 0.6 : 0.9,
            enlargeCenterPage: true,
            height: maxHeight,
            autoPlay: autoPlay,
            autoPlayInterval: const Duration(seconds: 3),
            pauseAutoPlayInFiniteScroll: true,
            pauseAutoPlayOnTouch: true,
            scrollPhysics: const PageScrollPhysics(),
          ),
          items: myListOfMaps.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    width: maxWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Gap(10),
                        Text(i.keys.first,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: QrImageView(
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            data: i.values.first,
                            version: QrVersions.auto,
                            size: (mediaQuery.orientation ==
                                        Orientation.landscape ||
                                    Platform.isWindows)
                                ? maxHeight * 0.9
                                : maxWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      });
}

showQrCode(String qr, BuildContext context) async {
  final qrImageKey = GlobalKey();
  final mediaQuery = MediaQuery.of(context);
  final maxWidth =
      mediaQuery.size.width * 0.8; // Adjust the multiplier as needed
  final maxHeight = mediaQuery.size.height * 0.8; //
  //final RenderBox box = context.findRenderObject() as RenderBox;
  //final Offset offset = box.localToGlobal(Offset.zero);
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: qrImageKey,
              child: QrImageView(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
                data: qr,
                version: QrVersions.auto,
                size: min(maxWidth, maxHeight),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('fertig'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    saveQrCode(qr, context, qrImageKey);
                  },
                  child: const Text('code speichern'),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void saveQrCode(String qr, BuildContext context, GlobalKey qrKey) async {
  final RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary; //final repaintBoundary = RepaintBoundary();
  // Wrap the QR image with a Container or SizedBox
  ui.Image image = await boundary.toImage();
  String? filePath =
      await FilePicker.platform.saveFile(allowedExtensions: ['png']);
  if (filePath == null) {
    // User canceled the file picker
    return;
  }
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  File imgFile = File(filePath);
  await imgFile.writeAsBytes(pngBytes);

  // Show a success message
  if (context.mounted) {
    snackbarSuccess(context, 'QR-Code gespeichert');
  }
}
