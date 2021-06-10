import 'package:get/get.dart';

import 'package:meus_filmes/app/modules/home/bindings/home_binding.dart';
import 'package:meus_filmes/app/modules/home/views/home_page.dart';

import 'package:meus_filmes/app/modules/login/bindings/login_binding.dart';
import 'package:meus_filmes/app/modules/login/views/login_page.dart';
import 'package:meus_filmes/app/modules/singup/bindings/signup_binding.dart';
import 'package:meus_filmes/app/modules/singup/views/signup_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
  ];
}
