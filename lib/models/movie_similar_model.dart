import 'dart:convert';

MovieSimilarModel movieSimilarModelFromJson(String str) => MovieSimilarModel.fromJson(json.decode(str));

String movieSimilarModelToJson(MovieSimilarModel data) => json.encode(data.toJson());

class MovieSimilarModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieSimilarModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieSimilarModel.fromJson(Map<String, dynamic> json) => MovieSimilarModel(
      page: json["page"],
      results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  totalPages: json["total_pages"],
  totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  double popularity;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.popularity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
  id: json["id"],
  originalLanguage: originalLanguageValues.map[json["original_language"]],
  originalTitle: json["original_title"],
  overview: json["overview"],
  posterPath: json["poster_path"],
  releaseDate: DateTime.parse(json["release_date"]),
  title: json["title"],
  video: json["video"],
  voteAverage: json["vote_average"].toDouble(),
  voteCount: json["vote_count"],
  popularity: json["popularity"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "popularity": popularity,
  };
}

enum OriginalLanguage { EN, NO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "no": OriginalLanguage.NO
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
