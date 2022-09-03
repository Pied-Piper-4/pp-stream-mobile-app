import 'package:flutter/material.dart';
import 'package:mobile_app/constant/page_routes.dart';
import 'package:mobile_app/screens/authentication/login.dart';
import 'package:mobile_app/screens/starters/loading_screen.dart';
import 'package:mobile_app/screens/starters/splash_screen.dart';

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

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}