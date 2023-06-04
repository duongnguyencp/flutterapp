import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Hello extends ConsumerStatefulWidget {
  const Hello({Key? key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HelloState();
}

class _HelloState extends ConsumerState<Hello> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class IconItemView extends StatefulWidget {
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
  State<IconItemView> createState() => _IconItemViewState();
}

class _IconItemViewState extends State<IconItemView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        IconButton(
            icon: Icon(widget.icon),
            color: widget.selected ? Colors.blue : Colors.white,
            onPressed: widget.onPressed),
        Text(widget.text,
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
