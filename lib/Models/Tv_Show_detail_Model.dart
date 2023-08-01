import 'dart:convert';

ShowDetail showDetailFromJson(String str) =>
    ShowDetail.fromJson(json.decode(str));

String showDetailToJson(ShowDetail data) => json.encode(data.toJson());

class ShowDetail {
  ShowDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalname,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.episodeCount,
    required this.seasonCount,
    required this.lastAirDate,
  });

  bool adult;
  String backdropPath;
  List<Genre> genres;
  String homepage;
  int id;
  DateTime releaseDate;
  DateTime lastAirDate;
  String originalLanguage;
  String originalname;
  String overview;
  double popularity;
  String posterPath;
  int episodeCount;
  int seasonCount;
  String status;
  String tagline;
  String name;
  double voteAverage;
  int voteCount;

  factory ShowDetail.fromJson(Map<String, dynamic> json) => ShowDetail(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        episodeCount: json["number_of_episodes"],
        seasonCount: json["number_of_seasons"],
        originalLanguage: json["original_language"],
        originalname: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["first_air_date"]),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "number_of_episodes": episodeCount,
        "number_of_seasons": seasonCount,
        "original_language": originalLanguage,
        "original_name": originalname,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": releaseDate,
        "last_air_date": lastAirDate,
        "status": status,
        "tagline": tagline,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
