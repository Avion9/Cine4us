import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
//Api
import 'package:movie_app/Api/Api_Client.dart';
//Controllers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';
import 'package:movie_app/Controllers/movie_controller.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';
//Widgets
import 'package:movie_app/widgets/Grid_Movie_Card.dart';
//Models
import '../Models/Movie_Model.dart';

class AllMovies extends StatefulWidget {
  const AllMovies({super.key});
  @override
  State<AllMovies> createState() => _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMovies> {
  ScrollController scrollController = ScrollController();

  ApiClient apiClient = ApiClient();

  final movieC = Get.find<MovieController>();
  final screenM = Get.put(ScreenController());

  bool statusSearch = false;
  FocusNode focusNode = FocusNode();
  var isLoading = false.obs;
  int currentPage = 0;
  List<MovieModel> moviesList = [];
  late String query = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
//Status for Search Bar !
  void focusNodeListener() {
    setState(() {
      statusSearch = !statusSearch;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
    focusNode.addListener(focusNodeListener);
  }

  @override
  void dispose() {
    focusNode.removeListener(focusNodeListener);
    focusNode.dispose();
    super.dispose();
  }

// Fetching more Movies while scrolling this function get called only when you scroll
  Future<void> _loadMovies() async {
    try {
      isLoading(true);
      int nextPage = currentPage + 1; // Increment the page number
      var newMovies = await apiClient.getNowPlayingMovies(nextPage);
      // Set the new page number in the state
      setState(() {
        currentPage = nextPage;
        moviesList.addAll(newMovies);
      });
    } catch (e) {
      e.printError();
    } finally {
      isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                    height: screenWidth > 1200 ? 0 : 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: ResponsiveLayout.isMobile(context)
                          ? 300
                          : ResponsiveLayout.isTablet(context)
                              ? 400
                              : 500,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: GradientBoxBorder(
                            width: 1.5,
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(110, 190, 196, 1),
                              Color.fromRGBO(93, 158, 166, 1),
                            ])),
                      ),
                      child: TextFormField(
                        controller: textEditingController,
                        key: formKey,
                        onChanged: (value) {
                          query = value;
                          if (value.isNotEmpty) {
                            movieC.getMovieSearch(query);
                          } else {
                            movieC.searchedMovies = [];
                            setState(() {});
                          }
                        },
                        autofocus: movieC.searchedMovies.isEmpty ? true : false,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 15),
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Search...",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: statusSearch
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        movieC.searchedMovies = [];
                                        query = '';
                                        textEditingController.text = '';
                                      });
                                    },
                                    splashRadius: 25,
                                    splashColor:
                                        const Color.fromRGBO(110, 190, 196, 1),
                                    icon: const Icon(Icons.close_rounded),
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GetBuilder<MovieController>(builder: (controller) {
                      return movieC.searchedMovies.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveLayout.isMobile(
                                              context)
                                          ? 10
                                          : ResponsiveLayout.isTablet(context)
                                              ? 15
                                              : ResponsiveLayout.isDesktop(
                                                      context)
                                                  ? 80
                                                  : 80),
                                  child: const Text(
                                    "All Movies ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 768,
                                  width: screenWidth,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ResponsiveLayout.isMobile(
                                                context)
                                            ? 10
                                            : ResponsiveLayout.isTablet(context)
                                                ? 15
                                                : ResponsiveLayout.isDesktop(
                                                        context)
                                                    ? 80
                                                    : 80),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 768,
                                              child: isLoading.value
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : NotificationListener<
                                                      ScrollNotification>(
                                                      onNotification:
                                                          (scrollNotification) {
                                                        if (scrollNotification
                                                            is ScrollEndNotification) {
                                                          final before =
                                                              scrollNotification
                                                                  .metrics
                                                                  .extentBefore;
                                                          final max =
                                                              scrollNotification
                                                                  .metrics
                                                                  .maxScrollExtent;
                                                          if (before == max) {
                                                            _loadMovies();
                                                            return true;
                                                          }
                                                          return false;
                                                        }
                                                        return false;
                                                      },
                                                      child: GridView.builder(
                                                        controller:
                                                            scrollController,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: screenWidth <
                                                                  600
                                                              ? 2
                                                              : screenWidth <
                                                                      816
                                                                  ? 3
                                                                  : screenWidth <
                                                                          1018
                                                                      ? 4
                                                                      : screenWidth <
                                                                              1400
                                                                          ? 5
                                                                          : screenWidth < 1600
                                                                              ? 6
                                                                              : 7,
                                                          childAspectRatio: 1.7 /
                                                              2.75, // Adjust aspect ratio based on  movie card design
                                                          mainAxisSpacing: 1.0,
                                                          crossAxisSpacing: 1.0,
                                                        ),
                                                        itemCount:
                                                            moviesList.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GridMoviesCard(
                                                            title: moviesList[
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            rating: moviesList[
                                                                    index]
                                                                .voteAverage!,
                                                            linkImage:
                                                                moviesList[
                                                                        index]
                                                                    .posterPath
                                                                    .toString(),
                                                            id: moviesList[
                                                                        index]
                                                                    .id ??
                                                                0,
                                                            hoverController:
                                                                HoverController(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        ResponsiveLayout.isMobile(context)
                                            ? 10
                                            : ResponsiveLayout.isTablet(context)
                                                ? 15
                                                : ResponsiveLayout.isDesktop(
                                                        context)
                                                    ? 80
                                                    : 80),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Top Search Results",
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
                                          height: screenHeight,
                                          child: GridView.builder(
                                            controller: scrollController,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: screenWidth < 600
                                                  ? 2
                                                  : screenWidth < 816
                                                      ? 3
                                                      : screenWidth < 1018
                                                          ? 4
                                                          : screenWidth < 1400
                                                              ? 5
                                                              : screenWidth <
                                                                      1600
                                                                  ? 6
                                                                  : 7,
                                              childAspectRatio: 1.7 /
                                                  2.75, // Adjust aspect ratio based on  movie card design
                                              mainAxisSpacing: 1.0,
                                              crossAxisSpacing: 1.0,
                                            ),
                                            itemCount:
                                                movieC.searchedMovies.length,
                                            itemBuilder: (context, index) {
                                              return GridMoviesCard(
                                                title: movieC
                                                    .searchedMovies[index].title
                                                    .toString(),
                                                rating: movieC
                                                    .searchedMovies[index]
                                                    .voteAverage!,
                                                linkImage: movieC
                                                    .searchedMovies[index]
                                                    .posterPath
                                                    .toString(),
                                                id: movieC.searchedMovies[index]
                                                        .id ??
                                                    0,
                                                hoverController:
                                                    HoverController(),
                                              );
                                            },
                                          ),
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
