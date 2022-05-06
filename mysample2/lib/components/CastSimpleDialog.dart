import 'package:flutter/material.dart';

import 'RowItemModelView.dart';

class CastSimpleDialog extends StatelessWidget {
  const CastSimpleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Connect to a device'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            RowItemModelView(
                iconData: Icons.downloading_outlined,
                textContent: "No device found",
                iconSize: 24,
                textSize: 12,
                event: () => {}),
            RowItemModelView(
                iconData: Icons.connected_tv,
                textContent: "Link width TV code",
                iconSize: 24,
                textSize: 18,
                event: () => {}),
            RowItemModelView(
                iconData: Icons.info_outline_rounded,
                textContent: "Learn more",
                iconSize: 24,
                textSize: 18,
                event: () => {}),
          ]),
        )
      ],
    );
  }
}



