import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));
String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  double popularity;
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  DateTime releaseDate;
  OriginalLanguage originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;

  MovieModel({
    this.popularity,
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
      popularity: json["popularity"].toDouble(),
      id: json["id"],
      video: json["video"],
      voteCount: json["vote_count"],
      voteAverage: json["vote_average"].toDouble(),
      title: json["title"],
      releaseDate: DateTime.parse(json["release_date"]),
      originalLanguage: originalLanguageValues.map[json["original_language"]],
      originalTitle: json["original_title"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
  backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
  adult: json["adult"],
  overview: json["overview"],
  posterPath: json["poster_path"],
  );

  Map<String, dynamic> toJson() => {
    "popularity": popularity,
    "id": id,
    "video": video,
    "vote_count": voteCount,
    "vote_average": voteAverage,
    "title": title,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "adult": adult,
    "overview": overview,
    "poster_path": posterPath,
  };
}

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
