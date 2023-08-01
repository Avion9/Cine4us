//Util
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Conrollers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/Tv_Show_controller.dart';
import 'package:movie_app/Controllers/movie_controller.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';
//Widgets
import 'package:movie_app/widgets/Vertical_Card.dart';

class ShowPage extends StatefulWidget {
  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final showC = Get.find<ShowController>();

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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenWidth > 1200 ? 0 : 60,
                  ),
                  Expanded(
                    child: GetBuilder<MovieController>(builder: (controller) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "On The Air",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: ResponsiveLayout.isDesktop(context)
                                        ? 320
                                        : 300,
                                    child: showC.airingShows.isEmpty
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: showC.airingShows.length,
                                            itemBuilder: (context, index) {
                                              return ShowCard(
                                                title: showC
                                                    .airingShows[index].title
                                                    .toString(),
                                                rating: showC.airingShows[index]
                                                    .voteAverage!,
                                                linkImage: showC
                                                    .airingShows[index]
                                                    .posterPath
                                                    .toString(),
                                                id: showC.airingShows[index]
                                                        .id ??
                                                    0,
                                                hoverController:
                                                    HoverController(),
                                              );
                                            }),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Top Rated Shows",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: ResponsiveLayout.isDesktop(context)
                                        ? 320
                                        : 300,
                                    child: showC.topratedShows.isEmpty
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                showC.topratedShows.length,
                                            itemBuilder: (context, index) {
                                              return ShowCard(
                                                title: showC
                                                    .topratedShows[index].title
                                                    .toString(),
                                                rating: showC
                                                    .topratedShows[index]
                                                    .voteAverage!,
                                                linkImage: showC
                                                    .topratedShows[index]
                                                    .posterPath
                                                    .toString(),
                                                id: showC.topratedShows[index]
                                                        .id ??
                                                    0,
                                                hoverController:
                                                    HoverController(),
                                              );
                                            }),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Popular Shows",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: ResponsiveLayout.isDesktop(context)
                                        ? 320
                                        : 300,
                                    child: showC.popularShows.isEmpty
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                showC.popularShows.length,
                                            itemBuilder: (context, index) {
                                              return ShowCard(
                                                title: showC
                                                    .popularShows[index].title
                                                    .toString(),
                                                rating: showC
                                                    .popularShows[index]
                                                    .voteAverage!,
                                                linkImage: showC
                                                    .popularShows[index]
                                                    .posterPath
                                                    .toString(),
                                                id: showC.popularShows[index]
                                                        .id ??
                                                    0,
                                                hoverController:
                                                    HoverController(),
                                              );
                                            }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
