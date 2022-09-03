import 'package:pp_stream_mobile_app/models/user.dart';

class NormalSignUpResponse {
  String? id;
  String? authToken;
  NormalSignUpResponse({this.id, this.authToken});
  NormalSignUpResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    authToken = json["authToken"];
  }
}

class UserLogged {
  bool? isLogged;
  UserModel? user;
  UserLogged({this.isLogged, this.user});
}
