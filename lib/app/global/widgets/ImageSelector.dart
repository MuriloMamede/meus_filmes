import 'package:flutter/material.dart';
import 'package:get/get.dart';

imageSelector(context, {Function cameraTap, Function galeriaTap}) => {
      showModalBottomSheet(
          backgroundColor: Color(0xff1d1f1e),
          context: context,
          builder: (context) => Container(
                width: Get.width,
                height: Get.height * 0.089,
                child: ListView(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: Get.width / 2,
                      child: ListTile(
                        leading: Icon(Icons.camera_alt, color: Colors.white),
                        title: Text(
                          "Camera",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: cameraTap,
                      ),
                    ),
                    Container(
                      width: Get.width / 2,
                      child: ListTile(
                        leading: Icon(Icons.image, color: Colors.white),
                        title: Text(
                          "Galeria",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: galeriaTap,
                      ),
                    )
                  ],
                ),
              ))
    };
