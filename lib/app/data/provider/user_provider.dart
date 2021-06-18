import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meus_filmes/app/data/model/profile_model.dart';
import 'package:meus_filmes/app/data/model/user_model.dart';
import 'package:meus_filmes/app/data/provider/dataBase_provider.dart';
import 'package:meus_filmes/app/data/provider/profile_provider.dart';
import 'package:meus_filmes/app/global/constants.dart';
import 'package:meus_filmes/app/routes/app_pages.dart';

class UserProvider {
  final databaseProvider = DataBaseProvider.db;
  final ProfileProvider _profileProvider = ProfileProvider();
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
            USER_BIRTHDATE,
            USER_ID
          ],
          where: '$USER_PASSWORD = ? and $USER_EMAIL = ?',
          whereArgs: [sha1.convert(utf8.encode(passwd)).toString(), email]);

      if (result.length > 0) {
        user = User.fromMap(result.first);
        _saveSession(user);
        return user;
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void _saveSession(User user) async {
    Profile profile = await _profileProvider.getFirstUserProfile(user.id);
    data.write("userId", user.id);
    data.write("profileId", profile.id);
    data.write("user", user.toMap());
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
