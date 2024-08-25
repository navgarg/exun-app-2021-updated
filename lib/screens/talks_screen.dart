import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TalksScreen extends StatefulWidget{
  const TalksScreen({Key? key}) : super(key: key);

  @override
  State<TalksScreen> createState() => _TalksScreenState();
}

class _TalksScreenState extends State<TalksScreen> {

  final videoUrl = 'https://www.youtube.com/watch?v=BBAyRBTfsOU';
  late YoutubePlayerController _controller;

  @override
  void initState() {

    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          enableCaption: true,
          showLiveFullscreenButton: true,
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                // _controller.addListener(listener);
              },

          ),

        ],
      ),
    );
  }
  
}