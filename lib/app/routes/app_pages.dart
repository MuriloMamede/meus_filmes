import 'package:get/get.dart';

import 'package:meus_filmes/app/modules/home/bindings/home_binding.dart';
import 'package:meus_filmes/app/modules/home/views/home_view.dart';
import 'package:meus_filmes/app/modules/login/bindings/login_binding.dart';
import 'package:meus_filmes/app/modules/login/views/login_view.dart';
import 'package:meus_filmes/app/modules/signUp/bindings/sign_up_binding.dart';
import 'package:meus_filmes/app/modules/signUp/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
  ];
}
