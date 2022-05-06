import 'package:flutter/material.dart';

import 'RowItemModelView.dart';

class DetailModelBottomSheet extends StatelessWidget {
  const DetailModelBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0)),
      //
      //     border: Border.all(width: 1, color: Colors.grey)),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Divider(
          //   height: 1,
          //   color: Colors.grey,
          // ),
          RowItemModelView(
              iconData: Icons.library_add_outlined,
              textContent: "Save to library",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.offline_share_outlined,
              textContent: "Share",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.not_interested,
              textContent: "Not interested",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
        ],
      ),
    );
  }
}
