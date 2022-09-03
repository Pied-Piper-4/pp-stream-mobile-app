import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/constant/colors.dart';
import 'package:mobile_app/routes/routes.dart';
import 'package:mobile_app/screens/starters/splash_screen.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    // @required this.userLoggedAndData,
  }) : super(key: key);
  // final UserLogged? userLoggedAndData;

  @override
  Widget build(BuildContext context) {
    // bool isLogged = userLoggedAndData!.isLogged!;
    // print(isLogged);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: widget.logged != null && widget.logged==true ? mainScreenRoute:splashScreenRoute,
      theme: ThemeData(
        backgroundColor: dimmedWhiteBackgroundColor,
        primaryColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          color: primaryColor,
        ),
      ),
      //changed to login screen
      // home: !isLogged ? const SplashScreen() : const MainScreen(),
      home: SplashScreen(),
    );
  }
}
