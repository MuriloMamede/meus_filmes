import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/data/model/movie_model.dart';
import 'package:meus_filmes/app/data/model/movie_response_model.dart';
import 'package:meus_filmes/app/data/provider/myMovies_provider.dart';
import 'package:meus_filmes/app/global/constants.dart';

class MovieProvider extends GetConnect {
  final String token = kApiKey;
  searchMovie(String query) async {
    var response = await get(kBaseUrl +
        "/search/movie?api_key=$token&language=pt-BR&query=$query&page=1&include_adult=false");

    if (response.hasError) {
      showSnackBar("Error Catch", response.statusText);
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      List<Movie> list = <Movie>[];

      if (response != null) {
        model.movies.forEach((e) {
          list.add(e);
        });
      }

      return list;
    } else {
      showSnackBar("Error", response.body['error']);
      return null;
    }
  }

  getRecommendedMovies(int idProfile) async {
    MyMoviesProvider _myMovies = MyMoviesProvider();
    String genresId = await _myMovies.getPreferredGenres(idProfile);

    var response = await get(kBaseUrl +
        "/discover/movie?api_key=$kApiKey&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genresId");

    if (response.hasError) {
      showSnackBar("Error Catch", response.statusText);
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      List<Movie> list = <Movie>[];

      if (response != null) {
        model.movies.forEach((e) {
          list.add(e);
        });
      }

      return list;
    } else {
      showSnackBar("Error", response.body['error']);
      return null;
    }
  }

  getPopular() async {
    var response = await get(
        kBaseUrl + "/movie/popular?page=1&api_key=$token&language=pt-BR");

    if (response.hasError) {
      showSnackBar("Error Catch", response.statusText);
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      List<Movie> list = <Movie>[];

      if (response != null) {
        model.movies.forEach((e) {
          list.add(e);
        });
      }

      return list;
    } else {
      showSnackBar("Error", response.body['error']);
      return null;
    }
  }
}
