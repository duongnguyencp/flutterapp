import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mysample2/constants.dart';
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
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    const title = 'Grid List';
    return const WrapBottomBar();
  }
}

class IconBottomBar extends StatelessWidget {
  final bool selected;
  final String text;
  final IconData icon;
  final Function() onPressed;

  const IconBottomBar({Key? key,
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
            iconSize: 20,
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
            height: 55,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
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
                        iconSize: 30,
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

class RowItemModelView extends StatelessWidget {
  final IconData iconData;
  final String textContent;
  final double iconSize;
  final double textSize;
  final Function() event;

  const RowItemModelView({Key? key,
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

class DetailModelBottomSheet extends StatelessWidget {
  const DetailModelBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0)),
      //
      //     border: Border.all(width: 1, color: Colors.grey)),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Divider(
          //   height: 1,
          //   color: Colors.grey,
          // ),
          RowItemModelView(
              iconData: Icons.library_add_outlined,
              textContent: "Save to library",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.offline_share_outlined,
              textContent: "Share",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
          RowItemModelView(
              iconData: Icons.not_interested,
              textContent: "Not interested",
              iconSize: 18,
              textSize: 12,
              event: () => {}),
        ],
      ),
    );
  }
}

class SliverAppBarYoutube extends StatefulWidget {
  const SliverAppBarYoutube({Key? key}) : super(key: key);

  @override
  State<SliverAppBarYoutube> createState() => _SliverAppBarYoutubeState();
}

class _SliverAppBarYoutubeState extends State<SliverAppBarYoutube> {
  final bool _pinned = false;

  final bool _snapped = true;

  final bool _floating = true;

  int _selectedCategoryIdx = 0;
  final itemKey = GlobalKey();
  final List<String> categorys = [
    "Tất cả",
    "Danh sách kết hợp",
    "Trò chơi",
    "Chương trình nấu ăn",
    "Bóng đá"
  ];

  setIndexCategory(int index) {
    _selectedCategoryIdx = index;
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: _pinned,
      snap: _snapped,
      collapsedHeight: 100,
      floating: _floating,
      backgroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: const BoxDecoration(),
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
                  spacing: 30,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cast_outlined),
                      iconSize: 24,
                      onPressed: () {
                        callCastDialog(context);
                      },
                    ),
                    const Icon(Icons.notifications_none_outlined, size: 24),
                    const Icon(Icons.search_outlined),
                    const CircleAvatar(
                      maxRadius: 14,
                      backgroundColor: Colors.green,
                      child: Text("d", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 10)
                  ],
                )
              ],
            ),
            const Divider(
              height: 1,
              indent: 5,
              endIndent: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 30,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: categorys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () =>
                      {
                        setState(() {
                          setIndexCategory(index);

                        })
                      },
                      child: Container(

                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(5),
                        child: Text(categorys[index]),
                        decoration: BoxDecoration(
                            color: _selectedCategoryIdx == index
                                ? Colors.grey
                                : Colors.white,
                            border: Border.all(
                                color: Colors.black,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> callCastDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CastSimpleDialog();
      });
}

class CastSimpleDialog extends StatelessWidget {
  const CastSimpleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Connect to a device'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            RowItemModelView(
                iconData: Icons.downloading_outlined,
                textContent: "No device found",
                iconSize: 24,
                textSize: 12,
                event: () => {}),
            RowItemModelView(
                iconData: Icons.connected_tv,
                textContent: "Link width TV code",
                iconSize: 24,
                textSize: 18,
                event: () => {}),
            RowItemModelView(
                iconData: Icons.info_outline_rounded,
                textContent: "Learn more",
                iconSize: 24,
                textSize: 18,
                event: () => {}),
          ]),
        )
      ],
    );
  }
}
