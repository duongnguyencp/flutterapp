import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resource/VideoModel.dart';

class ArticleDescription extends StatelessWidget {
  final VideoModel videoModel;

  const ArticleDescription({Key? key, required this.videoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(videoModel.nameVideo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8,bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(videoModel.nameChanel,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(
                width: 2,
              ),
              const Text("•", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              Text(videoModel.numberView,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(width: 2),
              const Text("•", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              Text(videoModel.timeUploaded,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}
