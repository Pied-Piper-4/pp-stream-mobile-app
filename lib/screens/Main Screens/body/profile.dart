import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String updatedName = "";
  TextEditingController nameController = TextEditingController();
  String updatedPhone = "";
  TextEditingController phoneController = TextEditingController();
  String updatedEmail = "";
  TextEditingController emailController = TextEditingController();
  String updatedUserHandle = "";
  TextEditingController userHandleController = TextEditingController();
  DateTime updatedDob = DateTime.now();
  TextEditingController dobController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    return userProv.user == null
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  topImageContent(context),
                  userDetailsContent(context),
                ],
              ),
            ),
          );
  }

  Widget topImageContent(context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        coverImage(context),

        profileImage(context),
        // coverPicEditButton(context),
      ],
    );
  }

  Widget userDetailsContent(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width / 4,
        left: MediaQuery.of(context).size.width / 20,
        right: MediaQuery.of(context).size.width / 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name",
            style: TextStyle(
              color: primaryColor,
              fontSize: 10,
              fontFamily: "PoppinsMedium",
            ),
          ),
          nameField(context),
          const SizedBox(height: 20),
          const Text(
            "Email ID",
            style: TextStyle(
              color: primaryColor,
              fontSize: 10,
              fontFamily: "PoppinsMedium",
            ),
          ),
          emailField(context),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Divider(),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "About",
              style: TextStyle(
                fontSize: 17,
                color: primaryColor,
                fontFamily: 'PopinsMedium',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Send Feedback",
              style: TextStyle(
                fontSize: 17,
                color: primaryColor,
                fontFamily: 'PopinsMedium',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Rate us on the Play Store",
              style: TextStyle(
                fontSize: 17,
                color: primaryColor,
                fontFamily: 'PopinsMedium',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: primaryColor,
                    minimumSize: Size(160, 43),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    elevation: 5,
                  ),
                  child: RichText(
                    text: const TextSpan(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.person,
                            size: 20,
                          ),
                        ),
                        TextSpan(
                          text: "  Delete Account",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    await PPStreamSharedPreference.clearSharedPreference();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.white,
                    minimumSize: Size(160, 43),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    elevation: 5,
                  ),
                  child: RichText(
                    text: const TextSpan(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.exit_to_app_outlined,
                            size: 20,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: "  Logout",
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameField(context) {
    final userDataProv = Provider.of<UserProvider>(context);
    return Form(
      child: TextFormField(
        controller: nameController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: userDataProv.user?.name ?? "PP User",
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 17,
            fontFamily: "PoppinsMedium",
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget emailField(context) {
    final userDataProv = Provider.of<UserProvider>(context);
    return Form(
      key: _emailFormKey,
      child: TextFormField(
        // enabled: false,
        controller: emailController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: userDataProv.user?.email ?? "fetching your email...",
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 17,
            fontFamily: "PoppinsMedium",
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget coverImage(context) {
    final userDataProv = Provider.of<UserProvider>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4.5,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
    );
  }

  Widget profileImage(context) {
    final userDataProv = Provider.of<UserProvider>(context);
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.5 - 50,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(
                userDataProv.user!.pic!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
