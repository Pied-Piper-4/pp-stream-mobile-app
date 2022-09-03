import 'dart:convert';

import 'package:pp_stream_mobile_app/models/user.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PPStreamSharedPreference {
  static SharedPreferences? prefs;

  static Future<UserLogged> initState() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    bool isLogged = await PPStreamSharedPreference.checkUserLoggedIn(prefs);

    if (isLogged) {
      UserModel userData = await PPStreamSharedPreference.getUser(prefs);

      return UserLogged(isLogged: true, user: userData);
    }
    return UserLogged(isLogged: false, user: UserModel());
  }

  static Future<bool> checkUserLoggedIn(SharedPreferences? pref) async {
    return pref?.getBool('isLogged') ?? false;
  }

  static Future<bool> checkIfFirstTimeLoggedIn(SharedPreferences? pref) async {
    return pref?.getBool('firstLogged') ?? true;
  }

  static Future<void> setFirstLoggedFalseAfterLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLogged', false);
  }

  static Future<UserModel> getUser(SharedPreferences? pref) async {
    String? userJson = pref?.getString('user') ?? "{}";
    return UserModel.fromJson({...json.decode(userJson)});
  }

  static Future<void> persistUserLoginData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', true);
    prefs.setString('user', json.encode(user.toJson()));
  }



  static Future<bool> checkIfUserHasProvidedCameraAndGalleryPermission(
      SharedPreferences? pref) async {
    return pref?.getBool('cameraGalleryPermissionObtained') ?? false;
  }

  

  static clearSharedPreference() async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
