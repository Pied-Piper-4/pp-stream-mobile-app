import 'dart:convert';

import 'package:pp_stream_mobile_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PPStreamSharedPreference {
  static SharedPreferences? prefs;

  static Future<UserModel> initState() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    bool isLogged = await PPStreamSharedPreference.checkUserLoggedIn(prefs);

    if (isLogged) {
      UserModel userModel = await PPStreamSharedPreference.getPartner(prefs);

      return userModel;
    }
    return UserModel();
  }

  static Future<bool> checkUserLoggedIn(SharedPreferences? pref) async {
    return pref?.getBool('logged') ?? false;
  }

  static Future<UserModel> getPartner(SharedPreferences? pref) async {
    String? userJson = pref?.getString('user') ?? "{}";
    return UserModel.fromJson({...json.decode(userJson)});
  }

  static Future<void> persistUserLoginData(UserModel partner) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', true);
    prefs.setString('user', json.encode(partner.toJson()));
  }

  static clearSharedPreference() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
