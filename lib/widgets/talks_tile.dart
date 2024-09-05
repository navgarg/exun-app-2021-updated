import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants.dart';
import '../screens/talks_screen.dart';

late YoutubePlayerController _controller;

class TalksTile extends StatefulWidget {
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


  @override
  _TalksTileState createState() => _TalksTileState();
}
class _TalksTileState extends State<TalksTile>{

  bool toggle = false;

  //todo: check overflow problem on full screen and otherwise.
  //todo: check why same vid is being repeated.

  @override
  Widget build(BuildContext context) {
    // String icon = "circuit";


    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);
    print("url:");
    print(videoID);
    var title = widget.title;
    var aboutTalk = widget.aboutTalk;
    var aboutSpeaker = widget.aboutSpeaker;
    var image = widget.image;
    var speaker = widget.speaker;
    final _firestore = FirebaseFirestore.instance;

    // var icon = Icon(Icons.favorite_border, size: 30, color: Colors.pink,);

    Future<void> onLike() async {
      setState(() {
        toggle = !toggle;
      });
      final snapshot = await _firestore.collection("talks").where("videoUrl", isEqualTo: widget.videoUrl).get();
      var data = snapshot.docs.toList();
      print(data);
      Fluttertoast.showToast(msg: "msg");
      print(toggle);
    }


    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          showLiveFullscreenButton: true,
        )
    );
    return SingleChildScrollView(
      child: Padding(
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
                          SizedBox(
                            height: 55.0,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text("Like",
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold,
                          //         color: KColors.primaryText,
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         onLike();
                          //       },
                          //       icon:
                          //         !toggle
                          //           ? Icon(Icons.favorite_border,
                          //           color: Colors.pink,
                          //           size: 30)
                          //           : Icon(Icons.favorite,
                          //           color: Colors.pink,
                          //           size: 30,)
                          //         //todo: check why toggle not working
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  floatingActionButton: FloatingActionButton(onPressed: () => onLike(),
                  child: toggle ? Icon(Icons.favorite, color: Colors.pink,)
                    : Icon(Icons.favorite_border, color: Colors.pink,)
                  ),
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
