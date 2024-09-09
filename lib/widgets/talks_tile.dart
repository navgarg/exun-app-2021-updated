import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/screens/talk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants.dart';
import '../screens/talks_screen.dart';

class TalksTile extends StatefulWidget {
  final String title;
  final String videoUrl;
  final String image;
  final String aboutTalk;
  final String aboutSpeaker;
  final String speaker;
  final String talkId;


  const TalksTile({
    Key? key,
    required this.title,
    required this.aboutTalk,
    required this.image,
    required this.aboutSpeaker,
    required this.speaker,
    required this.videoUrl,
    required this.talkId,
  }) : super(key: key);


  @override
  _TalksTileState createState() => _TalksTileState();
}
class _TalksTileState extends State<TalksTile>{

  @override
  Widget build(BuildContext context) {
    // String icon = "circuit";


    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);
    print("url:");
    print(videoID);
    var title = widget.title;
    var aboutTalk = widget.aboutTalk;

    // var icon = Icon(Icons.favorite_border, size: 30, color: Colors.pink,);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
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
                return TalkPage(
                  title: title,
                  aboutTalk: aboutTalk,
                  image: widget.image,
                  aboutSpeaker: widget.aboutSpeaker,
                  speaker: widget.speaker,
                  videoUrl: widget.videoUrl,
                  talkId: widget.talkId,);
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
}
