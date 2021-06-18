import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/global/widgets/customBottomAppBar.dart';
import 'package:meus_filmes/app/modules/options/controllers/options_controller.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class OptionsView extends GetView<OptionsController> {
  @override
  Widget build(BuildContext context) {
    void showProfileAdder(int index) {
      controller.nomeController.text = controller.profilesList[index].name;
      Get.defaultDialog(
        backgroundColor: Colors.black87,
        content: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            controller: controller.nomeController,
            autofocus: true,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nome',
            ),
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
        ),
        title: 'Editar',
        titleStyle: TextStyle(
          color: Colors.white,
        ),
        actions: [
          InkWell(
            onTap: () {
              controller.editProfile(index);
            },
            child: Container(
              height: 45,
              width: Get.width / 1.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Get.theme.primaryColor,
                      Get.theme.primaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                child: Text(
                  'Salvar'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomBar(''),
      bottomNavigationBar: CustomBottomAppBar("options"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height / 3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Get.theme.primaryColor,
                      Colors.black,
                    ], //Color(0xff6bceff)
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        controller.logOut();
                      },
                    ),
                  ),
                  Align(
                    //trocar iconce pela foto do usuario
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: Get.height * 0.37,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Seus Perfis",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Container(
              height: Get.height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      var profile = controller.profilesList[index];
                      return ListTile(
                        title: Text(
                          profile.name,
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              showProfileAdder(index);
                            }),
                      );
                    },
                    itemCount: controller.profilesList.length,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
