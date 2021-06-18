import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String pageSelected;
  CustomBottomAppBar(this.pageSelected);
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
                color: pageSelected == "search"
                    ? Colors.white.withOpacity(1)
                    : Colors.white.withOpacity(0.3),
              ),
              onPressed: () {
                Get.toNamed(
                  Routes.SEARCH,
                );
              }),
          IconButton(
              icon: Icon(
                Icons.home,
                color: pageSelected == "home"
                    ? Colors.white.withOpacity(1)
                    : Colors.white.withOpacity(0.3),
              ),
              onPressed: () {
                Get.toNamed(
                  Routes.HOME,
                );
              }),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: pageSelected == "options"
                    ? Colors.white.withOpacity(1)
                    : Colors.white.withOpacity(0.3),
              ),
              onPressed: () {
                Get.toNamed(
                  Routes.OPTIONS,
                );
              }),
        ]),
      ),
    );
  }
}
