import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image/image.dart' as imagedart;

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

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(color: Colors.cyan.withOpacity(0.1)),
          Positioned(
            child: GestureDetector(
              onTap: () async {
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
          Positioned(
            top: 152,
            left: 146,
            child: Container(
              key: key,
              width: 100,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.yellow, width: 1.0, style: BorderStyle.solid),
              ),
            ),
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
    File croppedFile =
        await FlutterNativeImage.cropImage(filePath,x, y, width!, height! );
    return croppedFile.path;
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Display picture" + imagePath)),
      body: Stack(fit: StackFit.expand, children: [
        Image.file(File(imagePath)),
        Positioned(
            top: 0,
            left: 0,
            child: Container(width: 100, height: 500, color: Colors.red))
      ]),
    );
  }
}
