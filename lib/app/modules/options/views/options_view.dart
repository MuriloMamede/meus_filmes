import 'dart:ui';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meus_filmes/app/global/widgets/CustomTextField.dart';
import 'package:meus_filmes/app/global/widgets/ImageSelector.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/global/widgets/customBottomAppBar.dart';
import 'package:meus_filmes/app/modules/options/controllers/options_controller.dart';
import 'package:meus_filmes/app/modules/options/views/itemMenu.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class OptionsView extends GetView<OptionsController> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    void showImageSelector() {
      imageSelector(context, cameraTap: () async {
        Get.back();
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        controller.setImage(pickedFile);
      }, galeriaTap: () async {
        Get.back();
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        controller.setImage(pickedFile);
      });
    }

    void showProfileAdder(int index) {
      controller.profileNomeController.text =
          controller.profilesList[index].name;
      Get.defaultDialog(
        backgroundColor: Colors.black87,
        content: CustomTextField(
          controller: controller.profileNomeController,
          hintText: 'Nome',
          onEditingComplete: () {
            controller.editProfile(index);
          },
        ),
        title: 'Editar Nome',
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

    void showSenhaChanger() {
      Get.defaultDialog(
        backgroundColor: Colors.black87,
        content: Container(
            child: Column(
          children: [
            Obx(
              () => CustomTextField(
                controller: controller.senhaAtualController,
                hintText: "Senha Atual",
                icon: Icons.vpn_key,
                obscureText: !controller.isSenhaVisible.value,
                toggle: () {
                  controller.isSenhaVisible.toggle();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Senha Inv??lida";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Obx(() => CustomTextField(
                  controller: controller.senhaNovaController,
                  hintText: "Senha Nova",
                  icon: Icons.vpn_key,
                  obscureText: !controller.isSenhanovaVisible.value,
                  toggle: () {
                    controller.isSenhanovaVisible.toggle();
                  },
                  validator: (value) {
                    if (value.isEmpty && value.length < 6) {
                      return "Senha Inv??lida";
                    }
                    return null;
                  },
                )),
          ],
        )),
        title: 'Alterar Senha',
        titleStyle: TextStyle(
          color: Colors.white,
        ),
        actions: [
          InkWell(
            onTap: controller.changePassword,
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
                  'Salvar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );
    }

    void showUserChanger() {
      controller.setController();
      Get.defaultDialog(
        backgroundColor: Colors.black87,
        content: Container(
            child: Column(
          children: [
            CustomTextField(
              controller: controller.nomeController,
              hintText: "Nome",
              keyboardType: TextInputType.name,
              icon: Icons.person,
              validator: (value) {
                if (value.isEmpty) {
                  return "Nome Inv??lido";
                }
                return null;
              },
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            CustomTextField(
              controller: controller.emailController,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
              validator: (value) {
                if (value.isEmpty && !GetUtils.isEmail(value)) {
                  return "Email Inv??lido";
                }
                return null;
              },
            ),
          ],
        )),
        title: 'Alterar Dados',
        titleStyle: TextStyle(
          color: Colors.white,
        ),
        actions: [
          InkWell(
            onTap: controller.updateUser,
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
                  'Salvar',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: Get.height / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomPopupMenu(
                        child: Container(
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(20),
                        ),
                        menuBuilder: () => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            decoration:
                                BoxDecoration(gradient: primaryGradient),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ItemMenu(
                                    title: 'Trocar Senha',
                                    icon: Icons.vpn_key,
                                    onTap: () {
                                      controller.controllerMenu.hideMenu();
                                      showSenhaChanger();
                                    },
                                  ),
                                  ItemMenu(
                                    title: 'Editar Usu??rio',
                                    icon: Icons.person,
                                    onTap: () {
                                      controller.controllerMenu.hideMenu();
                                      showUserChanger();
                                    },
                                  ),
                                  ItemMenu(
                                    title: 'Trocar Foto',
                                    icon: Icons.image,
                                    onTap: () {
                                      controller.controllerMenu.hideMenu();
                                      showImageSelector();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        pressType: PressType.singleClick,
                        verticalMargin: -10,
                        controller: controller.controllerMenu,
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          Get.defaultDialog(
                            backgroundColor: Colors.white10,
                            title: 'Deseja mesmo sair?',
                            titleStyle: TextStyle(color: Colors.white),
                            onCancel: () {},
                            textConfirm: 'Sim',
                            textCancel: 'N??o',
                            confirmTextColor: Colors.white,
                            onConfirm: () => controller.logOut(),
                            middleText: "",
                            // middleTextStyle: TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ],
                  ),
                  Obx(() {
                    return controller.imagePicked.value != ""
                        ? Align(
                            alignment: Alignment.center,
                            child: Image.file(
                              controller.image,
                              width: Get.height * 0.2,
                              height: Get.height * 0.2,
                              fit: BoxFit.cover,
                            ))
                        : CircularProgressIndicator();
                  }),
                ],
              ),
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
              //height: Get.height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
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
