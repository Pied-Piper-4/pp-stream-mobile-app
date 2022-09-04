import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:particles_flutter/particles_flutter.dart';
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
          
          //Description about the user
          Text(
            "The Best Streaming Platform for podcast enthusiasts.",
            style: TextStyle(
              color: primaryColor,
              fontSize: MediaQuery.of(context).size.width / 25,
              fontFamily: "PoppinsMedium",
            ),
          ),
          const SizedBox(height: 10),
          //Long message about the user
          const Text(
            "Here at PP Stream, we prioritise a user-friendly live streaming experience for podcast listeners, make recording live podcasts easier for creators and much more.",
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontFamily: "Poppins",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Divider(),
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4.5,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      child: CircularParticle(
        // key: UniqueKey(),
        awayRadius: 60,
        numberOfParticles: 99,
        speedOfParticles: 1,
        height: screenHeight,
        width: screenWidth,
        onTapAnimation: true,
        particleColor: Colors.white.withAlpha(150),
        awayAnimationDuration: Duration(milliseconds: 20000),
        maxParticleSize: 3,
        isRandSize: true,
        isRandomColor: true,
        randColorList: [
          // Colors.red.withAlpha(210),
          Colors.white.withAlpha(210),
          // Colors.yellow.withAlpha(210),
          // Colors.green.withAlpha(210)
        ],
        awayAnimationCurve: Curves.decelerate,
        enableHover: false,
        hoverColor: Colors.white,
        hoverRadius: 90,
        connectDots: true, //not recommended
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
                userDataProv.user?.pic! ??
                    "https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
