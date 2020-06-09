import 'dart:convert';

MovieImageModel movieImageModelFromJson(String str) => MovieImageModel.fromJson(json.decode(str));

String movieImageModelToJson(MovieImageModel data) => json.encode(data.toJson());

class MovieImageModel {
  int id;
  List<Backdrop> backdrops;
  List<dynamic> posters;

  MovieImageModel({
    this.id,
    this.backdrops,
    this.posters,
  });

  factory MovieImageModel.fromJson(Map<String, dynamic> json) => MovieImageModel(
    id: json["id"],
    backdrops: List<Backdrop>.from(json["backdrops"].map((x) => Backdrop.fromJson(x))),
    posters: List<dynamic>.from(json["posters"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
    "posters": List<dynamic>.from(posters.map((x) => x)),
  };
}

class Backdrop {
  dynamic aspectRatio;
  String filePath;
  int height;
  dynamic iso6391;
  dynamic voteAverage;
  dynamic voteCount;
  int width;

  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
    aspectRatio: json["aspect_ratio"].toDouble(),
    filePath: json["file_path"],
    height: json["height"],
    iso6391: json["iso_639_1"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "aspect_ratio": aspectRatio,
    "file_path": filePath,
    "height": height,
    "iso_639_1": iso6391,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "width": width,
  };
}
