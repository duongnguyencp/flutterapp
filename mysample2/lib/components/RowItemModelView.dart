import 'package:flutter/material.dart';

class RowItemModelView extends StatefulWidget {
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
  State<RowItemModelView> createState() => _RowItemModelViewState();
}

class _RowItemModelViewState extends State<RowItemModelView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            iconSize: widget.iconSize,
            icon: Icon(widget.iconData),
            onPressed: widget.event),
        Text(
          widget.textContent,
          style: TextStyle(fontSize: widget.textSize),
        )
      ],
    );
  }
}
