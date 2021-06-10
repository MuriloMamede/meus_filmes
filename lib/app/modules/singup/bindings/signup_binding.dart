import 'package:get/get.dart';
import 'package:meus_filmes/app/modules/login/controllers/login_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
