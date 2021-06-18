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
  TextEditingController nomeController = TextEditingController();
  final UserProvider _userProvider = UserProvider();
  final data = GetStorage();
  Map get userMap => data.read("user");
  HomeController _homeController = Get.find<HomeController>();
  User get user => User.fromMap(userMap);
  final ProfileProvider _profileProvider = ProfileProvider();
  RxList<Profile> get profilesList => _homeController.profilesList;
  String get birthDate =>
      DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(user.birthDate);
  @override
  void onInit() async {
    super.onInit();
  }

  void logOut() {
    _userProvider.logOut();
  }

  editProfile(int index) async {
    profilesList[index].name = nomeController.text;
    if (await _profileProvider.editProfile(profilesList[index]) == 1) {
      profilesList.refresh();
      Get.back();
    }
  }
}
