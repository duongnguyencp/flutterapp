import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysample2/components/IconItemView.dart';
import 'package:mysample2/resource/data.dart';

import '../constants.dart';
import 'IconBottomBar.dart';

/*
  Stack has position item/ non position item
  positioned item must has least item non null property

 */

class ShortsScreen extends StatefulWidget {
    Function() onPressedCamera;
   ShortsScreen({Key? key, required this.onPressedCamera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.maxFinite,
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.topStart,
        children: [
          Image(
              width: 500,
              height: 500,
              image: AssetImage(listShorts[0].srcVideoImage),
              fit: BoxFit.fitHeight),
          Positioned(
              top: 30,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.photo_camera_outlined),
                iconSize: 24,
                color: Colors.white,
                onPressed: widget.onPressedCamera
              )),
          Positioned(
              bottom: 10,
              left: 10,
              child: ProfileIntro(

              )),
          Positioned(
            bottom: 10,
            right: 0,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              children: [
                IconItemView(
                    selected: indexSelected == 1,
                    text: listShorts[0].numberLike,
                    icon: Icons.thumb_up,
                    onPressed: () => {
                          setState(() => {indexSelected = 1})
                        }),
                IconItemView(
                    selected: indexSelected == 2,
                    text: listShorts[0].numberDislike,
                    icon: Icons.thumb_down,
                    onPressed: () => {
                          setState(() => {indexSelected = 2})
                        }),
                IconItemView(
                    selected: false,
                    text: listShorts[0].numberComment,
                    icon: Icons.comment,
                    onPressed: () => {}),
                IconItemView(
                    selected: false,
                    text: "Share",
                    icon: Icons.send,
                    onPressed: () => {}),
                const Icon(Icons.more_horiz, color: Colors.white),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: const [
                        Image(
                            width: 36,
                            height: 36,
                            image: AssetImage('resource/short_profile.jpg'),
                            fit: BoxFit.fitHeight),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Image(
                            width: 14,
                            height: 14,
                            image: AssetImage('resource/icon-playing.gif'),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


}

class ProfileIntro extends StatefulWidget {

  ProfileIntro({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateProfileIntro();
}

class StateProfileIntro extends State<ProfileIntro> {
  bool isSubcribe = false;
  String textScribe = "SUBSCRIBE";

  void onClickSubscribe() {}

  @override
  Widget build(BuildContext context) {
    var listTag = "";
    for (var i = 0; i < listShorts[0].listTag.length; i++) {
      listTag += listShorts[0].listTag[i];
    }
    return Wrap(
      direction: Axis.vertical,
      spacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        SizedBox(
          width: 350,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(listShorts[0].nameVideo,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto,Arial,sans-serif')),
            Text(listTag,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto,Arial,sans-serif')),
          ]),
        ),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 10,
          children: [
            CircleAvatar(
              maxRadius: 18,
              backgroundImage: AssetImage(listShorts[0].srcChanelImage),
            ),
            Text(listShorts[0].nameChanel,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto,Arial,sans-serif')),
            GestureDetector(
              onTap: () {
                if (isSubcribe == true) {
                  showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                "Unsubscribe from " + listShorts[0].nameChanel),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSubcribe = false;
                                    textScribe = "SUBSCRIBE";
                                  });

                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else {
                  setState(() {
                    isSubcribe = true;
                    textScribe = "SUBSCRIBED";
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: (isSubcribe == false)
                        ? shrineErrorRed
                        : Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Text(textScribe,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto,Arial,sans-serif')),
              ),
            )
          ],
        )
      ],
    );
  }
}
