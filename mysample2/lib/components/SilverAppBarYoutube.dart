
import 'package:flutter/material.dart';

import 'CastSimpleDialog.dart';

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
                      onTap: () => {
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