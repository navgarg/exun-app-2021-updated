import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants.dart';

late YoutubePlayerController _controller;

class TalkPage extends StatefulWidget {

  final String title;
  final String videoUrl;
  final String image;
  final String aboutTalk;
  final String aboutSpeaker;
  final String speaker;
  final String talkId;

  const TalkPage({
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
  _TalkPageState createState() => _TalkPageState();
}
class _TalkPageState extends State<TalkPage>{
  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);
    var title = widget.title;
    // var aboutTalk = widget.aboutTalk;
    var aboutSpeaker = widget.aboutSpeaker;
    var image = widget.image;
    var speaker = widget.speaker;
    var talkId = widget.talkId;
    final _firestore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser;

    Future<void> onLike() async {
      setState(() {
        toggle = !toggle;
      });
      final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
      print("snapshot");
      // print(currentUser?.uid);
      print(snapshot.data());
      List<dynamic>? likedTalks = snapshot.data()?["likedTalks"];
      if (toggle){
        if (!likedTalks!.contains(talkId)){
          likedTalks.add(talkId);
          Fluttertoast.showToast(msg: "successfully added to favourites!");
        }
        else {
          Fluttertoast.showToast(msg: "This talk is already in favourites.");

        }
      }
      else {
        likedTalks?.removeWhere((id) => id.toString() == talkId);
        Fluttertoast.showToast(msg: "Successfully removed from favourites");
      }
      // likedTalks?.insert(0, talkId);
      print(likedTalks);
      _firestore.collection("users").doc(currentUser?.uid)
          .set({'likedTalks': likedTalks,
        'events': snapshot.data()?["events"],
        'name': snapshot.data()?["name"],
        'email': snapshot.data()?["email"],
        'role': snapshot.data()?["role"],
      })
          .then((value) => print("Talk Added"))
          .catchError((error) => print("Failed to add talk: $error"));
      // print(data);
      // Fluttertoast.showToast(msg: "msg");
      print(toggle);
    }

    Future<void> checkToggle() async {
      final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
      List<dynamic>? likedTalks = snapshot.data()?["likedTalks"];
      if (likedTalks!.contains(talkId)){
        toggle = true;
       }
    }

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          showLiveFullscreenButton: true,
        )
    );

    // checkToggle();
    return FutureBuilder(
        future: checkToggle(),
        builder: (ctx, snapshot){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Exun Talks'),
              backgroundColor: Colors.white,
            ),
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
                  //         //todo: check why toggle not working
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () => onLike(),
                child: toggle ? Icon(Icons.favorite, color: Colors.pink,)
                    : Icon(Icons.favorite_border, color: Colors.pink,)
            ),
          );
    });
  }

}