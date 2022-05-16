import 'package:flutter/material.dart';

class IconBottomBar extends StatelessWidget {
  final bool selected;
  final String text;
  final IconData icon;
  final Function() onPressed;

  const IconBottomBar(
      {Key? key,
        required this.selected,
        required this.text,
        required this.icon,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          flex: 3,
          child: IconButton(
              icon: Icon(icon),
              color: Colors.black,
              iconSize: 24,
              onPressed: onPressed),
        ),
        Expanded(
          flex:1,
          child: Text(text,
              style: const TextStyle(
                  fontSize: 8,
                  height: .1,
                  fontFamily: 'Roboto,Arial,sans-serif')),
        ),
      ],
    );
  }
}
