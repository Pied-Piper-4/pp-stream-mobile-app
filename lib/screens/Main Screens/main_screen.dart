import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/profile.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/all_meetings.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/streaming.dart';
import 'package:pp_stream_mobile_app/services/meeting.request.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedNav = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchAllData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: const [
        StreamingPage(),
        AllMeetingsPage(),
        ProfilePage(),
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

          // ALL meetings
          DotNavigationBarItem(
            icon: Icon(Icons.public),
            selectedColor: primaryColor,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Future<void> fetchAllData(context) async {
    await fetchAllUserMeetings(context);
    await fetchAllPublicMeetings(context);
  }

  Future<void> fetchAllUserMeetings(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await MeetingsApiRequest.getMeetings(
        userId: userProvider.user?.userId,
        token: userProvider.user?.token,
      );

      if (!response!.hasError) {
        // Save to provider
        final meetingsPro = Provider.of<MeetingsProvider>(
          context,
          listen: false,
        );

        print(response.data.length);
        meetingsPro.setAllMeetings(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllPublicMeetings(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await MeetingsApiRequest.getAllPublicMeetings(
        token: userProvider.user?.token,
      );

      if (!response!.hasError) {
        // Save to provider
        final meetingsPro = Provider.of<MeetingsProvider>(
          context,
          listen: false,
        );
        print("1");
        print(response.data.length);
        print(response.data);
        meetingsPro.setPublicMeetings(response.data);
      }
    } catch (e) {
      print(e);
    }
  }
}
