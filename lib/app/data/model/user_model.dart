import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meus_filmes/app/global/constants.dart';

class User {
  int id;
  String email;
  String password;
  String name;
  String fotoPath;

  User({
    this.name,
    this.email,
    this.password,
    this.id,
    this.fotoPath,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json[USER_EMAIL],
        password: json[USER_PASSWORD],
        name: json[USER_NAME],
        fotoPath: json[USER_FOTO_PATH],
        id: json[USER_ID],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      USER_EMAIL: this.email,
      USER_NAME: this.name,
      USER_FOTO_PATH: this.fotoPath,
      USER_PASSWORD: sha1.convert(utf8.encode(this.password)).toString(),
    };

    if (id != null) {
      map[USER_ID] = this.id;
    }

    return map;
  }
}
