// //https://stackoverflow.com/questions/51348166/how-to-square-crop-a-flutter-camera-preview
// //https://docs.flutter.dev/cookbook/plugins/picture-using-camera
// // https://nzxcvbnm.medium.com/square-cropped-full-camera-in-flutter-37198e4822b0
// // https://github.com/nzxcvbnm/camera

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:schuldaten_hub/common/utils/debug_printer.dart';

// Future<void> getCamera() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
// }

// class CameraView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     debug.info('Camera started');
//     return Column(
//       children: <Widget>[
//         CroppedCameraPreview(),

//         // Something to occupy the rest of the space
//         Expanded(
//           child: Container(),
//         )
//       ],
//     );
//   }
// }

// class CroppedCameraPreview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // We will pretend this is a camera preview (to make demo easier)
//     var tmp = MediaQuery.of(context).size;

//     final screenH = max(tmp.height, tmp.width);
//     final screenW = min(tmp.height, tmp.width);

//     tmp = cameraController.value.previewSize!;

//     final previewH = max(tmp.height, tmp.width);
//     final previewW = min(tmp.height, tmp.width);
//     final screenRatio = screenH / screenW;
//     final previewRatio = previewH / previewW;

//     return Center(
//       child: Container(
//         width: screenW,
//         height: screenW,
//         color: Colors.black,
//         child: ClipRRect(
//           child: OverflowBox(
//             maxHeight: screenRatio > previewRatio
//                 ? screenH
//                 : screenW / previewW * previewH,
//             maxWidth: screenRatio > previewRatio
//                 ? screenH / previewH * previewW
//                 : screenW,
//             child: CameraPreview(
//               cameraController,
//             ),
//           ),
//         ),
//       ),
//     );

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.width,
//       child: ClipRect(
//         child: new OverflowBox(
//           alignment: Alignment.center,
//           child: FittedBox(
//             fit: BoxFit.fitWidth,
//             child: cameraImage,
//           ),
//         ),
//       ),
//     );
//   }
// }
