import 'dart:convert';

import 'package:e_commerce/data/model/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPreferenceUtils {
  String? token;
  User? user;

  Future<User?> get getUser async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userAsString = pref.getString('user');
    if (userAsString == null) return null;
    return User.fromJson(jsonDecode(userAsString));
  }

  Future<String?> get getToken async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  void saveUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', jsonEncode(user.toJson()));
  }

  void saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }
}
