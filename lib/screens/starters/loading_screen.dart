import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).popAndPushNamed(loginRoute),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: dimmedWhiteBackgroundColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SpinKitChasingDots(
              color: deepBlueColor,
              size: 50.0,
            ),
          ],
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
