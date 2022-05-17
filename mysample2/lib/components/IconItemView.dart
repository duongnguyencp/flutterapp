import 'package:flutter/material.dart';

class IconItemView extends StatelessWidget {
  final bool selected;
  final String text;
  final IconData icon;
  final Function() onPressed;

  const IconItemView(
      {Key? key,
      required this.selected,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Icon(icon,color:Colors.white,),
        Text(text,
            style: const TextStyle(

                fontSize: 11,
                height: .1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto,Arial,sans-serif'))
      ],
    );
  }
}
