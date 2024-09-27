import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/widgets/talks_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/store.dart';

class TalksScreen extends StatefulWidget{
  const TalksScreen({Key? key}) : super(key: key);

  @override
  State<TalksScreen> createState() => _TalksScreenState();
}

//todo: use state for liked/favourite talks.
//todo: use state for get role.

class Talk {
  String title;
  String videoUrl;
  String image;
  String aboutTalk;
  String aboutSpeaker;
  String speaker;
  String talkId;


  Talk(
      this.title, this.videoUrl, this.aboutSpeaker, this.image, this.aboutTalk, this.speaker, this.talkId
      );

  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      json['title'],
      json['videoUrl'],
      json['aboutSpeaker'],
      json['image'],
      json['aboutTalk'],
      json['speaker'],
      json["talkId"]
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
        data['speaker'],
      data["talkId"],

    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'videoUrl': videoUrl,
    'aboutTalk': aboutTalk,
    'image': image,
    'aboutSpeaker': aboutSpeaker,
    'speaker': speaker,
    'talkId': talkId
  };
}

class _TalksScreenState extends State<TalksScreen> with WidgetsBindingObserver{

  // final videoUrl = 'https://www.youtube.com/watch?v=BBAyRBTfsOU';
  // late YoutubePlayerController _controller;

  List<Talk> _likedTalks = [];
  List<Talk> _unlikedTalks = [];
  List<Talk> _talks = [];
  final _firestore = FirebaseFirestore.instance;
  bool _talkLoaded = false;
  var currentUser = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("is this called?");
      _talkLoaded = false;
      fetchTalks();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.resumed){
      setState(() {});
    }
    print("applifecycle changes");
  }

  Future<void> fetchTalks() async {
    print("talk loaded?");
    print(_talkLoaded);
    if (!_talkLoaded) {
      final tsnapshot = await _firestore.collection("talks").get();
      print("snapshot");
      print(tsnapshot);
      print(tsnapshot.docs);
      _talks = tsnapshot.docs.map((e) => Talk.fromSnapshot(e)).toList();
      print(_talks);
      final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
      print("snapshot");
      // print(currentUser?.uid);
      print(snapshot.data());
      List<dynamic>? likedTalks = snapshot.data()?["likedTalks"];
      _likedTalks = [];
      _unlikedTalks = [];
      for (Talk talk in _talks){
        if (likedTalks!.contains(talk.talkId)){
          _likedTalks.add(talk);
          print(_likedTalks);
          print("liked");
        }
        else{
          _unlikedTalks.add(talk);
          print(_unlikedTalks);
          print("unliked");
        }
      }
      print("talks");
      print(_likedTalks);
      print(_unlikedTalks);
      _talkLoaded = true;
      print(_talkLoaded);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> fav = ["Favourites", "Non-Favourites"];
    return StoreProvider<AppState>(
        store: Redux.store,
        child: Scaffold(
          body: Column(
            children: [
              StoreConnector<AppState, bool>(
                distinct: true,
                converter: (store) => store.state.talksState.isLoading,
                builder: (context, isLoading) =>
                  isLoading ? CircularProgressIndicator()
                   : SizedBox.shrink()
              ),
              StoreConnector<AppState, bool>(
                distinct: true,
                converter: (store) => store.state.talksState.isError,
                builder: (context, isError) {
                  if (isError) {
                    return Text("Failed to get talks");
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              Expanded(
                child: StoreConnector<AppState, List<Talk>>(
                  distinct: true,
                  converter: (store) => store.state.talksState.talks,
                  builder: (context, talks) {
                    return
                      // ListView.builder(
                                  // itemCount: 2,
                                  // physics: ClampingScrollPhysics(),
                                  // itemBuilder: (BuildContext context, int index) {
                                  //   List<Talk> talks;
                                  //   index == 0 ? talks = _likedTalks : talks = _unlikedTalks;
                                  //   return Padding(
                                  //     key: UniqueKey(),
                                  //       padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           fav[index],
                                  //           style: const TextStyle(
                                  //             fontSize: 17,
                                  //             fontWeight: FontWeight.bold,
                                  //             color: KColors.primaryText,
                                  //           ),
                                  //         ),
                                          ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: talks.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              Talk talk = talks[index];
                                              // print("talk sent");
                                              return TalksTile(
                                                title: talk.title,
                                                aboutSpeaker: talk.aboutSpeaker,
                                                videoUrl: talk.videoUrl,
                                                aboutTalk: talk.aboutTalk,
                                                speaker: talk.speaker,
                                                image: talk.image,
                                                talkId: talk.talkId,
                                              );
                                            },
                                          );
                                        // ],
                                      // ),
                                    // );
                                  // });
                  },
                ),
              ),
            ],
          ),
        )
    );





    //   FutureBuilder(
    //   future: fetchTalks(),
    //   builder: (ctx, snapshot) =>
    //   snapshot.connectionState == ConnectionState.waiting
    //       ? Center(
    //     child: CircularProgressIndicator(),
    //   )
    //       : RefreshIndicator(
    //     onRefresh: () {
    //       _talkLoaded = false;
    //       return fetchTalks();
    //     },
    //       child: ListView.builder(
    //           itemCount: 2,
    //           physics: ClampingScrollPhysics(),
    //           itemBuilder: (BuildContext context, int index) {
    //             List<Talk> talks;
    //             index == 0 ? talks = _likedTalks : talks = _unlikedTalks;
    //             return Padding(
    //               key: UniqueKey(),
    //                 padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     fav[index],
    //                     style: const TextStyle(
    //                       fontSize: 17,
    //                       fontWeight: FontWeight.bold,
    //                       color: KColors.primaryText,
    //                     ),
    //                   ),
    //                   ListView.builder(
    //                     scrollDirection: Axis.vertical,
    //                     shrinkWrap: true,
    //                     itemCount: talks.length,
    //                     itemBuilder: (BuildContext context, int index) {
    //                       Talk talk = talks[index];
    //                       // print("talk sent");
    //                       return TalksTile(
    //                         title: talk.title,
    //                         aboutSpeaker: talk.aboutSpeaker,
    //                         videoUrl: talk.videoUrl,
    //                         aboutTalk: talk.aboutTalk,
    //                         speaker: talk.speaker,
    //                         image: talk.image,
    //                         talkId: talk.talkId,
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             );
    //           }
    //       ),
    //   ),
    // );
  }
}
  
