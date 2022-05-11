import 'package:flutter/material.dart';

import '../resource/data.dart';

class YoutubeSearchDelegate extends SearchDelegate {

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Search Youtube";

  @override
  // TODO: implement searchFieldDecorationTheme
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
    alignLabelWithHint:
  );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.keyboard_voice,size: 24,),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {close(context, null)},
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: listVideos.length,
        itemBuilder: (context, index) {
          final video = listVideos[index];
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                    flex:1,
                    child: Icon(Icons.search_outlined,size:24)),
                Expanded(
                  flex: 4,
                  child: Wrap(
                    children: [Text(listVideos[index].nameVideo,
                        style: const TextStyle(fontSize: 18)),

                    ]
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:
                      Image.network(video.srcVideoImage),
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(Icons.arrow_forward_outlined,size: 24,))
              ],
            ),
          );
        });
  }
}
