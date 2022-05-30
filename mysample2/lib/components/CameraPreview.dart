import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image/image.dart' as imagedart;
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CameraPreviewYoutube extends StatefulWidget {
  const CameraPreviewYoutube({Key? key, required this.camera})
      : super(key: key);
  final CameraDescription camera;

  @override
  State<CameraPreviewYoutube> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewYoutube> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;
  bool _isCameraPermissionGranted = false;
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initControllerFuture = _controller.initialize();

    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent  event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            pitchValue=event.x*180/pi;
            rollValue=event.y*180/pi;
            checkTilt();
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  // getPermissionStatus() async {
  //   await Permission.camera.request();
  //   var status = await Permission.camera.status;
  //
  //   if (status.isGranted) {
  //     log('Camera Permission: GRANTED');
  //     setState(() {
  //       _isCameraPermissionGranted = true;
  //     });
  //     // Set and initialize the new camera
  //     onNewCameraSelected(cameras[0]);
  //     refreshAlreadyCapturedImages();
  //   } else {
  //     log('Camera Permission: DENIED');
  //   }
  // }
  bool isPermitReading = false;
  late double pitchValue;
  late double rollValue;
  late double yawValue;
  late double maxPitch = 34;
  late double maxRoll = 8;
  late double permitTilt = 0.25;
  late double ballRadius = 2;
  late double ballDrawingMargin = ballRadius * 1.2;
  late double ballPositionX = 0.0;
  late double ballPositionY = 0.0;

  void checkTilt() {
    var width = 135;
    var height = 90;
    if (pitchValue < -90) {
      pitchValue = pitchValue.abs() - 180;
    } else if (pitchValue > 90) {
      pitchValue = 180 - pitchValue;
    }
    if (rollValue < -90) {
      rollValue = rollValue.abs() - 180;
    } else if (rollValue > 90) {
      rollValue = 180 - rollValue;
    }
    var validWidth = width - ballDrawingMargin * 2;
    var validHeight = height - ballDrawingMargin * 2;
    if (rollValue < (maxRoll * -1)) {
      ballPositionX = validWidth * 0.0;
    } else if (rollValue > maxRoll) {
      ballPositionX = validWidth * 1.00;
    } else {
      var center = validWidth / 2;
      if (rollValue < 0) {
        ballPositionX = center - (rollValue.abs() / maxRoll) * center;
      } else {
        ballPositionX = center + (rollValue.abs() / maxRoll) * center;
      }
    }

    if (pitchValue < (maxPitch * -1)) {
      ballPositionY = validHeight * 0.0;
    } else if (pitchValue > maxPitch) {
      ballPositionY = validHeight * 1.00;
    } else {
      var center = validWidth / 2;
      if (pitchValue < 0) {
        ballPositionY = center - (pitchValue.abs() / maxPitch) * center;
      } else {
        ballPositionY = center + (pitchValue.abs() / maxPitch) * center;
      }
    }
    var permitDistance = width * permitTilt;
    var distance = calcDistance(
        validWidth * 0.5, validHeight * 0.5, ballPositionX, ballPositionY);
    if (distance <= permitDistance) {
      isPermitReading = true;
    } else {
      isPermitReading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                final size = MediaQuery.of(context).size;
                final deviceRatio = size.width / size.height;
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                );
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(color: Colors.cyan.withOpacity(0.1)),
          Center(
            child: Container(
              key: key,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.yellow, width: 1.0, style: BorderStyle.solid),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () async {
                if (_controller.value.isTakingPicture) {
                  return;
                }
                try {
                  await _initControllerFuture;
                  final image = await _controller.takePicture();
                  final imageResizePath = await _resizePhoto(image.path);
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DisplayPictureScreen(imagePath: imageResizePath)));
                } catch (e) {
                  print(e);
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: (isPermitReading == false)
                ? Text('$accelerometer',
                    style: const TextStyle(color: Colors.red, fontSize: 20))
                : const Text("Goc da chinh xac", style: TextStyle(color:Colors.green,fontSize: 20)),
          )
        ]);
  }

  GlobalKey key = GlobalKey();

  Future<String> _resizePhoto(String filePath) async {
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);
    int y = offset.dy.toInt();
    int x = offset.dx.toInt();
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(filePath);
    int? width = properties.width;
    int? height = properties.height;
    // double offset = (height!-width!)/2;
    // imagedart.imageC

    // File croppedFile =
    //     await FlutterNativeImage.cropImage(filePath,x, y, width! - 2*x, height! - 2*y );
    imagedart.Image? srcImage = imagedart
        .decodeImage(await File(filePath).readAsBytes()) as imagedart.Image;
    imagedart.Image croppedFile = imagedart.copyCrop(srcImage, x, y, 100, 500);
    await File(filePath).writeAsBytes(imagedart.encodePng(croppedFile));
    return filePath;
  }

  imagedart.Image copyCrop(imagedart.Image src, int x, int y, int w, int h) {
    imagedart.Image dst = imagedart.Image(w, h,
        channels: src.channels, exif: src.exif, iccp: src.iccProfile);

    for (int yi = 0, sy = y; yi < h; ++yi, ++sy) {
      for (int xi = 0, sx = x; xi < w; ++xi, ++sx) {
        dst.setPixel(xi, yi, src.getPixelSafe(sx, sy));
      }
    }
    return dst;
  }

  double calcDistance(double x1, double y1, double x2, double y2) {
    return sqrt((x2 - x1) * (x2 - x1) - (y2 - y1) * (y2 - y1));
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(fit: StackFit.loose, children: [
        Image.file(File(imagePath)),
      ]),
    );
  }
}
