import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mysample2/resource/VideoModel.dart';
import 'package:mysample2/resource/data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const title = 'Grid List';
    return const WrapBottomBar();
  }
}

class IconBottomBar extends StatelessWidget {
  final bool selected;
  final String text;
  final IconData icon;
  final Function() onPressed;

  const IconBottomBar(
      {Key? key,
      required this.selected,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            icon: Icon(icon),
            color: Colors.black,
            iconSize: 25,
            onPressed: onPressed),
        Text(text,
            style: const TextStyle(
                fontSize: 12,
                height: .1,
                fontFamily: 'Roboto,Arial,sans-serif')),
      ],
    );
  }
}

class WrapBottomBar extends StatefulWidget {
  const WrapBottomBar({Key? key}) : super(key: key);

  @override
  State<WrapBottomBar> createState() => _WrapBottomBarState();
}

class _WrapBottomBarState extends State<WrapBottomBar> {
  void onClickItemBottomBar(id) {
    selectedIndex = id - 1;
    if (id == 3) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const ModelSheetAdd();
          });
    }
  }

  final List<Widget> screen = [
    Text("home"),
    Text("short"),
    Text("add"),
    Text("subscriptions"),
    Text("library")
  ];
  late var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarYoutube(),
          SliverList(delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ItemVideoCardView(viewModel: listVideos[0]);
          })),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconBottomBar(
                      selected: false,
                      text: "Home",
                      icon:
                          selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                      onPressed: () {
                        setState(() {
                          onClickItemBottomBar(1);
                        });
                      }),
                  IconBottomBar(
                      selected: false,
                      text: "Shorts",
                      icon: selectedIndex == 1
                          ? Icons.music_note
                          : Icons.music_note_outlined,
                      onPressed: () {
                        setState(() {
                          onClickItemBottomBar(2);
                        });
                      }),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 35,
                        onPressed: () {
                          setState(() {
                            onClickItemBottomBar(3);
                          });
                        }),
                  ),
                  IconBottomBar(
                      selected: false,
                      text: "Subscriptions",
                      icon: selectedIndex == 3
                          ? Icons.subscriptions
                          : Icons.subscriptions_outlined,
                      onPressed: () {
                        setState(() {
                          onClickItemBottomBar(4);
                        });
                      }),
                  IconBottomBar(
                      selected: false,
                      text: "Library",
                      icon: selectedIndex == 4
                          ? Icons.video_library
                          : Icons.video_library_outlined,
                      onPressed: () {
                        setState(() {
                          onClickItemBottomBar(5);
                        });
                      }),
                ],
              ),
            ),
          )),
    );
  }
}

class ModelSheetAdd extends StatelessWidget {
  const ModelSheetAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.cancel_outlined))
            ],
          ),
          RowItemModelView(
              iconData: Icons.tiktok_outlined,
              textContent: "Create a Short",
              iconSize: 24.0,
              textSize: 18.0,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.upload_outlined,
              textContent: "Upload a video",
              iconSize: 24.0,
              textSize: 18.0,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.live_tv_outlined,
              textContent: "Go live",
              iconSize: 24.0,
              textSize: 18.0,
              event: () => {})
        ],
      ),
    );
  }
}

class RowItemModelView extends StatelessWidget {
  final IconData iconData;
  final String textContent;
  final double iconSize;
  final double textSize;
  final Function() event;

  const RowItemModelView(
      {Key? key,
      required this.iconData,
      required this.textContent,
      required this.iconSize,
      required this.textSize,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(iconSize: iconSize, icon: Icon(iconData), onPressed: event),
        Text(
          textContent,
          style: TextStyle(fontSize: textSize),
        )
      ],
    );
  }
}

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
          trailing: const Icon(Icons.more_vert, size: 15),
          isThreeLine: true,
          subtitle: Row(
            children: [
              Text(viewModel.nameChanel),
              const SizedBox(width: 5),
              const Text("•"),
              const SizedBox(width: 5),
              Text(viewModel.numberView),
              const SizedBox(width: 5),
              const Text("•"),
              const SizedBox(width: 5),
              Text(viewModel.timeUploaded),
            ],
          ),
          title: Text(viewModel.nameVideo),
        )
      ],
    );
  }
}

class SliverAppBarYoutube extends StatelessWidget {
  final bool _pinned = false;
  final bool _snapped = true;
  final bool _floating = true;
  final List<String> categorys = ["Tất cả", "Âm nhạc"];

  SliverAppBarYoutube({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: _pinned,
      snap: _snapped,
      collapsedHeight: 100,
      floating: _floating,
      backgroundColor: Colors.white,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(top: 25, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  "https://img.icons8.com/color/144/000000/youtube-play.png",
                  width: 36,
                  height: 36,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  children: const [
                    Icon(
                      Icons.cast_outlined,
                      size: 24,
                    ),
                    Icon(Icons.notifications_none_outlined, size: 24),
                    Icon(Icons.search_outlined),
                    CircleAvatar(
                      maxRadius: 14,
                      backgroundColor: Colors.green,
                      child: Text("d", style: TextStyle(fontSize: 16)),
                    )
                  ],
                )
              ],
            ),
            Wrap(

              children: [
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorys.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child:  Text(categorys[index]),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
