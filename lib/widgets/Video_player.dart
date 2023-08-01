//Utils
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';

void showVideoPlayer(BuildContext context, String videoUrl) {
  String? videoId = YoutubePlayerController.convertUrlToId(videoUrl);

  videoId!.isNotEmpty
      ? showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ResponsiveLayout.isDesktop(context)
                ? InkWell(
                    mouseCursor: MouseCursor.uncontrolled,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      // Close the Video Player
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Center(
                            child: SizedBox(
                              height: 600,
                              width: 1000,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Colors.black,
                                  child: YoutubePlayer(
                                    controller:
                                        YoutubePlayerController.fromVideoId(
                                      videoId: videoId,
                                      autoPlay: false,
                                      params: const YoutubePlayerParams(
                                        showControls: true,
                                        showFullscreenButton: true,
                                        color: 'red',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ResponsiveLayout.isTablet(context)
                    ? InkWell(
                        mouseCursor: MouseCursor.uncontrolled,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          // Close the Video Player
                          Navigator.pop(context);
                        },
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Center(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      color: Colors.black,
                                      child: YoutubePlayer(
                                        controller:
                                            YoutubePlayerController.fromVideoId(
                                          videoId: videoId,
                                          autoPlay: false,
                                          params: const YoutubePlayerParams(
                                            showControls: true,
                                            showFullscreenButton: true,
                                            color: 'red',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        mouseCursor: MouseCursor.uncontrolled,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          // back to Detail Page
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: SizedBox(
                            width: 400,
                            height: 100,
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  shadows: [
                                    const Shadow(
                                      blurRadius: 7.0,
                                      color: Color.fromRGBO(104, 109, 109, 1),
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FlickerAnimatedText(
                                      '',
                                      speed: const Duration(microseconds: 1),
                                    ),
                                    FlickerAnimatedText('Click to Go Back !'),
                                  ],
                                  onTap: () {
                                    //Add Tap Event if Needed!
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
          },
        )
      : null;
}
