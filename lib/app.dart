import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/routes/routes.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/main_screen.dart';
import 'package:pp_stream_mobile_app/screens/authentication/signup_form.dart';
import 'package:pp_stream_mobile_app/screens/starters/splash_screen.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/user.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    @required this.userLoggedAndData,
  }) : super(key: key);
  final UserLogged? userLoggedAndData;

  @override
  Widget build(BuildContext context) {
    bool isLogged = userLoggedAndData!.isLogged!;
    // bool isLogged = userLoggedAndData!.isLogged!;
    // print(isLogged);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => isLogged ? UserProvider(user: userLoggedAndData?.user) : UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          backgroundColor: dimmedWhiteBackgroundColor,
          primaryColor: primaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: const AppBarTheme(
            color: primaryColor,
          ),
        ),
        //changed to login screen
        home: !isLogged ? const SplashScreen():const MainScreen(),
      ),
    );
  }
}
