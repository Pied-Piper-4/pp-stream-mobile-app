import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ConfirmLoginScreen extends StatefulWidget {
  const ConfirmLoginScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmLoginScreen> createState() => _ConfirmLoginScreenState();
}

class _ConfirmLoginScreenState extends State<ConfirmLoginScreen> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 1),
      () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final user = await PPStreamSharedPreference.getUser(pref);

        Navigator.of(context)
            .pushNamedAndRemoveUntil(mainScreenRoute, (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                checkLogo,
                color: primaryColor,
                width: MediaQuery.of(context).size.width / 2.5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 20,
                  bottom: MediaQuery.of(context).size.width / 20,
                ),
                child: const Text(
                  'LOGGED IN',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryColor,
                    fontSize: 26,
                  ),
                ),
              ),
              const Text(
                'Redirecting...',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }
}
