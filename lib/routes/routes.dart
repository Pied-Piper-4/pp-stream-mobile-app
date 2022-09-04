import 'package:flutter/material.dart';

import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/livestream/livestream.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/main_screen.dart';
import 'package:pp_stream_mobile_app/screens/authentication/confirm_login.dart';
import 'package:pp_stream_mobile_app/screens/authentication/login.dart';
import 'package:pp_stream_mobile_app/screens/authentication/normal_login.dart';
import 'package:pp_stream_mobile_app/screens/authentication/signup_form.dart';
import 'package:pp_stream_mobile_app/screens/authentication/signup_option.dart';
import 'package:pp_stream_mobile_app/screens/starters/loading_screen.dart';
import 'package:pp_stream_mobile_app/screens/starters/on_boarding_screen.dart';
import 'package:pp_stream_mobile_app/screens/starters/splash_screen.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loadingScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case loginRoute:
        //I have replaced login screen  with Place Order Main Page
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case mainScreenRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case confirmLoginRoute:
        return MaterialPageRoute(builder: (_) => const ConfirmLoginScreen());
      case onBoardingScreenRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case liveStreamPageRoute:
        return MaterialPageRoute(builder: (_) => const LiveStream());
      case normalLoginPageRoute:
        return MaterialPageRoute(builder: (_) => const NormalLogin());
      case signupOptionsRoute:
          return MaterialPageRoute(builder: (_) => const SignupOptionScreen());
      case signupFormPageRoute:
          return MaterialPageRoute(builder: (_) => const SignupFormPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
