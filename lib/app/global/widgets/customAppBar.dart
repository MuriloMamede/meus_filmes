import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class CustomBar extends PreferredSize {
  final double size = Get.height;
  final String title;
  final double height;
  final List<Widget> leadings;
  final List<Widget> actions;

  CustomBar(
    this.title, {
    this.leadings = const [],
    this.actions = const [],
    this.height = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return GradientAppBar(
      gradient: primaryGradient,
      actions: actions,
      title: Text(title),
      leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
    );
  }
}
