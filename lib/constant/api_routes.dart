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
