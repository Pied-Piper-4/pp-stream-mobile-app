import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/profile.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/settings.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/streaming.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor:Colors.black,
      body: const [
        StreamingPage(),
        ProfilePage(),
        SettingsPage(),
        
      ].elementAt(selectedNav),
      bottomNavigationBar: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: selectedNav,
          dotIndicatorColor: Colors.white,
          // duration: const Duration(milliseconds: 300),
          unselectedItemColor: Colors.grey[300],
          
          onTap: (index) {
              setState(() {
                selectedNav = index;
              });
            },
          items: [
            /// Streaming
            DotNavigationBarItem(
              icon: Icon(Icons.video_call),
              selectedColor: primaryColor,
            ),

            
          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor:  primaryColor,
          ),
            /// settings
            DotNavigationBarItem(
              icon: Icon(Icons.settings),
              selectedColor:  primaryColor,
            ),
          ],
        ),
    );
  }
}
