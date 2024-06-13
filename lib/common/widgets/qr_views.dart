import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';

import 'dart:async';

class QrCodeCarousel extends StatefulWidget {
  final List<Map<String, Object>> qrMaps;

  const QrCodeCarousel({super.key, required this.qrMaps});

  @override
  QrCodeCarouselState createState() => QrCodeCarouselState();
}

class QrCodeCarouselState extends State<QrCodeCarousel> {
  late Timer _timer;
  int _currentIndex = -1;
  int _countdown = 5; // Set the initial countdown value
  int _milliseconds = 1000; // Set the initial timer interval
  late Map<String, int> _pupilNumbers;
  late Map<String, String> _qrMap;
  @override
  void initState() {
    super.initState();
    _pupilNumbers = widget.qrMaps[0] as Map<String, int>;
    _qrMap = widget.qrMaps[1] as Map<String, String>;
    startTimer(_milliseconds);
  }

  void startTimer(int milliseconds) {
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      setState(() {
        _countdown = _countdown > 0 ? _countdown - 1 : _countdown;
        if (_countdown == 0) {
          _timer.cancel(); // Cancel the current timer
          _milliseconds = 1000; // Set the qr carousel interval
          startTimer(_milliseconds); // Start a new timer with the new interval
          _currentIndex = (_currentIndex + 1) % _qrMap.values.length;
        }
        // Stop the timer when the Container is shown
        if (_currentIndex == _qrMap.length - 1) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('QR-Code Carousel'),
        backgroundColor: backgroundColor,
      ),
      body: _countdown > 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Die Codes erscheinen in...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Gap(20),
                  Text(
                    _countdown.toString(),
                    style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900]),
                  ),
                  const Gap(20),
                  const Text(
                    'Halten Sie Ihr Gerät in Scanmodus bereit...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Center(
              child: _currentIndex != _qrMap.length - 1
                  ? Column(
                      children: [
                        const Gap(20),
                        Text(_qrMap.keys.elementAt(_currentIndex),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: QrImageView(
                            size: mediaQuery.size.height * 0.75,
                            data: _qrMap.values.elementAt(_currentIndex),
                            version: QrVersions.auto,
                          ),
                        ),
                      ],
                    )
                  : Column(children: [
                      const Gap(20),
                      Text(
                        '${_qrMap.entries.length} Codes wurden angezeigt!',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      const Text(
                        'Überprüfen Sie diese Zahlen:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Gap(5),
                      Text(
                        'Insgesamt: ${_pupilNumbers.values.reduce((a, b) => a + b).toString()}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      for (var key in _pupilNumbers.keys)
                        Text(
                          '$key: ${_pupilNumbers[key].toString()}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('fertig'),
                      ),
                    ]),
            ),
    );
  }
}

void showQrCarousel(
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
            autoPlayInterval: const Duration(seconds: 1),
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

Future<void> showQrCode(String qr, BuildContext context) async {
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
                TextButton(
                  onPressed: () {
                    copyQrCodeToClipboard(qr, context, qrImageKey);
                  },
                  child: const Text('In der Zwischenablage kopieren'),
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

Future<void> saveQrCode(
    String qr, BuildContext context, GlobalKey qrKey) async {
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
  File imgFile = File(Platform.isWindows ? '$filePath.png' : filePath);
  await imgFile.writeAsBytes(pngBytes);

  // Show a success message
  locator<NotificationManager>()
      .showSnackBar(NotificationType.success, ' QR-Code gespeichert');
}

Future<void> copyQrCodeToClipboard(
    String qr, BuildContext context, GlobalKey qrKey) async {
  final RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary; //final repaintBoundary = RepaintBoundary();
  // Wrap the QR image with a Container or SizedBox
  ui.Image image = await boundary.toImage();

  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  Directory directory = await getTemporaryDirectory();

  String fileName =
      'school_data_qr_code_${DateTime.now().millisecondsSinceEpoch}.png';
  String filePath = '${directory.path}/$fileName';
  File imgFile = File(filePath);
  await imgFile.writeAsBytes(pngBytes);

  await Pasteboard.writeFiles([filePath]);

  // Find and delete old QR code files, excluding the current imgFile
  final List<FileSystemEntity> files = directory.listSync();
  for (final file in files) {
    if (file.path.contains('school_data_qr_code') &&
        !file.path.contains(fileName)) {
      try {
        await File(file.path).delete();
      } catch (e) {
        // Handle the error or ignore
      }
    }
  }
  // Show a success message
  locator<NotificationManager>()
      .showSnackBar(NotificationType.success, ' QR-Code gespeichert');
}
