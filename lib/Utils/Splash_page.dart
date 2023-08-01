//Utils
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onIntializationComplete;

  const SplashPage({
    Key? key,
    required this.onIntializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController controller;
  bool isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    final videoUrl = await fetchVideoUrl();
    controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {
          isVideoInitialized = true;
        });
      })
      ..setVolume(0.0);
    playVideo();
  }

  Future<String> fetchVideoUrl() async {
    final storage = FirebaseStorage.instance;
    final Reference ref =
        storage.ref().child('Video').child('new_animation.mp4');
    final url = await ref.getDownloadURL();
    return url;
  }

  void playVideo() async {
    controller.play();
    //When the Video playback reached the end you navigate to the Home page
    controller.addListener(() {
      if (controller.value.isPlaying == false &&
          controller.value.position == controller.value.duration) {
        widget.onIntializationComplete();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: isVideoInitialized
              ? AspectRatio(
                  aspectRatio: 4 / 3,
                  child: VideoPlayer(controller),
                )
              : Container(color: Colors.black)),
    );
  }
}
