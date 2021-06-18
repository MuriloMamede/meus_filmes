import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:meus_filmes/app/data/model/profile_model.dart';
import 'package:meus_filmes/app/data/model/user_model.dart';
import 'package:meus_filmes/app/data/provider/profile_provider.dart';
import 'package:meus_filmes/app/data/provider/user_provider.dart';
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
  var isSenhaVisible = false.obs;
  var isSenhanovaVisible = false.obs;

  @override
  void onInit() async {
    super.onInit();
    setController();
  }

  setController() {
    emailController.text = user.email;
    nomeController.text = user.name;
  }

  void logOut() {
    _userProvider.logOut();
  }

  editProfile(int index) async {
    profilesList[index].name = profileNomeController.text;
    if (await _profileProvider.editProfile(profilesList[index]) == 1) {
      profilesList.refresh();
      Get.back();
    }
  }
}
