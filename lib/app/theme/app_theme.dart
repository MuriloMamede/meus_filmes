import 'package:flutter/material.dart';
import 'package:meus_filmes/app/theme/colors.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Colors.red,
    buttonColor: Colors.redAccent,
    scaffoldBackgroundColor: brancoFundo,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black87)),
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
    accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.redAccent,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      color: Colors.red,
      textTheme: TextTheme(
        headline6:
            TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'roboto'),
        subtitle1: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
      ),
    ));
