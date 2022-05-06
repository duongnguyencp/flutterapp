import 'package:flutter/material.dart';

import '../resource/VideoModel.dart';
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
        ListTile(
          minVerticalPadding: 12,
          leading: CircleAvatar(
              backgroundImage: NetworkImage(viewModel.srcChanelImage)),
          trailing: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.transparent,
                          child: const DetailModelBottomSheet());
                    });
              }),
          isThreeLine: true,
          subtitle: Row(
            children: [
              Text(viewModel.nameChanel, style: TextStyle(fontSize: 12)),
              const SizedBox(
                width: 2,
              ),
              const Text("•", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              Text(viewModel.numberView, style: TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              const Text("•", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              Text(viewModel.timeUploaded, style: TextStyle(fontSize: 12)),
            ],
          ),
          title: Text(
            viewModel.nameVideo,
            style: const TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}