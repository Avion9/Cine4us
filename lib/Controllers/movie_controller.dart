import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//API
import 'package:movie_app/Api/Api_Client.dart';
import 'package:movie_app/Api/Api_Config.dart';
//Models
import 'package:movie_app/Models/Cast_model.dart';
import 'package:movie_app/Models/movie_detail_model.dart';
import '../Models/Movie_Model.dart';

class MovieController extends GetxController {
  ApiClient apiClient = ApiClient();
  MovieDetail? movieDetail;
//Movie Lists
  List<MovieModel> trendingMovies = <MovieModel>[].obs;
  List<MovieModel> topratedMovies = <MovieModel>[].obs;
  List<MovieModel> popularMovies = <MovieModel>[].obs;
  List<MovieModel> searchedMovies = <MovieModel>[].obs;
  List<MovieModel> similarMovies = <MovieModel>[].obs;
  List<CastModel> movieCast = <CastModel>[].obs;

  RxString trailerUrl = ''.obs;

  var isLoadingtrending = false.obs;
  var isLoadingPopular = false.obs;
  var isLoadingTop = false.obs;
  var isLoadingDetail = false.obs;

//Search function
  void getMovieSearch(String movieTitle) async {
    var search = await apiClient.getSearchedMovies(movieTitle);
    if (search.isNotEmpty) {
      searchedMovies = search;
    }

    update();
  }

//Fetch Trending Movies
  void getTrending() async {
    var trend = await apiClient.getTrendingMovies();
    if (trend.isNotEmpty) {
      trendingMovies = trend;
    }
    update();
  }

//Fetch TopRated Movies
  void getToprated() async {
    var toprated = await apiClient.getTopratedMovies();
    if (toprated.isNotEmpty) {
      topratedMovies = toprated;
    }
    update();
  }

//Fetch Popular Movies
  void getPopular() async {
    var popular = await apiClient.getPopularMovies();
    if (popular.isNotEmpty) {
      popularMovies = popular;
    }
    update();
  }

  //This method gets the details of the movies using the Id Parameter
  void fetchDataDetailMovie(int id) async {
    try {
      isLoadingDetail(true);
      http.Response response = await http.get(
          Uri.tryParse('${ApiConfig.baseUrl}/movie/$id?${ApiConfig.apiKey}')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        movieDetail = MovieDetail.fromJson(result);
      } else {
        print("Error Fetching Data");
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoadingDetail(false);
    }
  }

//Fetching  The selected Movie  Trailer Url
  void fetchTrailerUrl(int id) async {
    var url = await apiClient.getMovieTrailer(id);
    if (url.isNotEmpty) {
      trailerUrl = url;
    }
    update();
  }

//Fetching the Cast List for a selected Movie
  void getCastList(int id) async {
    var cast = await apiClient.getMovieCast(id);
    if (cast.isNotEmpty) {
      movieCast = cast;
    }

    update();
  }

//Fetching Similar Movies for a selected Movie
  void getSimilarList(int id) async {
    var similar = await apiClient.getSimilarMovies(id);
    if (similar.isNotEmpty) {
      similarMovies = similar;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getTrending();
    getToprated();
    getPopular();
  }
}
