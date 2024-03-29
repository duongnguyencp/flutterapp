import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image/image.dart' as imagedart;
import 'package:mysample2/components/BallCustomClipPath.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

import '../resource/data.dart';

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

  // Future<void> useFlutterSensor() async {
  //   bool accelerometerAvailable =
  //       await SensorManager().isSensorAvailable(Sensors.ROTATION);
  //   final stream = await SensorManager().sensorUpdates(sensorId: TYPE_LIGHT);
  //   _lightSubscription = stream.listen((sensorEvent) {
  //     setState(() {
  //       _lightData = sensorEvent.data;
  //     });
  //   });
  // }
  Vector3 _orientation = Vector3.zero();

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initControllerFuture = _controller.initialize();

    // _streamSubscriptions.add(
    //   accelerometerEvents.listen(
    //     (AccelerometerEvent event) {
    //       setState(()  {
    //         double x = event.x, y = event.y, z = event.z;
    //         double norm_Of_g = math
    //             .sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    //         x = event.x / norm_Of_g;
    //         y = event.y / norm_Of_g;
    //         z = event.z / norm_Of_g;
    //
    //         double xInclination = -(math.asin(x) * (180 / math.pi));
    //         double yInclination = (math.acos(y) * (180 / math.pi));
    //         double zInclination = (math.atan(z) * (180 / math.pi));
    //
    //         rollValue = xInclination;
    //         // String yAngle = Inclination;
    //         pitchValue = zInclination;
    //         // _accelerometerValues = <double>[event.x, event.y, event.z];
    //         // pitchValue = event.x * 180 / pi;
    //         // rollValue = event.z * 180 / pi;
    //          checkTilt();
    //
    //       });
    //     },
    //   ),
    // );
    motionSensors.isOrientationAvailable().then((available) {
      if (available) {
        motionSensors.orientation.listen((OrientationEvent event) {
          setState(() {
            _orientation.setValues(event.yaw, event.pitch, event.roll);
            pitchValue = event.pitch * 180 / pi;
            rollValue = event.roll * 180 / pi;
            checkTilt();
          });
        });
      }
    });
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

  late double pitchValue;
  late double rollValue;
  late double yawValue;
  late double maxPitch = 34;
  late double maxRoll = 34;
  late double permitTilt = 0.25;
  late double ballRadius = 2;
  late double ballDrawingMargin = ballRadius * 1.2;
  late double ballPositionX = 0.0;
  late double ballPositionY = 0.0;
  var width = 80;
  var height = 72;

  checkTilt() {
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
      var center = validHeight / 2;
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
    var ballPositionXInt = ballPositionX.round() - width / 2;
    var ballPositionYInt = ballPositionY.round() - height / 2;
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
          Center(
            child: Container(
              key: key,
              width: 100,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.red, width: 1.0, style: BorderStyle.solid),
              ),
            ),
          ),
          GestureDetector(
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

          Center(

            child: Wrap(
                spacing: 100,

                direction: Axis.vertical,
                children: [
                  CustomPaint(
                      painter: MyPainter(
                          ballPositionX, ballPositionY, isPermitReading)),

                  // Container(
                  //   child: Text(
                  //     "X:$ballPositionXInt Y:$ballPositionYInt",
                  //     style:
                  //         const TextStyle(fontSize: 12, color: Colors.green),
                  //   ),
                  // ),
                  AnimatedOpacity(
                      duration: const Duration(milliseconds: 0),
                      opacity: isPermitReading == false ? 1 : 0.0,
                      child: const Text(
                        'スマートフォンの角度を調整してください',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      )),
                ]),
          ),
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
    return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
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
