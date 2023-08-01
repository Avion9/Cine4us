import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Api/Api_Config.dart';
import 'package:movie_app/Models/Cast_model.dart';
import 'package:movie_app/Models/Movie_Model.dart';
import 'package:movie_app/Models/Tv_Shows_Model.dart';

//Diese Klasse besteht aus verschiedenen Methoden, um verschiedene Arten von Daten zu erhalten.

class ApiClient extends GetxController {
  Future<List<MovieModel>> getTrendingMovies() async {
    String uri = '${ApiConfig.baseUrl}/trending/movie/day?${ApiConfig.apiKey}';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getTopratedMovies() async {
    String uri =
        '${ApiConfig.baseUrl}/movie/top_rated?${ApiConfig.apiKey}&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies(int? page) async {
    String uri =
        '${ApiConfig.baseUrl}/movie/now_playing?${ApiConfig.apiKey}&include_adult=false&language=en-US&page=$page';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getPopularMovies() async {
    String uri =
        '${ApiConfig.baseUrl}/movie/popular?${ApiConfig.apiKey}&language=en-US&page=1';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    String uri =
        '${ApiConfig.baseUrl}/movie/upcoming?${ApiConfig.apiKey}&language=en-US&page=1';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    String uri =
        '${ApiConfig.baseUrl}/movie/$movieId/recommendations?${ApiConfig.apiKey}&include_adult=false&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];
      // print(result);

      List<MovieModel> movies = [];
      for (var movie in result) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CastModel>> getMovieCast(int movieId) async {
    String uri =
        '${ApiConfig.baseUrl}/movie/$movieId/credits?${ApiConfig.apiKey}&language=en-US';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['cast'];

      List<CastModel> movieCast = [];
      for (var cast in result) {
        movieCast.add(CastModel.fromJson(cast));
      }
      return movieCast;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getSearchedMovies(String? movieName) async {
    String uri =
        '${ApiConfig.baseUrl}/search/movie?${ApiConfig.apiKey}&query=$movieName&include_adult=false&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));

      final data = json.decode(response.body);
      var results = data['results'];

      List<MovieModel> searchMovie = [];

      for (var movie in results) {
        searchMovie.add(MovieModel.fromJson(movie));
      }

      return searchMovie;
    } catch (e) {
      print("Error Fetching Data !");
      rethrow;
    }
  }

  Future<RxString> getMovieTrailer(int movieId) async {
    var key;
    RxString trailerUrl;
    String uri =
        '${ApiConfig.baseUrl}/movie/$movieId/videos?${ApiConfig.apiKey}';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var results = data['results'];
      if (results.length > 0) {
        for (var result in results) {
          var type = result['type'];
          if (type == 'Trailer') {
            key = result['key'];
            break;
          }
        }
      }
      trailerUrl = 'https://www.youtube.com/watch?v=$key'.obs;
      return trailerUrl;
    } catch (e) {
      rethrow;
    }
  }

  ////////////---TV SHOWS Functions---////////////////////////

  Future<List<TvModel>> getAiringTvShows() async {
    String uri =
        '${ApiConfig.baseUrl}/trending/tv/week?${ApiConfig.apiKey}&include_adult=false&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<TvModel> shows = [];
      for (var show in result) {
        shows.add(TvModel.fromJson(show));
      }

      return shows;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvModel>> getTopRatedTvShows() async {
    String uri =
        '${ApiConfig.baseUrl}/tv/top_rated?${ApiConfig.apiKey}&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<TvModel> shows = [];
      for (var show in result) {
        shows.add(TvModel.fromJson(show));
      }

      return shows;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvModel>> getPopularTvShows() async {
    String uri =
        '${ApiConfig.baseUrl}/discover/tv?${ApiConfig.apiKey}&include_adult=false&language=en-US&page=1&sort_by=vote_count.desc';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];

      List<TvModel> shows = [];
      for (var show in result) {
        shows.add(TvModel.fromJson(show));
      }

      return shows;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CastModel>> getShowCast(int showId) async {
    String uri =
        '${ApiConfig.baseUrl}/tv/$showId/credits?${ApiConfig.apiKey}&language=en-US';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['cast'];

      List<CastModel> showCast = [];
      for (var cast in result) {
        showCast.add(CastModel.fromJson(cast));
      }
      return showCast;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvModel>> getSimilarShows(int showId) async {
    String uri =
        '${ApiConfig.baseUrl}/tv/$showId/recommendations?${ApiConfig.apiKey}&include_adult=false&language=en-US&page=1';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var result = data['results'];
      // print(result);

      List<TvModel> shows = [];
      for (var show in result) {
        shows.add(TvModel.fromJson(show));
      }
      return shows;
    } catch (e) {
      rethrow;
    }
  }

  Future<RxString> getShowTrailer(int showId) async {
    var key;
    RxString trailerUrl;
    String uri = '${ApiConfig.baseUrl}/tv/$showId/videos?${ApiConfig.apiKey}';
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = json.decode(response.body);
      var results = data['results'];
      if (results.length > 0) {
        for (var result in results) {
          var type = result['type'];
          if (type == 'Trailer') {
            key = result['key'];
            break;
          }
        }
      }
      trailerUrl = 'https://www.youtube.com/watch?v=$key'.obs;

      return trailerUrl;
    } catch (e) {
      rethrow;
    }
  }
}
