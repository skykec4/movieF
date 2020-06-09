import 'dart:convert';

import 'package:away/models/movie_detail_model.dart';
import 'package:away/models/movie_image_model.dart';
import 'package:away/models/movie_model.dart';
import 'package:away/models/movie_trailer_model.dart';
import 'package:away/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  final baseUrl = 'https://api.themoviedb.org/3/';

  //개봉예정작 - Up Coming Movie (GET).. movieModel
  //movie/upcoming?api_key=ce16f7da30a47ba16d9f038d895318bd&language=ko-KR&page=1
  //포스터 출력 https://image.tmdb.org/t/p/w500/ + backdrop_path
  Future<List<MovieModel>> getMovieModel(String title) async {
    List<MovieModel> result;
    final response = await http.get(
        '${baseUrl}movie/${title}?api_key=${Constant.apiKey}&language=${Constant
            .language}&page=1');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var resultData = data['results'] as List;

      result = resultData
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return result;
    } else {
      print('fetch fail');

      throw Exception('Server Load Fail');
    }
  }

  //현재상영작 - Now Playing(GET).. movieModel
  //movie/now_playing?api_key=ce16f7da30a47ba16d9f038d895318bd&language=ko-KR&page=1&region=KR

  //인기? - Popular(GET).. movieModel
  //movie/popular?api_key=ce16f7da30a47ba16d9f038d895318bd&language=ko-KR&page=1&region=KR

  //비디오(트레일러) - Videos(GET).. movieTrailerModel
  //movie/77117/videos?api_key=ce16f7da30a47ba16d9f038d895318bd : 77117(Movie_ID)
  Future<MovieTrailerModel> getMovieVideos(int id) async {
    final response = await http.get(
        '${baseUrl}movie/$id/videos?api_key=${Constant
            .apiKey}&language=${Constant.language}');

    if (response.statusCode == 200) {
      print('fetch success : getMovieVideos');
      // If the call to the server was successful, parse the JSON.

      return compute(movieTrailerModelFromJson, response.body);
    } else {
      print('fetch fail');

      throw Exception('Failed to load post');
    }
  }

  //영화검색 - Search(GET).. movieModel
  //search/movie?api_key=ce16f7da30a47ba16d9f038d895318bd&query=엑스맨&language=ko-KR&page=1 : query(검색명)

  Future<List<MovieModel>> getSearchMovie(String searchMovie) async {
    List<MovieModel> result;
    print(
        '======================== [API : moveiModel ] ========================');
    final response = await http
        .get('${baseUrl}search/movie?api_key=${Constant
        .apiKey}&query=${searchMovie}&language=${Constant.language}');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var resultData = data['results'] as List;

      result = resultData
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return result;
    } else {
      print('fetch fail');

      throw Exception('Server Load Fail');
    }
  }

  //추천작 - Recommendation(GET).. movieModel
  //movie/475557/recommendations?api_key=ce16f7da30a47ba16d9f038d895318bd&language=ko-KR&page=1

  Future<List<MovieModel>> getRecommendMovie(int movieId) async {
    List<MovieModel> result;
    print(
        '======================== [API : moveiModel ] ========================');
    final response = await http
        .get('${baseUrl}movie/${movieId}/recommendations?api_key=${Constant
        .apiKey}&language=${Constant.language}&page=1');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var resultData = data['results'] as List;

      result = resultData
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return result;
    } else {
      print('fetch fail');

      throw Exception('Server Load Fail');
    }
  }

  //비슷한 영화 - Similar(GET).. movieSimilarModel
  //movie/448119/similar?api_key=ce16f7da30a47ba16d9f038d895318bd&language=ko-KR&page=1 : 448119(Movie_ID)

//상세- Get Details
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await http.get(
        '${baseUrl}movie/$id?api_key=${Constant.apiKey}&language=${Constant
            .language}');

    if (response.statusCode == 200) {
      print('fetch success : getMovieDetail');
      // If the call to the server was successful, parse the JSON.

      return compute(movieDetailModelFromJson, response.body);
    } else {
      print('fetch fail');

      throw Exception('Failed to load post');
    }
  }

  //이미지
  Future<MovieImageModel> getMovieImages(int id, String language) async {
    final response = await http.get(
        '${baseUrl}movie/$id/images?api_key=${Constant
            .apiKey}&language=$language');

    if (response.statusCode == 200) {
      print('fetch success : getMovieImages');
      // If the call to the server was successful, parse the JSON.

      return compute(movieImageModelFromJson, response.body);
    } else {
      print('fetch fail');

      throw Exception('Failed to load post');
    }
  }
}

