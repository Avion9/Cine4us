//Utils
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//Api
import 'package:movie_app/Api/Api_Config.dart';
//Controllers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/movie_controller.dart';
//Pages
import 'package:movie_app/New_Pages/movie_detail.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';

class GridMoviesCard extends StatelessWidget {
  final HoverController hoverController;
  GridMoviesCard(
      {Key? key,
      required this.hoverController,
      required this.id,
      required this.title,
      required this.rating,
      required this.linkImage})
      : super(key: key);

  final int id;
  final String title;
  final double rating;
  final String linkImage;

  final movieController = Get.find<MovieController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        movieController.fetchDataDetailMovie(id);
        movieController.getCastList(id);
        movieController.getSimilarList(id);
        movieController.fetchTrailerUrl(id);
        Get.to(() => DetailMovie());
      },
      child: GridMovies(
        id: id,
        rating: rating,
        linkImage: linkImage,
        title: title,
        hoverController: hoverController,
      ),
    );
  }
}

class GridMovies extends StatelessWidget {
  final hoverC = Get.find<HoverController>();
  final HoverController hoverController;
  // Tracking Loading state
  final ValueNotifier<bool> imageLoadErrorNotifier = ValueNotifier<bool>(false);
  GridMovies(
      {Key? key,
      required this.hoverController,
      required this.id,
      required this.title,
      required this.rating,
      required this.linkImage})
      : super(key: key);

  final int id;
  final String title;
  final double rating;

  final String linkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onHover: (event) => hoverController.hoverOn(),
              onExit: (event) => hoverController.hoverOff(),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            height:
                                ResponsiveLayout.isDesktop(context) ? 280 : 255,
                            width:
                                ResponsiveLayout.isDesktop(context) ? 200 : 170,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: "${ApiConfig.baseImgUrl}$linkImage",
                                placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget: (context, url, error) {
                                  imageLoadErrorNotifier.value = true;
                                  return const SizedBox(
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 81.7),
                                        child: Icon(
                                            color: Colors.white,
                                            size: 50,
                                            Icons.image_not_supported_outlined),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        hoverController.isHovered.value &&
                                !imageLoadErrorNotifier.value
                            ? ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  height: ResponsiveLayout.isDesktop(context)
                                      ? 280
                                      : 255,
                                  width: ResponsiveLayout.isDesktop(context)
                                      ? 200
                                      : 170,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 2.0, sigmaY: 2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          color: const Color.fromRGBO(110, 190,
                                              196, 1), // Blue border color
                                          width: 2.0,
                                          // Border width
                                        ),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: const Icon(
                                          Icons.play_circle_outline_rounded,
                                          size: 60,
                                          shadows: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  110, 190, 196, 1),
                                              spreadRadius: 4,
                                              blurRadius: 2,
                                            ),
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  110, 190, 196, 1),
                                              spreadRadius: 4,
                                              blurRadius: 2,
                                            ),
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  110, 190, 196, 1),
                                              spreadRadius: 4,
                                              blurRadius: 2,
                                            ),
                                          ],
                                          color:
                                              Color.fromRGBO(110, 190, 196, 1)),
                                    ),
                                  ),
                                ),
                              )
                            : Positioned(
                                top: ResponsiveLayout.isDesktop(context)
                                    ? 230
                                    : 215,
                                left: ResponsiveLayout.isDesktop(context)
                                    ? 150
                                    : 130,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: ResponsiveLayout.isDesktop(context)
                                          ? 50
                                          : 40,
                                      height:
                                          ResponsiveLayout.isDesktop(context)
                                              ? 50
                                              : 40,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 37, 37, 37),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 37, 37, 37),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: CircularPercentIndicator(
                                        animation: true,
                                        animationDuration: 1000,
                                        curve: Curves.easeInOut,
                                        radius:
                                            ResponsiveLayout.isDesktop(context)
                                                ? 22
                                                : 18.0,
                                        lineWidth:
                                            ResponsiveLayout.isDesktop(context)
                                                ? 3
                                                : 2.0,
                                        percent: rating / 10,
                                        backgroundColor: const Color.fromARGB(
                                            255, 107, 107, 107),
                                        center: TweenAnimationBuilder<int>(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.easeInOut,
                                          tween: IntTween(
                                              begin: 0,
                                              end: (rating * 10).round()),
                                          builder: (BuildContext context,
                                              int value, Widget? child) {
                                            return RichText(
                                              text: TextSpan(
                                                text: '$value',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ResponsiveLayout
                                                          .isDesktop(context)
                                                      ? 15
                                                      : 13.0,
                                                  color: Colors.white,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '%',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: ResponsiveLayout
                                                              .isDesktop(
                                                                  context)
                                                          ? 11
                                                          : 9.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: (rating * 10) < 40
                                            ? Colors.red
                                            : (rating * 10) < 70
                                                ? Colors.yellow
                                                : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: SizedBox(
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                  color: hoverController.isHovered.value
                                      ? const Color.fromRGBO(110, 190, 196, 1)
                                      : Colors.white,
                                  fontSize: 14,
                                  height: 1.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
