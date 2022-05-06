import 'package:flutter/material.dart';

class RowItemModelView extends StatelessWidget {
  final IconData iconData;
  final String textContent;
  final double iconSize;
  final double textSize;
  final Function() event;

  const RowItemModelView(
      {Key? key,
        required this.iconData,
        required this.textContent,
        required this.iconSize,
        required this.textSize,
        required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(iconSize: iconSize, icon: Icon(iconData), onPressed: event),
        Text(
          textContent,
          style: TextStyle(fontSize: textSize),
        )
      ],
    );
  }
}