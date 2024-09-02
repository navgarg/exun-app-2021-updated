import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/widgets/talks_tile.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class TalksScreen extends StatefulWidget{
  const TalksScreen({Key? key}) : super(key: key);

  @override
  State<TalksScreen> createState() => _TalksScreenState();
}

class Talk {
  String title;
  String videoUrl;
  String image;
  String aboutTalk;
  String aboutSpeaker;
  String speaker;


  Talk(
      this.title, this.videoUrl, this.aboutSpeaker, this.image, this.aboutTalk, this.speaker
      );

  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      json['title'],
      json['videoUrl'],
      json['aboutSpeaker'],
      json['image'],
      json['aboutTalk'],
      json['speaker']
    );
  }

  factory Talk.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Talk(
        data["title"],
        data['videoUrl'],
        data['aboutSpeaker'],
        data['image'],
        data['aboutTalk'],
        data['speaker']

    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'videoUrl': videoUrl,
    'aboutTalk': aboutTalk,
    'image': image,
    'aboutSpeaker': aboutSpeaker,
    'speaker': speaker
  };
}

class _TalksScreenState extends State<TalksScreen> {

  // final videoUrl = 'https://www.youtube.com/watch?v=BBAyRBTfsOU';
  // late YoutubePlayerController _controller;

  List<Talk> _talks = [];
  final _firestore = FirebaseFirestore.instance;
  bool _talkLoaded = false;

  @override
  void initState() {

    // final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    // _controller = YoutubePlayerController(
    //     initialVideoId: videoID!,
    //     flags: YoutubePlayerFlags(
    //       autoPlay: true,
    //       enableCaption: true,
    //       showLiveFullscreenButton: true,
    //     )
    // );
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("is this called?");
      _talkLoaded = false;
      fetchTalks();
    });
  }

  Future<void> fetchTalks() async {
    // await openBox();
    print("talk loaded?");
    print(_talkLoaded);
    if (!_talkLoaded) {
      final snapshot = await _firestore.collection("talks").get();
      print("snapshot");
      print(snapshot);
      print(snapshot.docs);
      _talks = snapshot.docs.map((e) => Talk.fromSnapshot(e)).toList();
      print(_talks);
      // try {
      //   var uri = generateUrl(getTalksUrl);
      //   print(uri);
      //   var value = await get(uri);
      //   print("value");
      //   print(value);
      //   print("value");
      //   var parsed = json.decode(value.body);
      //   print(parsed);
      //   print(parsed["statusCode"]);
      //   if (parsed["statusCode"] == "S10001") {
      //     print("in if");
      //     print(parsed["rows"]);
      //     _talks = parsed['rows']
      //         .map<Talk>((json) => Talk.fromJson(json))
      //         .toList();
      //     print(_talks);
          _talkLoaded = true;
          print(_talkLoaded);
      //   }
        setState(() {});
      // } catch (e) {
      //   _talks = [];
      //   print("error");
      //   print(e);
      //   print("error");
      //   _talkLoaded = true;
      //
      //   setState(() {});
      // }
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchTalks(),
      builder: (ctx, snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () {
          _talkLoaded = false;
          return fetchTalks();
        },
        child: ListView.builder(
          itemCount: _talks.length,
          itemBuilder: (BuildContext context, int index) {
            Talk talk = _talks[index];
            return TalksTile(
              title: talk.title,
              aboutSpeaker: talk.aboutSpeaker,
              videoUrl: talk.videoUrl,
              aboutTalk: talk.aboutTalk,
              speaker: talk.speaker,
              image: talk.image
            );
          },
        ),
      ),
    );
  }
}

  //   return Scaffold(
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
  // }
  
