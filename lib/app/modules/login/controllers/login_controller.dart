import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meus_filmes/app/data/model/profile_model.dart';

import 'package:meus_filmes/app/data/model/user_model.dart';
import 'package:meus_filmes/app/data/provider/profile_provider.dart';

import 'package:meus_filmes/app/data/provider/user_provider.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserProvider _userProvider = UserProvider();
  final ProfileProvider _profileProvider = ProfileProvider();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final data = GetStorage();
  var dateS = ''.obs;
  DateTime date = DateTime.now();

  void register() async {
    User user = await _userProvider.signUp(User(
        birthDate: date,
        email: emailTextController.text,
        password: passwordTextController.text,
        name: nameTextController.text));

    if (user != null) {
      Get.defaultDialog(title: 'Sucesso', content: Text('Usuario cadastrado'));
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.defaultDialog(title: 'Ops..', content: Text('Email já cadastrado'));
    }
    passwordTextController.clear();
  }

  void login() async {
    User user = await _userProvider.login(
        emailTextController.text, passwordTextController.text);

    if (user != null) {
      Profile profile = await _profileProvider.getFirstUserProfile(user.id);
      data.write("profileId", profile.id);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
          title: 'Ops..', content: Text('Email e/ou senha incorretos'));
    }
  }

  @override
  void onReady() {
    if (data.read("user") != null) {
      Get.offAllNamed(Routes.HOME);
    }
    super.onReady();
  }
}
