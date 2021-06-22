import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meus_filmes/app/global/widgets/CustomTextField.dart';
import 'package:meus_filmes/app/global/widgets/ImageSelector.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/modules/login/controllers/login_controller.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class SignUpPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    void showImageSelector() {
      imageSelector(context, cameraTap: () async {
        Get.back();
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        _loginController.setImage(pickedFile);
      }, galeriaTap: () async {
        Get.back();
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        _loginController.setImage(pickedFile);
      });
    }

    return Scaffold(
      appBar: CustomBar(""),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height / 3.5,
                decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Get.back()),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return _loginController.imagePicked.value != ""
                            ? Align(
                                alignment: Alignment.center,
                                child: Image.file(
                                  _loginController.image,
                                  width: Get.height * 0.15,
                                  height: Get.height * 0.15,
                                  fit: BoxFit.cover,
                                ))
                            : Icon(
                                Icons.person_add,
                                size: 90,
                                color: Colors.white,
                              );
                      }),
                    ),
                    Spacer(),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 5),
                            child: ElevatedButton(
                              onPressed: showImageSelector,
                              child: Text('Selecionar Imagem'),
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Container(
                height: Get.height / 1.6,
                width: Get.width,
                padding: EdgeInsets.only(top: 62, left: 28, right: 28),
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      controller: _loginController.nameTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        }
                        return null;
                      },
                      icon: Icons.person,
                      hintText: 'Nome',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _loginController.emailTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Email Inválido";
                        }
                        return null;
                      },
                      icon: Icons.email,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _loginController.passwordTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (value.length < 6) {
                              return "Senha muito curta";
                            }
                            return null;
                          },
                          obscureText:
                              !_loginController.senhaCadastroIsVisible.value,
                          toggle: () {
                            _loginController.senhaCadastroIsVisible.toggle();
                          },
                          icon: Icons.vpn_key,
                          hintText: 'Senha',
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!(value ==
                                _loginController.passwordTextController.text)) {
                              return "Senhas não são iguais";
                            }
                            return null;
                          },
                          obscureText:
                              !_loginController.senhaConfirmIsVisible.value,
                          toggle: () {
                            _loginController.senhaConfirmIsVisible.toggle();
                          },
                          icon: Icons.vpn_key,
                          hintText: 'Confirmar Senha',
                        )),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _loginController.register();
                        }
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Get.theme.primaryColor,
                                Get.theme.primaryColor,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Cadastrar'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
