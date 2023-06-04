import 'package:flutter/material.dart';

import '../resource/VideoModel.dart';
import 'CustomListTile.dart';
import 'DetailModelBottomSheet.dart';

class ItemVideoCardView extends StatefulWidget {
  final VideoModel viewModel;

  const ItemVideoCardView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<ItemVideoCardView> createState() => _ItemVideoCardViewState();
}

class _ItemVideoCardViewState extends State<ItemVideoCardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(image: AssetImage(widget.viewModel.srcVideoImage)),
            Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(5),
                color: Colors.black.withOpacity(0.9),
                child: Text(widget.viewModel.timeVideo,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "Roboto,Arial,sans-serif")))
          ],
        ),
        CustomListTile(videoModel: widget.viewModel)
      ],
    );
  }
}
