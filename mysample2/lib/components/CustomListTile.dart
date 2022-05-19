import 'package:flutter/material.dart';

import '../resource/VideoModel.dart';
import 'ArticleDescription.dart';
import 'DetailModelBottomSheet.dart';

class CustomListTile extends StatelessWidget {
  final VideoModel videoModel;

  const CustomListTile({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  child: CircleAvatar(
                      backgroundImage: AssetImage(videoModel.srcChanelImage))),
            ),
            Expanded(
                flex: 3,
                child: ArticleDescription(
                  videoModel: videoModel,
                )),
            Container(
              padding: const EdgeInsets.only(top: 10, right: 5),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 12,

                  constraints:const BoxConstraints(),
                  icon: const Icon(Icons.more_vert, size: 16),
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              padding: const EdgeInsets.all(0),
                              color: Colors.transparent,
                              child: const DetailModelBottomSheet());
                        });
                  }),
            ),
          ],
        ),

      ],
    );
  }
}
