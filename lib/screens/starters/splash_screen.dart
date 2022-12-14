// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';

import 'package:pp_stream_mobile_app/constant/page_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).popAndPushNamed(loadingScreenRoute),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhiteBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:  Center(
            child: Image(
              width: MediaQuery.of(context).size.width / 1.5,
              image: AssetImage(appLogo),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
