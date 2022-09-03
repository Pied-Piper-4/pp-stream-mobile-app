class UserModel {
  String? userId;
  String? name;
  String? email;
  int? age;
  bool? logged;
  bool? email_verified;
  bool? phone_verified;
  String? otp;
  String? emailOtp;
  String? dateOfBirth;
  String? userHandle;
  String? phone;
  String? authToken;
  String? pic;
  List? addresses;
  UserModel({
    this.userId,
    this.name,
    this.logged,
    this.email_verified,
    this.phone_verified,
    this.dateOfBirth,
    this.email,
    this.emailOtp,
    this.age,
    this.otp,
    this.phone,
    this.authToken,
    this.pic,
  });

  UserModel.fromJson(Map parsedJson) {
    userId = parsedJson['_id'] ?? "";
    name = parsedJson['name'] ?? "";
    email = parsedJson['email'] ?? "";
    email_verified = parsedJson["email_verified"] ?? false;
    phone_verified = parsedJson["phone_verified"] ?? false;
    emailOtp = parsedJson['email_verification_otp'].toString();
    otp = parsedJson['otp'] ?? "";
    phone = parsedJson['phone'] ?? "";
    authToken = parsedJson['authToken'] ?? "";
    pic = parsedJson['pic'] ?? "";
    userHandle = parsedJson['userHandle'] ?? "";
    dateOfBirth = parsedJson['dateOfBirth'] ?? "";
    addresses = parsedJson['addresses'] ?? [];
  }

  Map<String, dynamic> toJson() => {
        "_id": userId,
        "name": name,
        "email": email,
        "email_verified": email_verified,
        "phone_verified": phone_verified,
        "otp": otp,
        "phone": phone,
        "authToken": authToken,
        "pic": pic,
        "userHandle": userHandle,
        "dateOfBirth": dateOfBirth,
        "addresses": addresses,
      };
}
