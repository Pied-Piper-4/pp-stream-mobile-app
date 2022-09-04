import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/services/user_request.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';

class SignupFormPage extends StatefulWidget {
  const SignupFormPage({Key? key}) : super(key: key);

  @override
  State<SignupFormPage> createState() => _SignupFormPageState();
}

class _SignupFormPageState extends State<SignupFormPage> {
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? name = "";
  String? email = "";
  String? password = "";
  String? confirmPassword = "";
  bool obscurePasswordText = true;
  bool obscureConfirmPasswordText = true;

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
                  top: MediaQuery.of(context).size.width / 5,
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
                  top: MediaQuery.of(context).size.width / 10,
                  left: MediaQuery.of(context).size.width / 25,
                  right: MediaQuery.of(context).size.width / 25,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        nameInput(context),
                        const SizedBox(height: 10),
                        emailInput(context),
                        const SizedBox(height: 10),
                        passwordInput(context),
                        const SizedBox(height: 10),
                        confirmPasswordInput(context),
                        const SizedBox(height: 10),
                        Text(
                          "By signing up, you agree to our Terms of Service and Privacy Policy",
                          style: TextStyle(
                            color: HexColor("#A9A9A9"),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        roundedButton(
                          onTap: () {
                            signupIntegration(context);
                          },
                          text: "Register",
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
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

  Widget nameInput(context) {
    return RoundedInput(
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return "Please enter your full name";
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          name = value;
        });
      },
      onChanged: (String? value) {},
      isPasswordField: false,
      hintText: 'Please enter your name',
      keyboardType: TextInputType.emailAddress,
      labelText: 'Name',
      prefixIcon: Icon(
        Icons.person,
        color: HexColor(grayColor),
      ),
    );
  }

  Widget emailInput(context) {
    return RoundedInput(
      validator: MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'Please enter a valid email address')
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
      obscureText: obscurePasswordText,
      onPressObscureText: () {
        setState(() {
          obscurePasswordText = !obscurePasswordText;
        });
      },
      labelText: 'Password',
      prefixIcon: Icon(
        Icons.key,
        color: HexColor(grayColor),
      ),
      onChanged: (String? value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  Widget confirmPasswordInput(context) {
    return RoundedInput(
      validator: (value) {
        if (value != password) {
          return "Passwords do not match";
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          confirmPassword = value;
        });
      },
      isPasswordField: true,
      hintText: 'Please cofirm your password',
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureConfirmPasswordText,
      onPressObscureText: () {
        setState(() {
          obscureConfirmPasswordText = !obscureConfirmPasswordText;
        });
      },
      labelText: 'Confirm Password',
      prefixIcon: Icon(
        Icons.key,
        color: HexColor(grayColor),
      ),
      onChanged: (String? value) {
        setState(() {
          confirmPassword = value;
        });
      },
    );
  }

  Future<void> signupIntegration(context) async {
    if (_formKey.currentState!.validate()) {
      showDiaglog(context: context, text: 'Creating user account...');

      _formKey.currentState!.save();

      try {
        ApiResponse? response = await UserRequests.emailSignup(
          email: email,
          password: password,
          name: name,
        );

        Navigator.of(context).pop();

        if (!response!.hasError) {
          print("ok");
          // If there is no error
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(response.data);
          // PPStreamSharedPreference.persistUserLoginData(user.data);
          showSnackBar(
              context: context,
              text:"Woo hoo!! Account created successfully",
              backgroundColor: Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
            normalLoginPageRoute,
            (Route<dynamic> route) => false,
          );

          return;
        } else {
          print("Error creating user");
          showSnackBar(
              context: context,
              text: response.data,
              backgroundColor: Colors.red);
        }
      } catch (e) {
        print(e);
        Navigator.of(context).pop();
        return;
      }
    }
  }
}
