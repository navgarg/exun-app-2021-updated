import 'dart:ui';

import 'package:exun_app_21/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants.dart';

late YoutubePlayerController _controller;

class TalksTile extends StatelessWidget {
  final String title;
  final String videoUrl;
  final String about;

  const TalksTile({
    Key? key,
    required this.title,
    required this.about,
    required this.videoUrl,
  }) : super(key: key);


  //todo: check overflow on full screen.

  @override
  Widget build(BuildContext context) {
    String icon = "circuit";
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
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
          subtitle: Text("$about",
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
                    appBar: AppBar(title: const Text('Exun Talks')),
                    body: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("$title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: KColors.primaryText,
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              onReady: (){
                                // _controller.addListener(listener);
                              },
                            ),
                          SizedBox(
                            height: 25.0,
                          ),
                          // Text("About the Speakers: ",
                          // style: TextStyle(
                          //   fontSize: 16,
                          //   color: KColors.primaryText
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15.0,
                          // ),
                          //
                          // Expanded(
                          //     child: ListView.builder(
                          //         scrollDirection: Axis.horizontal,
                          //         itemBuilder: (context, index){
                          //         return Padding(
                          //             padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          //             child: GestureDetector(
                          //               onTap: () async {
                          //                 return showDialog(
                          //                     context: context,
                          //                     builder: (BuildContext context) {
                          //                       return NotificationDialog(
                          //                           heading: "$title",
                          //                           content: "$about");
                          //
                          //                     });
                          //               },
                          //
                          //               child: ListTile(
                          //                 title: Text("$title",
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: KColors.primaryText,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //                 subtitle: Text("$about",
                          //                   style: TextStyle(
                          //                     fontSize: 12,
                          //                   ),
                          //                 ),
                          //               isThreeLine: true,
                          //               shape: RoundedRectangleBorder(
                          //                 side: const BorderSide(color: KColors.border, width: 1),
                          //                 borderRadius: BorderRadius.circular(8.0),
                          //               ),
                          //               ),
                          //
                          //             )
                          //         );
                          //
                          //     }
                          // )
                          // )
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
