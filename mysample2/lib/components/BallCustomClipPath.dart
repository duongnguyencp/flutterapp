import 'package:flutter/material.dart';

class BallCustomClipPath extends CustomClipper<Path>{
  late double width;
  late double height;
  @override
  Path getClip(Size size) {
    Path path= Path();
    path.moveTo(0, height/2);
    path.lineTo(width, height/2);
    path.

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

   return false;
  }





  
}