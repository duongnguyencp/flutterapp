import 'package:flutter/material.dart';

import '../resource/VideoModel.dart';
import 'CustomListTile.dart';
import 'DetailModelBottomSheet.dart';

class ItemVideoCardView extends StatelessWidget {
  final VideoModel viewModel;

  const ItemVideoCardView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image.network(viewModel.srcVideoImage),
            Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(5),
                color: Colors.black.withOpacity(0.9),
                child: Text(viewModel.timeVideo,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "Roboto,Arial,sans-serif")))
          ],
        ),
        CustomListTile(videoModel:viewModel)
      ],
    );
  }
}
