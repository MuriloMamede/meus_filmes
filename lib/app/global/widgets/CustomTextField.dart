import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Function toggle;
  final IconData icon;
  final String hintText;
  final bool obscureText;

  const CustomTextField(
      {this.controller,
      this.hintText,
      this.icon,
      this.toggle,
      this.validator,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.2,
      height: 45,
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        validator: validator,
        obscureText: obscureText == null ? false : obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: obscureText != null
                ? obscureText == true
                    ? InkWell(
                        child: Icon(Icons.visibility),
                        onTap: toggle,
                      )
                    : InkWell(
                        child: Icon(Icons.visibility_off),
                        onTap: toggle,
                      )
                : null,
            icon: Icon(
              icon,
              color: primaryColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
