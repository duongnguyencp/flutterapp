import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysample2/main.dart';

const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;
const Color white = Color(0x00ffffff);
const Color black = Color(0x00212121);
const defaultLetterSpacing = 0.03;
const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: white,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);
Row row = Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    TextButton(onPressed: () => {}, child: const Icon(Icons.home)),
    TextButton(onPressed: () => {}, child: const Icon(Icons.tiktok)),
    TextButton(onPressed: () => {}, child: const Icon(Icons.add_circle)),
    TextButton(onPressed: () => {}, child: const Icon(Icons.subscriptions)),
    TextButton(onPressed: () => {}, child: const Icon(Icons.my_library_music)),
  ],
);


const primaryColor = Color(0xff4338CA);
const secondaryColor = Color(0xff6D28D9);
const accentColor = Color(0xffffffff);
const backgroundColor = Color(0xffffffff);
const errorColor = Color(0xffEF4444);


