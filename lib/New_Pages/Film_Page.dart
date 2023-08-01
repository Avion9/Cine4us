import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Controllers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';
import 'package:movie_app/Controllers/movie_controller.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';
//Widgets
import 'package:movie_app/widgets/Vertical_Card.dart';

class FilmPage extends StatefulWidget {
  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  final movieC = Get.find<MovieController>();
  final screenM = Get.put(ScreenController());

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
                      return ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Trending Movies",
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
                                child: movieC.trendingMovies.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movieC.trendingMovies.length,
                                        itemBuilder: (context, index) {
                                          return MovieCard(
                                            title: movieC
                                                .trendingMovies[index].title
                                                .toString(),
                                            rating: movieC.trendingMovies[index]
                                                .voteAverage!,
                                            linkImage: movieC
                                                .trendingMovies[index]
                                                .posterPath
                                                .toString(),
                                            id: movieC
                                                    .trendingMovies[index].id ??
                                                0,
                                            hoverController: HoverController(),
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
                                "Top Rated Movies",
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
                                child: movieC.isLoadingTop.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movieC.topratedMovies.length,
                                        itemBuilder: (context, index) {
                                          return MovieCard(
                                            title: movieC
                                                .topratedMovies[index].title
                                                .toString(),
                                            rating: movieC.topratedMovies[index]
                                                .voteAverage!,
                                            linkImage: movieC
                                                .topratedMovies[index]
                                                .posterPath
                                                .toString(),
                                            id: movieC
                                                    .topratedMovies[index].id ??
                                                0,
                                            hoverController: HoverController(),
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
                                "Popular Movies",
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
                                child: movieC.isLoadingPopular.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movieC.popularMovies.length,
                                        itemBuilder: (context, index) {
                                          return MovieCard(
                                            title: movieC
                                                .popularMovies[index].title
                                                .toString(),
                                            rating: movieC.popularMovies[index]
                                                .voteAverage!,
                                            linkImage: movieC
                                                .popularMovies[index].posterPath
                                                .toString(),
                                            id: movieC
                                                    .popularMovies[index].id ??
                                                0,
                                            hoverController: HoverController(),
                                          );
                                        }),
                              ),
                            ],
                          ),
                        ],
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
