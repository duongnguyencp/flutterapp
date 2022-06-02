import 'package:flutter/material.dart';

class BallCustomClipPath extends CustomClipper<Path> {
  double width = 350;
  double height = 350;
  static double ballRadius = 2;
  static double ballDrawingMargin = ballRadius * 1.2;
  double permitTilt = 0.25;
  double ballPositionX;
  double ballPositionY;
  bool isPermitReading;

  BallCustomClipPath(
      this.ballPositionX, this.ballPositionY, this.isPermitReading);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, height / 2);
    path.lineTo(width, height / 2);
    double validWidth = width - ballDrawingMargin * 2;
    double validHeight = height - ballDrawingMargin * 2;
    path.moveTo(width / 2, 0);
    path.lineTo(width / 2, height);
    path.addOval(Rect.fromCircle(
        center: Offset(validWidth * 0.5 + ballDrawingMargin,
            validHeight * 0.5 + ballDrawingMargin),
        radius: validWidth * permitTilt));
    double positionX = ballPositionX + ballDrawingMargin;
    double positionY = ballPositionY + ballDrawingMargin;
    path.addOval(Rect.fromCircle(
        center: Offset(positionX, positionY), radius: ballRadius));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyPainter extends CustomPainter {
  double width = 80;
  double height = 72;
  static double ballRadius = 2;
  static double ballDrawingMargin = ballRadius * 1.2;
  double permitTilt = 0.25;
  double ballPositionX;
  double ballPositionY;
  bool isPermitReading;

  MyPainter(this.ballPositionX, this.ballPositionY, this.isPermitReading);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, height / 2), Offset(width, height / 2), paint);
    double validWidth = width - ballDrawingMargin * 2;
    double validHeight = height - ballDrawingMargin * 2;
    canvas.drawLine(Offset(width / 2, 0), Offset(width / 2, height), paint);
    paint
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(validWidth * 0.5 + ballDrawingMargin,
            validHeight * 0.5 + ballDrawingMargin),
        validWidth * permitTilt,
        paint);
    paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2;
    if (isPermitReading == false) {
      paint.color = Colors.orange;
    }
    double positionX = ballPositionX + ballDrawingMargin;
    double positionY = ballPositionY + ballDrawingMargin;
    canvas.drawCircle(Offset(positionX, positionY), ballRadius+1, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
