import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("pt", "BR"),
    ],
    title: 'Meus Filmes',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: AppPages.INITIAL,
    theme: appThemeData,
  ));
}
