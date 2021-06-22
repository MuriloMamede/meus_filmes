import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meus_filmes/app/global/widgets/CustomTextField.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/modules/login/controllers/login_controller.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                    Spacer(),
                    Align(
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
                height: Get.height / 2,
                width: Get.width,
                padding: EdgeInsets.only(top: 62, left: 28, right: 28),
                child: Column(
                  children: <Widget>[
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
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Obx(() => CustomTextField(
                          onEditingComplete: () {
                            if (_formKey.currentState.validate()) {
                              _loginController.login();
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: _loginController.passwordTextController,
                          validator: (value) {
                            return null;
                          },
                          toggle: () {
                            _loginController.senhaIsVisible.toggle();
                          },
                          obscureText: !_loginController.senhaIsVisible.value,
                          hintText: 'Senha',
                          icon: Icons.vpn_key,
                        )),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _loginController.login();
                        }
                      },
                      child: Container(
                        height: 45,
                        width: Get.width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Entrar'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      child: Container(
                        height: Get.height * 0.055,
                        width: Get.width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Cadastrar'.toUpperCase(),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
