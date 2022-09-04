class UserModel {
  String? userId;
  String? name;
  String? email;
  bool? logged;
  bool? blocked;
  bool? isGoogleAuth;
  bool? isActive;
  String? phone;
  String? token;
  String? pic;
  UserModel({
    this.userId,
    this.name,
    this.logged,
    this.email,
    this.phone,
    this.token,
    this.pic,
    this.blocked,
    this.isActive,
    this.isGoogleAuth,
  });

  UserModel.fromJson(Map parsedJson) {
    userId = parsedJson['_id'] ?? "";
    name = parsedJson['name'] ?? "";
    email = parsedJson['email'] ?? "";
    phone = parsedJson['phone'] ?? "";
    token = parsedJson['token'] ?? "";
    pic = parsedJson['pic'] ?? "";
    isActive = parsedJson['isActive'] ?? false;
    isGoogleAuth = parsedJson['isGoogleAuth'] ?? false;
    blocked = parsedJson['blocked'] ?? false;
  }

  Map<String, dynamic> toJson() => {
        "_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "token": token,
        "pic": pic,
        "blocked": blocked,
        "isGoogleAuth": isGoogleAuth,
        "isActive": isActive,
        "logged": logged,
      };
}
