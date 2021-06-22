import 'dart:io';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:meus_filmes/app/data/model/profile_model.dart';
import 'package:meus_filmes/app/data/model/user_model.dart';
import 'package:meus_filmes/app/data/provider/profile_provider.dart';
import 'package:meus_filmes/app/data/provider/user_provider.dart';
import 'package:meus_filmes/app/global/constants.dart';
import 'package:meus_filmes/app/modules/home/controllers/home_controller.dart';

class OptionsController extends GetxController {
  final UserProvider _userProvider = UserProvider();
  final data = GetStorage();
  Map get userMap => data.read("user");
  HomeController _homeController = Get.find<HomeController>();
  User get user => User.fromMap(userMap);
  final ProfileProvider _profileProvider = ProfileProvider();
  RxList<Profile> get profilesList => _homeController.profilesList;
  TextEditingController profileNomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaAtualController = TextEditingController();
  TextEditingController senhaNovaController = TextEditingController();
  CustomPopupMenuController controllerMenu = CustomPopupMenuController();
  File image;
  var isSenhaVisible = false.obs;
  var isSenhanovaVisible = false.obs;
  var imagePicked = "".obs;
  @override
  void onInit() async {
    super.onInit();
    setController();
  }

  setImage(pickedFile) async {
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePicked.value = pickedFile.path;
      await _userProvider.changeImagePath(user.id, pickedFile.path);
      updateUserSaved();
    } else {
      print('No image selected.');
    }
  }

  setController() {
    emailController.text = user.email;
    nomeController.text = user.name;
    image = File(user.fotoPath);
    imagePicked(user.fotoPath);
  }

  changePassword() async {
    int response = await _userProvider.changePassword(
      idUser: user.id,
      newPassword: senhaNovaController.text,
      oldPassword: senhaAtualController.text,
    );
    if (response == 1) {
      Get.back();
      showSnackBar("Sucesso", "Senha alterada com sucesso!");
    } else if (response == 0) {
      showSnackBar("Ops..", "Senha atual incorreta");
      return;
    } else {
      Get.back();
      showSnackBar("Ops..", "Ocorreu um erro");
    }
    senhaNovaController.clear();
    senhaAtualController.clear();
  }

  updateUserSaved() {
    User userNovo = User.fromMap(user.toMap());

    userNovo.email = emailController.text.trim();
    userNovo.name = nomeController.text.trim();
    userNovo.fotoPath = imagePicked.value;
    data.write("user", userNovo.toMap());
  }

  updateUser() async {
    int response = await _userProvider.updateUser(
      user.id,
      nome: nomeController.text,
      email: emailController.text,
    );
    if (response == 1) {
      Get.back();
      updateUserSaved();
      showSnackBar("Sucesso", "Informações alteradas com sucesso!");
    } else {
      Get.back();
      showSnackBar("Ops..", "Ocorreu um erro");
    }
  }

  void logOut() {
    _userProvider.logOut();
  }

  editProfile(int index) async {
    print(profileNomeController.text);
    profilesList[index].name = profileNomeController.text;
    if (await _profileProvider.editProfile(profilesList[index]) == 1) {
      profilesList.refresh();
      Get.back();
    }
  }
}
