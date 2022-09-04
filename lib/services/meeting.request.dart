import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pp_stream_mobile_app/constant/api_routes.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';
import 'package:pp_stream_mobile_app/models/user.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MeetingsApiRequest {
  static Future<ApiResponse?> createMeeting({
    required String? userId,
    required String? title,
    required String? token,
    String? description,
  }) async {
    var url = Uri.parse(MeetingUrls.createMeetingEndpoint(userId!));

    try {
      http.Response response = await http.post(
        url,
        body: json.encode(
          {
            "title": title,
            "description": description,
          },
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      print(responseJson);

      if (responseJson['status'] == 'success') {
        return ApiResponse.success(
          MeetingModel.fromJson(
            {
              ...responseJson['data'],
              "token": responseJson["token"],
            },
          ),
        );
      }

      return ApiResponse(
        hasError: true,
        data: responseJson?['message'] ?? "Error",
      );
    } catch (e) {
      print("wow");
      return ApiResponse.withError(e);
    }
  }

  static Future<ApiResponse?> getMeetings({
    required String? userId,
    required String? token,
  }) async {
    var url = Uri.parse(MeetingUrls.getAllUserMeetingsEndpoint(userId!));

    try {
      http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      print(responseJson['status']);

      if (responseJson['status'] == 'success') {
        List<MeetingModel> meetings = [];
        for (var meeting in responseJson['data']) {
          meetings.add(MeetingModel.fromJson(meeting));
        }
        return ApiResponse.success(
          meetings,
        );
      }

      return ApiResponse(
        hasError: true,
        data: responseJson?['message'] ?? "Error",
      );
    } catch (e) {
      print("wow");
      print(e);
      return ApiResponse.withError(e);
    }
  }
}
