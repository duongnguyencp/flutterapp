import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysample2/components/IconItemView.dart';

import 'IconBottomBar.dart';

/*
  Stack has position item/ non position item
  positioned item must has least item non null property

 */

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.topStart,
        children: [
          const Image(
              width: 500,
              height: 500,
              image: AssetImage('resource/Genshin_Impact_cover.jpg'),
              fit: BoxFit.fitHeight),
          Positioned(
            bottom: 0,
            right: 0,
            height: 400,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              children: [
                IconItemView(
                    selected: false,
                    text: "15K",
                    icon: Icons.thumb_up,
                    onPressed: () => {}),
                IconItemView(
                    selected: false,
                    text: "Dislike",
                    icon: Icons.thumb_down,
                    onPressed: () => {}),
                IconItemView(
                    selected: false,
                    text: "161",
                    icon: Icons.comment,
                    onPressed: () => {}),
                IconItemView(
                    selected: false,
                    text: "Share",
                    icon: Icons.send,
                    onPressed: () => {}),
                const Icon(Icons.more_horiz, color: Colors.white),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border:Border.all(
                      color:Colors.white,
                      width: 1,
                      style: BorderStyle.solid
                    )
                  ),
                  child: const Image(
                      width: 36,
                      height: 36,
                      image: AssetImage('resource/short_profile.jpg'),
                      fit: BoxFit.fitHeight),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
