import 'package:flutter/material.dart';
import 'package:mysample2/components/YoutubeSearchDelegate.dart';

import 'CastSimpleDialog.dart';

class SliverAppBarYoutube extends StatefulWidget {
  const SliverAppBarYoutube({Key? key}) : super(key: key);

  @override
  State<SliverAppBarYoutube> createState() => _SliverAppBarYoutubeState();
}

class _SliverAppBarYoutubeState extends State<SliverAppBarYoutube> {
  final dataKey = GlobalKey();
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
    "Bóng đá",
    "Âm nhạc",
    "Japanese",
    "Tin tức",
    "Đã xem"
  ];

  setIndexCategory(int index) {
    _selectedCategoryIdx = index;
  }

  double _ITEM_WIDTH = 150  ;
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
      collapsedHeight: 90,
      floating: _floating,
      backgroundColor: Colors.white,
      flexibleSpace: Container(
        margin: const EdgeInsets.only(top:5),
        padding: const EdgeInsets.only(top: 25, bottom: 5),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8),
                  child: Image(
                    image:AssetImage("resource/youtube-play.png"),
                    width: 36,
                    height: 36,
                  ),
                  // const Text("YouTube",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.black87))
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: 15,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cast_outlined),
                      iconSize: 24,
                      onPressed: () {
                        callCastDialog(context);
                      },
                    ),
                    const Icon(Icons.notifications_none_outlined, size: 24),
                    IconButton(
                      icon: const Icon(Icons.search_outlined, size: 24),
                      onPressed: () async {
                        await showSearch(
                            context: context,
                            delegate: YoutubeSearchDelegate());
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        maxRadius: 16,
                        backgroundColor: Colors.green,
                        child: Text("d", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.all(0),
              height: 30,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: categorys.length,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {
                        setState(() {
                          setIndexCategory(index);
                        }),
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          double position = index * _ITEM_WIDTH;
                          _scrollController.animateTo(position,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease);
                        })
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 50,

                        ),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(5),
                        child: Text(categorys[index]),
                        decoration: BoxDecoration(
                            color: _selectedCategoryIdx == index
                                ? Colors.grey
                                : Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(24)),
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
