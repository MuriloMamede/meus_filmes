import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/modules/login/controllers/login_controller.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class SignUpPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void showDatPicker() async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2150),
        locale: Localizations.localeOf(context),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: accentColor,
              ),
            ),
            child: child,
          );
        },
      );
      if (date != null) {
        _loginController.dateS.value =
            DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(date);

        _loginController.date = date;
      }
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
                      child: Icon(
                        Icons.person_add,
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
                height: Get.height / 1.6,
                width: Get.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height * 0.055,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        controller: _loginController.nameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Campo obrigatorio";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            color: primaryColor,
                          ),
                          hintText: 'Nome',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height * 0.055,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        controller: _loginController.emailTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Campo obrigatorio";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Email Inválido";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Get.theme.primaryColor,
                          ),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height * 0.055,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        controller: _loginController.passwordTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Campo obrigatorio";
                          } else if (value.length < 6) {
                            return "Senha muito curta";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Get.theme.primaryColor,
                          ),
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height * 0.055,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Campo obrigatorio";
                          } else if (!(value ==
                              _loginController.passwordTextController.text)) {
                            return "Senhas não são iguais";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Get.theme.primaryColor,
                          ),
                          hintText: 'Confirmar Senha',
                        ),
                      ),
                    ),
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
