import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/global/widgets/customBottomAppBar.dart';
import 'package:meus_filmes/app/modules/options/controllers/options_controller.dart';

class OptionsView extends GetView<OptionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      body: Column(
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
          Text(
            controller.user.name,
          ),
          Text(
            controller.birthDate,
          ),
          Text(
            controller.user.email,
          ),
        ],
      ),
    );
  }
}
