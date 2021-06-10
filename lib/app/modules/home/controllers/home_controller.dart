import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meus_filmes/app/data/model/movie_model.dart';
import 'package:meus_filmes/app/data/model/profile_model.dart';
import 'package:meus_filmes/app/data/provider/movie_provider.dart';
import 'package:meus_filmes/app/data/provider/myMovies_provider.dart';
import 'package:meus_filmes/app/data/provider/profile_provider.dart';

class HomeController extends GetxController {
  final MovieProvider _movieProvider = MovieProvider();
  final MyMoviesProvider _myMoviesProvider = MyMoviesProvider();
  final ProfileProvider _profileProvider = ProfileProvider();

  final TextEditingController nameProfileController = TextEditingController();
  final data = GetStorage();

  final moviesPopularList = <Movie>[].obs;
  final moviesRecomendedList = <Movie>[].obs;
  var myMoviesList = <Movie>[].obs;
  var profilesList = <Profile>[].obs;
  int get userId => data.read("userId");
  int get profileId => data.read("profileId");

  void addtoMyList(obj) async {
    Movie selectedMovie = obj;

    selectedMovie.idProfile = profileId;
    try {
      Movie newMovie = await _myMoviesProvider.insertItem(selectedMovie);

      if (newMovie == null) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      } else {
        myMoviesList.add(newMovie);
        getMoviesRecommeded();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Ops...', content: Text(e.toString()));
    }
  }

  void selectPerfil(id) async {
    data.write("profileId", id);

    myMoviesList.assignAll(await _myMoviesProvider.getProfileMovies(id));
    Get.back();
  }

  void addProfile() async {
    Profile newProfile = await _profileProvider
        .insertItem(Profile(name: nameProfileController.text, userId: userId));
    if (newProfile != null) {
      profilesList.add(newProfile);
      nameProfileController.clear();
      Get.back();
    } else {
      Get.back();
      Get.defaultDialog(
          title: 'Ops..',
          content: Text('Você só pode ter 4 perfis diferentes'));
    }
  }

  void getMoviesRecommeded() async {
    moviesRecomendedList
        .assignAll(await _movieProvider.getRecommendedMovies(profileId));
  }

  void markAsWatched(index) async {
    Movie selectedMovie = myMoviesList[index];
    selectedMovie.isWatched = !selectedMovie.isWatched;
    try {
      await _myMoviesProvider.updateItem(selectedMovie);
      myMoviesList[index] = selectedMovie;
    } catch (e) {
      if (e.getResultCode() == 1555) {
        Get.defaultDialog(title: 'Ops...', content: Text(e.toString()));
      }
    }
  }

  void loadData() async {
    moviesPopularList.assignAll(await _movieProvider.getPopular());
  }

  @override
  void onInit() async {
    myMoviesList.assignAll(await _myMoviesProvider.getProfileMovies(profileId));
    profilesList.assignAll(await _profileProvider.getUserProfiles(userId));
    getMoviesRecommeded();
    super.onInit();
  }
}
