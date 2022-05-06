import 'package:flutter/material.dart';

import 'RowItemModelView.dart';

class ModelSheetAdd extends StatelessWidget {
  const ModelSheetAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 10.0, right: 10.0, bottom: 0.0),
      height: 230,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                  iconSize: 22,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_outlined, color: Colors.black))
            ],
          ),
          RowItemModelView(
              iconData: Icons.tiktok_outlined,
              textContent: "Create a Short",
              iconSize: 22.0,
              textSize: 12.0,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.upload_outlined,
              textContent: "Upload a video",
              iconSize: 22.0,
              textSize: 12.0,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.live_tv_outlined,
              textContent: "Go live",
              iconSize: 22.0,
              textSize: 12.0,
              event: () => {})
        ],
      ),
    );
  }
}