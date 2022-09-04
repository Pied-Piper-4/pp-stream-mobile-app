class ApiEntity {
  static const String googleMapsApiKey = 'AIzaSyAnhWbgJPv5AHOjmmpTgK4RlA05oYRJktA';
  static const String apiUrl = "https://api.pp-stream.live";
  static String get userServiceUrl => "$apiUrl/api-v1";
}

class UserServiceUrls {
  static String googleSignInEndpoint = "${ApiEntity.userServiceUrl}/user/google-auth";

  static String updateUserProfileEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/update-profile/$id";

  static String normalLoginEndpoint = "${ApiEntity.userServiceUrl}/user/login";
  static String normalSignupEndpoint = "${ApiEntity.userServiceUrl}/user/signup";
}

class MeetingUrls {
  static String getAllUserMeetingsEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/meeting/get-all/$id";

  static String createMeetingEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/meeting/create/$id";

  static String getMeetingTokenEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/meeting/generate-token/$id";

  static String closeOrEndMeetingEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/meeting/close-or-end/$id";
}
