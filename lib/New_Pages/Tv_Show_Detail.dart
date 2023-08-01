//Utils
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
//Api
import 'package:movie_app/Api/Api_Config.dart';
//Controllers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';
import 'package:movie_app/Controllers/Tv_Show_controller.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';
//Widgets
import 'package:movie_app/widgets/Background_movie_detail.dart';
import 'package:movie_app/widgets/Cast_card.dart';
import 'package:movie_app/widgets/Floating_Button.dart';
import 'package:movie_app/widgets/Vertical_Card.dart';
import 'package:movie_app/widgets/Video_player.dart';

class DetailShow extends StatefulWidget {
  @override
  State<DetailShow> createState() => _DetailShowState();
}

class _DetailShowState extends State<DetailShow> {
  static final customCacheManager = CacheManager(
    Config('customcacheKey',
        stalePeriod: const Duration(days: 2), maxNrOfCacheObjects: 100),
  );

  final showC = Get.find<ShowController>();
  final screenC = Get.find<ScreenController>();
  final hoverC = Get.find<HoverController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<ShowController>(
        builder: (controller) {
          return SafeArea(
            child: showC.isLoadingDetail.value
                ? const Stack(children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ])
                : Stack(
                    children: [
                      const BackgroundDetail(),
                      SafeArea(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: screenWidth,
                            child: Column(children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: screenWidth,
                                    height: screenWidth > 1200
                                        ? 500
                                        : screenWidth > 800
                                            ? 450
                                            : 350,
                                    child: ClipRRect(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          CachedNetworkImage(
                                            cacheManager: customCacheManager,
                                            key: UniqueKey(),
                                            imageUrl:
                                                "${ApiConfig.backDropImgUrl}${showC.showDetail?.backdropPath ?? ''}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: <Color>[
                                                  Colors.black.withAlpha(210),
                                                  Colors.transparent
                                                      .withAlpha(50),
                                                  Colors.black,
                                                  Colors.black,
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [0, 0.2, 1, 1.0],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Responsive Layout for The Page
                                  ResponsiveLayout.isMobile(context)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Stack(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: BreathingButton(
                                                  scaleA: 0.65,
                                                  scaleB: 0.75,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 100.0),
                                                child: SizedBox(
                                                  width: 160,
                                                  height: 290,
                                                  child: Stack(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            cacheManager:
                                                                customCacheManager,
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                "${ApiConfig.baseImgUrl}${showC.showDetail?.posterPath ?? ''}",
                                                            fit: BoxFit.contain,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 360,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 60,
                                                            width: 195,
                                                            child: MouseRegion(
                                                              onHover: (event) {
                                                                hoverC
                                                                    .hoverOn();
                                                              },
                                                              onExit: (event) {
                                                                hoverC
                                                                    .hoverOff();
                                                              },
                                                              child: InkWell(
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                splashColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                onTap: () {
                                                                  // Handle button press
                                                                  void
                                                                      launchYouTube() {
                                                                    var url = showC
                                                                        .showtrailerUrl
                                                                        .value
                                                                        .toString();
                                                                    html.window
                                                                        .open(
                                                                            url,
                                                                            'youtube');
                                                                  }

                                                                  if (ResponsiveLayout
                                                                          .isDesktop(
                                                                              context) ||
                                                                      ResponsiveLayout
                                                                          .isTablet(
                                                                              context)) {
                                                                    showVideoPlayer(
                                                                        context,
                                                                        showC
                                                                            .showtrailerUrl
                                                                            .value
                                                                            .toString());
                                                                  } else {
                                                                    launchYouTube();
                                                                  }
                                                                },
                                                                child: ResponsiveLayout.isMobile(
                                                                            context) ||
                                                                        ResponsiveLayout.isTablet(
                                                                            context)
                                                                    ? Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: const Color.fromRGBO(
                                                                              110,
                                                                              190,
                                                                              196,
                                                                              1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Color.fromARGB(255, 71, 217, 228),
                                                                              blurRadius: 20,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 3.0),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Padding(
                                                                                  padding: EdgeInsets.only(right: 2, bottom: 4),
                                                                                  child: Icon(
                                                                                    CupertinoIcons.play_circle,
                                                                                    size: 45,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                                DefaultTextStyle(
                                                                                  style: GoogleFonts.nunito(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 21),
                                                                                  child: const Text(
                                                                                    "Watch Trailer",
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Obx(
                                                                        () {
                                                                          return AnimatedContainer(
                                                                            duration:
                                                                                const Duration(milliseconds: 200),
                                                                            curve:
                                                                                Curves.fastOutSlowIn,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: const Color.fromRGBO(110, 190, 196, 1),
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              boxShadow: [
                                                                                if (hoverC.isHovered.value)
                                                                                  const BoxShadow(
                                                                                    color: Color.fromARGB(255, 71, 217, 228),
                                                                                    blurRadius: 30,
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  const Padding(
                                                                                    padding: EdgeInsets.only(right: 4, bottom: 2),
                                                                                    child: Icon(
                                                                                      CupertinoIcons.play_circle,
                                                                                      size: 45,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                  AnimatedDefaultTextStyle(
                                                                                    duration: const Duration(milliseconds: 200),
                                                                                    curve: Curves.fastOutSlowIn,
                                                                                    style: GoogleFonts.nunito(fontWeight: hoverC.isHovered.value ? FontWeight.w600 : FontWeight.w500, color: Colors.white, fontSize: hoverC.isHovered.value ? 21 : 18),
                                                                                    child: const Text(
                                                                                      "Watch Trailer",
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                child: Text(
                                                                  showC.showDetail
                                                                          ?.name ??
                                                                      "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: screenWidth >
                                                                              500
                                                                          ? 25
                                                                          : 20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          LayoutBuilder(
                                                            builder: (context,
                                                                constraints) {
                                                              const containerWidth =
                                                                  100.0;
                                                              const verticalSpacing =
                                                                  4.0;
                                                              final itemCount = (showC
                                                                          .showDetail
                                                                          ?.genres
                                                                          .length ??
                                                                      0)
                                                                  .clamp(0, 6);
                                                              return SizedBox(
                                                                height:
                                                                    screenWidth >
                                                                            600
                                                                        ? 40
                                                                        : 70,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Column(
                                                                    children: [
                                                                      Wrap(
                                                                        spacing:
                                                                            2,
                                                                        runSpacing:
                                                                            verticalSpacing,
                                                                        children:
                                                                            List.generate(
                                                                          itemCount,
                                                                          (index) {
                                                                            String?
                                                                                genre =
                                                                                showC.showDetail?.genres[index].name;
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(bottom: verticalSpacing),
                                                                              child: Container(
                                                                                height: ResponsiveLayout.isMobile(context) ? 25 : 35,
                                                                                width: containerWidth,
                                                                                margin: const EdgeInsets.only(right: 10),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                  border: Border.all(
                                                                                    // add a border to your container
                                                                                    color: Colors.white, // color of the border
                                                                                    width: 2, // width of the border
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    genre!,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: GoogleFonts.nunito(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            3),
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          158,
                                                                          158,
                                                                          158,
                                                                          1),
                                                                      size: screenWidth >
                                                                              600
                                                                          ? 40
                                                                          : 30,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    showC.showDetail
                                                                            ?.voteAverage
                                                                            .toStringAsFixed(1) ??
                                                                        '',
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: screenWidth >
                                                                              600
                                                                          ? 18
                                                                          : 16,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .tv_rounded,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            158,
                                                                            158,
                                                                            1),
                                                                    size: 30,
                                                                  ),
                                                                  Text(
                                                                    ' ${showC.showDetail?.episodeCount} Episodes',
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .calendar_month_outlined,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            158,
                                                                            158,
                                                                            1),
                                                                    size: 30,
                                                                  ),
                                                                  Text(
                                                                    ' ${showC.showDetail?.releaseDate.day.toString().padLeft(2, '0')}-${showC.showDetail?.releaseDate.month.toString().padLeft(2, '0')}-${showC.showDetail?.releaseDate.year.toString().padLeft(4, '0')}',
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              screenWidth > 500
                                                                  ? Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .new_releases_outlined,
                                                                          color: const Color.fromRGBO(
                                                                              158,
                                                                              158,
                                                                              158,
                                                                              1),
                                                                          size: screenWidth > 600
                                                                              ? 40
                                                                              : 30,
                                                                        ),
                                                                        Text(
                                                                          ' ${showC.showDetail?.status}',
                                                                          style:
                                                                              GoogleFonts.nunito(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: screenWidth > 600
                                                                                ? 18
                                                                                : 16,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "Overview",
                                                              style: GoogleFonts.nunito(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                          Text(
                                                            showC.showDetail
                                                                    ?.overview ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 10,
                                                            style: GoogleFonts
                                                                .nunito(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  158,
                                                                  158,
                                                                  158),
                                                              fontSize:
                                                                  screenWidth >
                                                                          600
                                                                      ? 18
                                                                      : 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ) //---------------------------------------Other Layouts------------------------------------------
                                      : Stack(
                                          children: [
                                            ResponsiveLayout.isTablet(context)
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5, left: 15),
                                                    child: BreathingButton(
                                                        scaleA: 0.85,
                                                        scaleB: 0.95),
                                                  )
                                                : const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5, left: 22),
                                                    child: BreathingButton(
                                                        scaleA: 0.95,
                                                        scaleB: 1.05),
                                                  ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: screenWidth > 1200
                                                          ? 230
                                                          : 200,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: SizedBox(
                                                        width:
                                                            screenWidth > 1200
                                                                ? 290
                                                                : 270,
                                                        height:
                                                            screenWidth > 1200
                                                                ? 436
                                                                : 406,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child:
                                                              CachedNetworkImage(
                                                            cacheManager:
                                                                customCacheManager,
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                "${ApiConfig.baseImgUrl}${showC.showDetail?.posterPath ?? ''}",
                                                            fit: BoxFit.contain,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 60,
                                                      width: 195,
                                                      child: MouseRegion(
                                                        onHover: (event) {
                                                          hoverC.hoverOn();
                                                        },
                                                        onExit: (event) {
                                                          hoverC.hoverOff();
                                                        },
                                                        child: InkWell(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          splashColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          onTap: () {
                                                            void
                                                                launchYouTube() {
                                                              var url = showC
                                                                  .showtrailerUrl
                                                                  .value
                                                                  .toString();
                                                              html.window.open(
                                                                  url,
                                                                  'youtube');
                                                            }

                                                            if (ResponsiveLayout
                                                                    .isDesktop(
                                                                        context) ||
                                                                ResponsiveLayout
                                                                    .isTablet(
                                                                        context)) {
                                                              showVideoPlayer(
                                                                  context,
                                                                  showC
                                                                      .showtrailerUrl
                                                                      .value
                                                                      .toString());
                                                            } else {
                                                              launchYouTube();
                                                            }
                                                          },
                                                          child: ResponsiveLayout
                                                                      .isMobile(
                                                                          context) ||
                                                                  ResponsiveLayout
                                                                      .isTablet(
                                                                          context)
                                                              ? Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        110,
                                                                        190,
                                                                        196,
                                                                        1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            71,
                                                                            217,
                                                                            228),
                                                                        blurRadius:
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 2, bottom: 4),
                                                                            child:
                                                                                Icon(
                                                                              CupertinoIcons.play_circle,
                                                                              size: 45,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          DefaultTextStyle(
                                                                            style: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.white,
                                                                                fontSize: 21),
                                                                            child:
                                                                                const Text(
                                                                              "Watch Trailer",
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Obx(
                                                                  () {
                                                                    return AnimatedContainer(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              200),
                                                                      curve: Curves
                                                                          .fastOutSlowIn,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color.fromRGBO(
                                                                            110,
                                                                            190,
                                                                            196,
                                                                            1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        boxShadow: [
                                                                          if (hoverC
                                                                              .isHovered
                                                                              .value)
                                                                            const BoxShadow(
                                                                              color: Color.fromARGB(255, 71, 217, 228),
                                                                              blurRadius: 30,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.only(right: 4, bottom: 2),
                                                                              child: Icon(
                                                                                CupertinoIcons.play_circle,
                                                                                size: 45,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            AnimatedDefaultTextStyle(
                                                                              duration: const Duration(milliseconds: 200),
                                                                              curve: Curves.fastOutSlowIn,
                                                                              style: GoogleFonts.nunito(fontWeight: hoverC.isHovered.value ? FontWeight.w600 : FontWeight.w500, color: Colors.white, fontSize: hoverC.isHovered.value ? 21 : 18),
                                                                              child: const Text(
                                                                                "Watch Trailer",
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 300,
                                                      ),
                                                      Center(
                                                        child: SizedBox(
                                                          width: ResponsiveLayout
                                                                  .isDesktop(
                                                                      context)
                                                              ? screenWidth *
                                                                  0.5
                                                              : ResponsiveLayout
                                                                      .isTablet(
                                                                          context)
                                                                  ? screenWidth *
                                                                      0.625
                                                                  : 400,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.4,
                                                                    child: Text(
                                                                      showC.showDetail
                                                                              ?.name ??
                                                                          "",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors.white,
                                                                          fontSize: ResponsiveLayout.isDesktop(context)
                                                                              ? 60
                                                                              : ResponsiveLayout.isTablet(context)
                                                                                  ? 50
                                                                                  : 40,
                                                                          fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              LayoutBuilder(
                                                                builder: (context,
                                                                    constraints) {
                                                                  const containerWidth =
                                                                      100.0;
                                                                  const verticalSpacing =
                                                                      4.0;
                                                                  final itemCount =
                                                                      (showC.showDetail?.genres.length ??
                                                                              0)
                                                                          .clamp(
                                                                              0,
                                                                              6);

                                                                  return SizedBox(
                                                                    height: 70,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Wrap(
                                                                            spacing:
                                                                                2,
                                                                            runSpacing:
                                                                                verticalSpacing,
                                                                            children:
                                                                                List.generate(
                                                                              itemCount,
                                                                              (index) {
                                                                                String? genre = showC.showDetail?.genres[index].name;
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.only(bottom: verticalSpacing),
                                                                                  child: Container(
                                                                                    height: ResponsiveLayout.isMobile(context) ? 25 : 35,
                                                                                    width: containerWidth,
                                                                                    margin: const EdgeInsets.only(right: 10),
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                      border: Border.all(
                                                                                        color: Colors.white,
                                                                                        width: 2,
                                                                                      ),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        genre!,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: GoogleFonts.nunito(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 14,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 3),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: const Color.fromRGBO(
                                                                              158,
                                                                              158,
                                                                              158,
                                                                              1),
                                                                          size: screenWidth > 600
                                                                              ? 40
                                                                              : 30,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        showC.showDetail?.voteAverage.toStringAsFixed(1) ??
                                                                            '',
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: screenWidth > 600
                                                                              ? 18
                                                                              : 16,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .tv_rounded,
                                                                        color: const Color.fromRGBO(
                                                                            158,
                                                                            158,
                                                                            158,
                                                                            1),
                                                                        size: screenWidth >
                                                                                600
                                                                            ? 40
                                                                            : 30,
                                                                      ),
                                                                      Text(
                                                                        ' ${showC.showDetail?.episodeCount} Episodes',
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: screenWidth > 600
                                                                              ? 18
                                                                              : 16,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .calendar_month_outlined,
                                                                        color: const Color.fromRGBO(
                                                                            158,
                                                                            158,
                                                                            158,
                                                                            1),
                                                                        size: screenWidth >
                                                                                600
                                                                            ? 40
                                                                            : 30,
                                                                      ),
                                                                      Text(
                                                                        ' ${showC.showDetail?.releaseDate.day.toString().padLeft(2, '0')}-${showC.showDetail?.releaseDate.month.toString().padLeft(2, '0')}-${showC.showDetail?.releaseDate.year.toString().padLeft(4, '0')}',
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: screenWidth > 600
                                                                              ? 18
                                                                              : 16,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .new_releases_outlined,
                                                                        color: const Color.fromRGBO(
                                                                            158,
                                                                            158,
                                                                            158,
                                                                            1),
                                                                        size: screenWidth >
                                                                                600
                                                                            ? 40
                                                                            : 30,
                                                                      ),
                                                                      Text(
                                                                        ' ${showC.showDetail?.status}',
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: screenWidth > 600
                                                                              ? 18
                                                                              : 16,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "Overview",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
                                                              ),
                                                              Text(
                                                                showC.showDetail
                                                                        ?.overview ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 10,
                                                                style: GoogleFonts.nunito(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        158,
                                                                        158,
                                                                        158),
                                                                    fontSize: screenWidth <
                                                                            1200
                                                                        ? 18
                                                                        : 22),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: screenWidth * 0.95,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Cast',
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 270,
                                      color: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                      child: showC.showCast.isEmpty
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  showC.showCast.length <= 10
                                                      ? showC.showCast.length
                                                      : 10,
                                              itemBuilder: (context, index) {
                                                return CastCard(
                                                  imgUrl: ApiConfig.baseImgUrl +
                                                      showC.showCast[index]
                                                          .profilePath
                                                          .toString(),
                                                  castName: showC
                                                      .showCast[index].name
                                                      .toString(),
                                                  character: showC
                                                      .showCast[index].character
                                                      .toString(),
                                                );
                                              }),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Similar Shows',
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          ResponsiveLayout.isDesktop(context)
                                              ? 320
                                              : 300,
                                      child: showC.similarshows.isEmpty
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  showC.similarshows.length,
                                              itemBuilder: (context, index) {
                                                return ShowCard(
                                                  title: showC
                                                      .similarshows[index].title
                                                      .toString(),
                                                  rating: showC
                                                      .similarshows[index]
                                                      .voteAverage!,
                                                  linkImage: showC
                                                      .similarshows[index]
                                                      .posterPath
                                                      .toString(),
                                                  id: showC.similarshows[index]
                                                          .id ??
                                                      0,
                                                  hoverController:
                                                      HoverController(),
                                                );
                                              }),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
