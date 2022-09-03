import 'package:google_sign_in/google_sign_in.dart';
import 'package:pp_stream_mobile_app/constant/api_routes.dart';
import 'package:pp_stream_mobile_app/models/user.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class UserRequests {
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

        final response = await http.post(
          url,
          body: json.encode({
            "access_token": googleAuth.idToken,
            "platform": Platform.isAndroid ? "android" : "ios",
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
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}