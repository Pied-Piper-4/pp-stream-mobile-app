class ApiEntity {
  static const String googleMapsApiKey =
      'AIzaSyAnhWbgJPv5AHOjmmpTgK4RlA05oYRJktA';
  static const String apiUrl = "https://saiyan.phubie.com";
  static String get userServiceUrl => "$apiUrl/user/service";
}

class UserServiceUrls {
  static String phoneSignupEndpoint =
      "${ApiEntity.userServiceUrl}/user/phone-authenticate";
  static String verifyPhoneOTPEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/phone-verify/$id";
  static String resendPhoneOTPEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/resend-phone-otp/$id";
  static String googleSignInEndpoint =
      "${ApiEntity.userServiceUrl}/user/google-auth";
  static String googlePhoneAuthenticationEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/google-auth/phone-authenticate/$id";
  static String updateUserProfileEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/update-profile/$id";
  static String requestEmailOtpEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/email-authenticate/$id";
  static String verifyEmailOTPEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/email-verify/$id";
  static String resendEmailOTPEndpoint(String id) =>
      "${ApiEntity.userServiceUrl}/user/resend-email-otp/$id";

  
}
