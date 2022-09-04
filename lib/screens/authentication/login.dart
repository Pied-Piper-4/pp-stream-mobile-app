import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/services/user_request.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey1 = GlobalKey<FormState>();
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    // TODO: implement initStatex
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _callPhoneNumberModalBottomSheet(context);
    // });
  }

  Future<void> signInWithGoogle(context) async {
    ShowLoadingDialogWidget.showDialogue(
        context: context, message: "Processing...");

    try {
      ApiResponse? response = await UserRequests.googleAuth();
      if (response!.hasError) {
        Navigator.of(context).pop();
        snackBar(message: response.data, context: context);
        print(response.data);
        return;
      }

      PPStreamSharedPreference.persistUserLoginData(response.data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isGoogle', true);
      final userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.setUser(response.data);
      Navigator.of(context).pushNamed(confirmLoginRoute);
    } catch (e) {
      Navigator.of(context).pop();
      showSnackBar(
        context: context,
        text: "Oops! Something went wrong. Please try again later.",
        backgroundColor: Colors.red,
      );
      print("error on google login screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey2,
      backgroundColor: pureWhiteBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 3,
                ),
                child: Center(
                  child: Image(
                    width: MediaQuery.of(context).size.width / 2,
                    image: const AssetImage(appLogo),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 6,
                  left: MediaQuery.of(context).size.width / 25,
                  right: MediaQuery.of(context).size.width / 25,
                ),
                child: Column(
                  children: [
                    roundedIconButton(
                      svgImagePath: password,
                      text: "Traditional Login",
                      onTap: () async {
                        // await signInWithGoogle(context);
                        Navigator.of(context).pushNamed(normalLoginPageRoute);
                      },
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(height: 10),
                    // horizontalDivider(context),
                    roundedIconButton(
                      svgImagePath: googleLogo,
                      text: "Sign in with Google",
                      onTap: () async {
                        await signInWithGoogle(context);
                        // Navigator.of(context).pushNamed(confirmLoginRoute);
                      },
                      width: MediaQuery.of(context).size.width,
                    ),

                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, signupOptionsRoute),
                      child: const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            "Click here to create an account",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Poppins",
                              color: primaryColor,
                            ),
                          )),
                    ),

                    // roundedIconButton(
                    //   svgImagePath: appleLogo,
                    //   text: "Sign in with Apple",
                    //   onTap: () {},
                    //   width: MediaQuery.of(context).size.width,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: serviceComponent(context: context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
