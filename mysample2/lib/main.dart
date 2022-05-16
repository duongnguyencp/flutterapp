import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mysample2/constants.dart';
import 'package:mysample2/resource/VideoModel.dart';
import 'package:mysample2/resource/data.dart';

import 'components/IconBottomBar.dart';
import 'components/ItemVideoCardView.dart';
import 'components/ModalSheetAdd.dart';
import 'components/SilverAppBarYoutube.dart';

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
      debugShowCheckedModeBanner: false,
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22))),
          context: context,
          builder: (BuildContext context) {
            return const ModelSheetAdd();
          });
    }
  }

  final List<Widget> screen = [
    CustomScrollView(
      slivers: [
        const SliverAppBarYoutube(),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          if (index >= listVideos.length) {
            return const Offstage();
          }
          return ItemVideoCardView(viewModel: listVideos[index]);
        }, childCount: listVideos.length)),
      ],
    ),
    CustomScrollView(
      slivers: [
        const SliverAppBarYoutube(),
        SliverList(delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return Text("short");
        })),
      ],
    ),
    CustomScrollView(
      slivers: [
        const SliverAppBarYoutube(),
        SliverList(delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return ItemVideoCardView(viewModel: listVideos[0]);
        })),
      ],
    ),
    CustomScrollView(
      slivers: [
        const SliverAppBarYoutube(),
        SliverList(delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return Text("subscriptions");
        })),
      ],
    ),
    CustomScrollView(
      slivers: [
        const SliverAppBarYoutube(),
        SliverList(delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return Text("Library");
        })),
      ],
    ),
  ];
  late var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectedIndex],
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: IconBottomBar(
                        selected: false,
                        text: "Home",
                        icon: selectedIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        onPressed: () {
                          setState(() {
                            onClickItemBottomBar(1);
                          });
                        }),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconBottomBar(
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
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child:
                        IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 28,
                            ),
                            iconSize: 28,
                            onPressed: () {
                              setState(() {
                                onClickItemBottomBar(3);
                              });
                            }),


                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconBottomBar(
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
                  ),
                  Expanded(
                    flex: 1,
                    child: IconBottomBar(
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
