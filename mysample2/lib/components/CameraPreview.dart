import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
    return Stack(alignment: AlignmentDirectional.topStart, children: [
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
      Positioned(
        bottom: 50,
        right: 190,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      )
    ]);
  }
}
