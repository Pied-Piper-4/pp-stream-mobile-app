import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';

Widget reusableButton({
  @required context,
  @required buttonText,
  @required onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: primaryColor),
      ),
      // minimumSize: Size(500, 50),
      primary: primaryColor,
    ),
    child: Text(
      buttonText,
      style: const TextStyle(
        fontFamily: 'Poppins',
        color: pureWhiteBackgroundColor,
        fontSize: 20,
      ),
    ),
  );
}

Widget horizontalDivider(context) {
  return Padding(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).size.height / 70,
      bottom: MediaQuery.of(context).size.height / 70,
    ),
    child: Row(children: const <Widget>[
      Expanded(
          child: Divider(
        color: grayButtonColor,
      )),
      Text(
        "  or  ",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: grayButtonColor,
        ),
      ),
      Expanded(
          child: Divider(
        color: grayButtonColor,
      )),
    ]),
  );
}

Widget roundedIconButton({
  @required svgImagePath,
  @required text,
  @required onTap,
  double? width,
}) {
  return InkWell(
    onTap: onTap,
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      width: width! * 0.8,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(
          color: HexColor("#dbdad7"),
        ),
        boxShadow: [
          BoxShadow(
            color: HexColor("#dbdad7"),
            offset: const Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              svgImagePath!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style: TextStyle(
              color: HexColor("#928f87"),
            ),
          )
        ],
      ),
    ),
  );
}

Widget dataCollectionFormField({
  required Key? key,
  required TextEditingController? controller,
  required String? hintText,
  required TextInputType? keyboardType,
  required String? Function(String?)? validator,
  required double? fontSize,
  required Color? color,
}) {
  return Form(
    key: key!,
    child: TextFormField(
      controller: controller!,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType!,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: fontSize!, color: color!),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: hintText!,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    ),
  );
}

Widget serviceComponent({
  required BuildContext context,
}) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 25,
            bottom: MediaQuery.of(context).size.height / 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'By continuing, you agree to our',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: grayButtonColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: const [
                  Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                  Text(
                    'Context Policy',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// snackBar Widget
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
  String? message,
  BuildContext? context,
}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      // behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(message ?? "error"),
      duration: const Duration(seconds: 2),
    ),
  );
}

class ShowLoadingDialogWidget {
  static void showDialogue({
    @required BuildContext? context,
    @required String? message,
  }) async {
    return showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (builder) {
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 150.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const SpinKitPulse(
                  color: primaryColor,
                  size: 50.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message!,
                  style: const TextStyle(
                    color: deepBlueColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget onBoardingSlide(
    {Size? size, String? imagePath, String? title, String? desc}) {
  double height = size!.height;
  double width = size.width;
  return Column(
    children: [
      SizedBox(
        child: SvgPicture.asset(
          imagePath!,
        ),
        height: height * 0.3,
        width: width,
      ),
      SizedBox(
        height: height * 0.05,
      ),
      Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: deepBlueColor,
          fontSize: 33,
          fontFamily: "Poppins",
        ),
      ),
      SizedBox(height: height * 0.02),
      Text(
        desc!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          height: 1.5,
          color: grayButtonColor,
          fontFamily: "PoppinsMedium",
          fontSize: 17,
        ),
      ),
    ],
  );
}
