import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meus_filmes/app/data/model/movie_model.dart';
import 'package:meus_filmes/app/data/provider/movie_provider.dart';
import 'package:meus_filmes/app/data/provider/myMovies_provider.dart';
import 'package:meus_filmes/app/global/constants.dart';

class SearchController extends GetxController {
  final MovieProvider _movieProvider = MovieProvider();
  final MyMoviesProvider _myMoviesProvider = MyMoviesProvider();
  final data = GetStorage();

  int get userId => data.read("userId");
  int get profileId => data.read("profileId");
  var movies = <Movie>[].obs;

  void searchMovie(String query) async {
    if (query != null) {
      if (query.length > 3) {
        movies.assignAll(await _movieProvider.searchMovie(query));
      }
    }
  }

  void addtoMyList(int index) async {
    //  movies[index].
    Movie selectedMovie = movies[index];
    selectedMovie.idProfile = profileId;
    try {
      var result = await _myMoviesProvider.insertItem(selectedMovie);
      print(result);
      if (result != null) {
        showSnackBar('Sucesso', 'Filme adicionado');
      } else {
        showSnackBar('Ops...', 'Filme já adicionada na lista');
      }
    } catch (e) {
      if (e.getResultCode() == 1555) {
        showSnackBar('Ops', 'Error: ' + e.getResultCode().toString());
      }
    }
  }
}
