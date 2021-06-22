import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kApiKey = 'd7ce90bea6eb17de7e4fe1e792261e84';
const kBaseUrl = 'https://api.themoviedb.org/3';
const imageUrl = 'https://image.tmdb.org/t/p/original/';
const imgNotFound = 'https://i.imgur.com/cb5sTfZ.png';

showSnackBar(String title, String message) => Get.snackbar(title, message,
    backgroundGradient: LinearGradient(colors: [Colors.black, Colors.black]),
    backgroundColor: Colors.black54,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(15),
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    isDismissible: true,
    duration: Duration(milliseconds: 1500),
    animationDuration: Duration(milliseconds: 400));

const String MYMOVIES_TABLE = 'myMovies';
const String MYMOVIES_ID = 'id';
const String MYMOVIES_TITLE = 'title';
const String MYMOVIES_POSTERPATH = 'posterPath';
const String MYMOVIES_ISWATCHED = 'isWatched';
const String MYMOVIES_ID_PROFILE = 'idProfile';
const String MYMOVIES_GENRES_ID = 'genresId';

const String USER_TABLE = 'user';
const String USER_ID = 'idUser';
const String USER_EMAIL = 'email';
const String USER_NAME = 'name';
const String USER_PASSWORD = 'password';
const String USER_FOTO_PATH = 'fotoPath';

const String PROFILE_TABLE = 'profile';
const String PROFILE_ID = 'idProfile';
const String PROFILE_USER_ID = 'profileUserId';
const String PROFILE_NAME = 'profileName';
