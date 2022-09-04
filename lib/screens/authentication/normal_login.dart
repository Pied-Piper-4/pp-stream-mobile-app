import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/services/user_request.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';

class NormalLogin extends StatefulWidget {
  const NormalLogin({Key? key}) : super(key: key);

  @override
  State<NormalLogin> createState() => _NormalLoginState();
}

class _NormalLoginState extends State<NormalLogin> {
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? email = "";
  String? password = "";
  bool obscureText = true;

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
                  top: MediaQuery.of(context).size.width / 3.5,
                  left: MediaQuery.of(context).size.width / 25,
                  right: MediaQuery.of(context).size.width / 25,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        emailInput(context),
                        const SizedBox(height: 10),
                        passwordInput(context),
                        const SizedBox(height: 10),
                        roundedButton(
                          onTap: () {
                            loginIntegration(context);
                          },
                          text: "Login",
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: serviceComponent(context: context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailInput(context) {
    return RoundedInput(
      validator: MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'enter a valid email address')
      ]),
      onSaved: (value) {
        setState(() {
          email = value;
        });
      },
      onChanged: (String? value) {},
      isPasswordField: false,
      hintText: 'Please enter your email',
      keyboardType: TextInputType.emailAddress,
      labelText: 'Email',
      prefixIcon: Icon(
        Icons.email,
        color: HexColor(grayColor),
      ),
    );
  }

  Widget passwordInput(context) {
    return RoundedInput(
      validator: MultiValidator([
        RequiredValidator(errorText: 'Password is required'),
        // EmailValidator(errorText: 'enter a valid email address')
      ]),
      onSaved: (value) {
        setState(() {
          password = value;
        });
      },
      isPasswordField: true,
      hintText: 'Please enter your password',
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      onPressObscureText: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      labelText: 'Password',
      prefixIcon: Icon(
        Icons.key,
        color: HexColor(grayColor),
      ),
      onChanged: (String? value) {},
    );
  }

  Future<void> loginIntegration(context) async {
    if (_formKey.currentState!.validate()) {
      showDiaglog(context: context, text: 'Logging In User...');

      _formKey.currentState!.save();

      try {
        ApiResponse? response = await UserRequests.emailLogin(
          email: email,
          password: password,
        );

        Navigator.of(context).pop();
        print(response!.hasError);
        if (!response.hasError) {
          // If there is no error
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(response.data);
          PPStreamSharedPreference.persistUserLoginData(response.data);
          Navigator.of(context).pushNamedAndRemoveUntil(
            confirmLoginRoute,
            (Route<dynamic> route) => false,
          );
          return;
        } else {
          showSnackBar(
            context: context,
            text: response.data.toString(),
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        showSnackBar(
          context: context,
          text: "Oops! Something went wrong. Please try again later.",
          backgroundColor: Colors.red,
        );
        print("Error on Normal Login S");
        return;
      }
    }
  }
}
