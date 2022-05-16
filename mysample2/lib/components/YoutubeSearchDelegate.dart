import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../resource/VideoModel.dart';
import '../resource/data.dart';
import 'ItemVideoCardView.dart';

class YoutubeSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Search Youtube";

  @override
  // TODO: implement searchFieldDecorationTheme
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        filled: true,

      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.keyboard_voice,
          size: 24,
        ),
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
    List results = listVideos.map((video) {
      if (video.nameVideo.toLowerCase().contains(query.toLowerCase())) {
        return video;
      }
    }).toList();
    if (results.isEmpty) {
      return const Offstage();
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        if(results[index]==null){
          return Offstage();
        }
        return ItemVideoCardView(viewModel: results[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List results = listVideos.map((video) {
      if (video.nameVideo.toLowerCase().contains(query.toLowerCase())) {
        return video;
      }
    }).toList();
    return Container(
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final video = results[index];
            if(video==null){
              return Offstage();
            }
            return Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                      flex: 1, child: Icon(Icons.search_outlined, size: 24)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(video.nameVideo,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: fontFamily)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.network(video.srcVideoImage),
                  ),
                  const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          size: 24,
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }
}
