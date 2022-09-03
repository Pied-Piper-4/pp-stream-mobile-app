import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pp_stream_mobile_app/constant/api_routes.dart';
import 'package:pp_stream_mobile_app/models/user.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class UserRequests {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final _googleAuth = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.email'
    ],
  );

  static Future<ApiResponse?> googleAuth() async {
    var url = Uri.parse(UserServiceUrls.googleSignInEndpoint);
    try {
      GoogleSignInAccount? googleResponse =
          await UserRequests._googleAuth.signIn();

      if (googleResponse != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleResponse.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCred =
            await UserRequests.auth.signInWithCredential(credential);

        if (userCred.user != null) {
          final response = await http.post(
            url,
            body: json.encode({
              "name": userCred.user!.displayName,
              "email": userCred.user!.email,
              "pic": userCred.user!.photoURL,
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );

          var responseJson = json.decode(response.body);
          if (responseJson['status'] == 'success') {
            return ApiResponse.success(
              UserModel.fromJson(
                {
                  ...responseJson["data"],
                  "authToken": responseJson["authToken"],
                  "userId": responseJson?["data"]["_id"],
                },
              ),
            );
          }
          return ApiResponse(hasError: true, data: responseJson['data']);
        }

        // FirebaseAuth.instance.authStateChanges().listen((User? user) {
        //   print(user?.email);
        //   if (user == null) {
        //     print('User is currently signed out!');
        //   } else {
        //     print('User is signed in!');

        //     final userData = UserModel(
        //       email: user.email,
        //       name: user.displayName,
        //       phone: user.phoneNumber,
        //     );
        //   }
        // });
        // return ApiResponse.success("success");

      }
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
