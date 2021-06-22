import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meus_filmes/app/data/model/profile_model.dart';
import 'package:meus_filmes/app/data/model/user_model.dart';
import 'package:meus_filmes/app/data/provider/dataBase_provider.dart';
import 'package:meus_filmes/app/global/constants.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';

class UserProvider {
  final databaseProvider = DataBaseProvider.db;

  final data = GetStorage();

  Future<User> login(String email, String passwd) async {
    final db = await databaseProvider.database;
    User user;
    try {
      var result = await db.query(USER_TABLE,
          columns: [
            USER_EMAIL,
            USER_PASSWORD,
            USER_NAME,
            USER_ID,
            USER_FOTO_PATH
          ],
          where: '$USER_PASSWORD = ? and $USER_EMAIL = ?',
          whereArgs: [sha1.convert(utf8.encode(passwd)).toString(), email]);

      if (result.length > 0) {
        user = User.fromMap(result.first);
        data.write("userId", user.id);
        data.write("user", user.toMap());
        return user;
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int> changeImagePath(int idUser, String newPath) async {
    final db = await databaseProvider.database;
    try {
      int updateCount = await db.update(
          USER_TABLE,
          {
            USER_FOTO_PATH: newPath,
          },
          where: '$USER_ID = ?',
          whereArgs: [idUser]);

      return updateCount;
    } catch (e) {
      print(e.toString());
      return -1; //erro
    }
  }

  Future<int> changePassword(
      {int idUser, String oldPassword, String newPassword}) async {
    final db = await databaseProvider.database;

    try {
      var result = await db.query(USER_TABLE,
          columns: [USER_ID],
          where: '$USER_ID = ? and $USER_PASSWORD = ?',
          whereArgs: [
            idUser,
            sha1.convert(utf8.encode(oldPassword)).toString(),
          ]);

      if (result.length > 0) {
        //senha corresponde

        int updateCount = await db.update(USER_TABLE,
            {USER_PASSWORD: sha1.convert(utf8.encode(newPassword)).toString()},
            where: '$USER_ID = ?', whereArgs: [idUser]);

        return updateCount;
      } else
        return 0; //senha nao coincide
    } catch (e) {
      print(e.toString());
      return -1; //erro
    }
  }

  Future<int> updateUser(int idUser, {String email, String nome}) async {
    final db = await databaseProvider.database;

    try {
      //senha corresponde

      int updateCount = await db.update(
          USER_TABLE,
          {
            USER_EMAIL: email.trim(),
            USER_NAME: nome.trim(),
          },
          where: '$USER_ID = ?',
          whereArgs: [idUser]);

      return updateCount;
    } catch (e) {
      print(e.toString());
      return -1; //erro
    }
  }

  void _clearSession() {
    data.write("userId", null);
    data.write("profileId", null);
    data.write("user", null);
  }

  void logOut() {
    _clearSession();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<User> signUp(User user) async {
    final db = await databaseProvider.database;
    try {
      List<dynamic> result = await db.query(USER_TABLE,
          columns: [USER_EMAIL],
          where: '$USER_EMAIL = ?',
          whereArgs: [user.email]);
      if (result.length <= 0) {
        user.id = await db.insert(USER_TABLE, user.toMap());
        Profile profile = Profile(name: user.name, userId: user.id);
        profile.id = await db.insert(PROFILE_TABLE, profile.toMap());
        return user;
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
