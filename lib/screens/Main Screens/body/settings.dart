import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
               

              
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "About",
                    style: TextStyle(
                      fontSize: 17,
                      color: pureWhiteBackgroundColor,
                      fontFamily: 'PopinsMedium',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Send Feedback",
                    style: TextStyle(
                      fontSize: 17,
                      color: pureWhiteBackgroundColor,
                      fontFamily: 'PopinsMedium',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Rate us on the Play Store",
                    style: TextStyle(
                      fontSize: 17,
                      color: pureWhiteBackgroundColor,
                      fontFamily: 'PopinsMedium',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                  child: Column(
                   
                    children: [
                      
                    
                      ElevatedButton(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                          await PPStreamSharedPreference.clearSharedPreference();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.white,
                          minimumSize: Size(160, 43),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                                style:
                                    TextStyle(fontSize: 16, color: primaryColor),
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
          ),
        ));
  }
}
