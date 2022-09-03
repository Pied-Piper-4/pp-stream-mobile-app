import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  UserProvider({this.user});
  void setUser(UserModel? user) {
    this.user = user;
    notifyListeners();
  }

  UserModel? getPartner() {
    return user;
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }
}
