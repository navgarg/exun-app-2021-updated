import 'dart:ui';

import 'package:exun_app_21/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants.dart';

late YoutubePlayerController _controller;

class TalksTile extends StatelessWidget {
  final String title;
  final String videoUrl;
  final String image;
  final String aboutTalk;
  final String aboutSpeaker;
  final String speaker;


  const TalksTile({
    Key? key,
    required this.title,
    required this.aboutTalk,
    required this.image,
    required this.aboutSpeaker,
    required this.speaker,
    required this.videoUrl,
  }) : super(key: key);


  //todo: check overflow problem on full screen and otherwise.
  //todo: check why same vid is being repeated.

  @override
  Widget build(BuildContext context) {
    // String icon = "circuit";

    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    print("url:");
    print(videoUrl);
    print(videoID);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          showLiveFullscreenButton: true,
        )
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
        child: ListTile(
          title: Text("$title",
            style: const TextStyle(
              fontSize: 16,
              color: KColors.primaryText,
            ),
          ),
          subtitle: Text("$aboutTalk",
            style: const TextStyle(
              fontSize: 13,
              color: KColors.bodyText,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.white,
                    appBar: AppBar(title: const Text('Exun Talks')),
                    body: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$title",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: KColors.primaryText,
                              ),
                            ),

                          SizedBox(
                            height: 35.0,
                          ),
                          YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              onReady: (){
                                // _controller.addListener(listener);
                              },
                            ),
                          SizedBox(
                            height: 35.0,
                          ),
                          Text("About the Speaker: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: KColors.primaryText
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),

                          ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: Image.asset('assets/$image.png'),
                            title: Text("$speaker",
                              style: const TextStyle(
                                fontSize: 15,
                                color: KColors.primaryText,
                              ),),
                            subtitle: Text(
                              "$aboutSpeaker",
                              style: const TextStyle(
                                color: KColors.bodyText,
                                fontSize: 13.0,
                              ),
                            ),
                            isThreeLine: true,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: KColors.border, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    )
                );
              }),
            );
          },
          isThreeLine: true,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: KColors.border, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );

  }

  // return Scaffold(
//     body: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             onReady: () {
//               // _controller.addListener(listener);
//             },
//
//         ),
//
//       ],
//     ),
//   );
}
