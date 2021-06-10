import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
        height: Get.height * 0.06,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
                /*Get.offNamed(
                  Routes.SEARCH,
                );*/
              }),
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
                Get.offNamed(
                  Routes.HOME,
                );
              }),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
                /*Get.offNamed(
                  Routes.OPTIONS,
                );*/
              }),
        ]),
      ),
    );
  }
}
