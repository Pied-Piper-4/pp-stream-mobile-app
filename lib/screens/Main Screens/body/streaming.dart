import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/streaming_card_tile.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({Key? key}) : super(key: key);

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  @override
  Widget build(BuildContext context) {
    final userDataProv = Provider.of<UserProvider>(context);
    // MediaQuery.of(context).viewInsets.bottom;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14, top: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Let's",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.w500,
                            color: pureWhiteBackgroundColor,
                          ),
                        ),
                        Text(
                          " Discover",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.w500,
                            color: yellowColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: mediaQueryData.viewInsets.bottom),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).popAndPushNamed(liveStreamPageRoute);
                          _modalBottomSheetMenu();
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.add,
                                  color: redShade,
                                  size: 20,
                                ),
                              ),
                              WidgetSpan(
                                  child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "Go Live",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "PoppinsMedium",
                                    color: redShade,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 190.0,
                          minWidth: 400.0,
                          maxHeight: 190.0,
                          maxWidth: 400.0,
                        ),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(36, 52, 71, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 26, // Image radius
                              backgroundImage: NetworkImage(userDataProv
                                      .user?.pic ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/300px-Gull_portrait_ca_usa.jpg"),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Pied Piper Live",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "PoppinsMedium",
                                          color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        userDataProv.user?.name ?? "PP User",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "PoppinsMedium",
                                            color: Colors.white54),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 6.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Text(
                                    //         "133 Views",
                                    //         style: TextStyle(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.white54),
                                    //       ),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       Text(
                                    //         "12 mins",
                                    //         style: TextStyle(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.white54),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            const Text(
                              'Recent Streams',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 22,
                                fontFamily: "PoppinsMedium",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          constraints: BoxConstraints.expand(height: 100),
                          padding: const EdgeInsets.only(top: 8.0),
                          color: Color.fromRGBO(36, 52, 71, 0.5),
                          alignment: Alignment.centerLeft,
                          // transform: Matrix4.rotationZ(0.1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "hey what's up guys i am live now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "This is a long text, and we are in lovely",
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(
                                      FontAwesomeIcons.arrowRight,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      print("Pressed");
                                    })
                              ],
                            ),
                          )),
                      meetingsList(context),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 18.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Center(
                  //   child: Text(
                  //     'Login',
                  //   ),
                  // ),
                  SizedBox(height: 8.0),
                  RoundedInput(
                    // onSaved: (data) {},
                    // onChanged: (data) {},
                    hintText: "Stream Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedInput(
                    // onSaved: (data) {},
                    // onChanged: (data) {},
                    hintText: "Stream Desc",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: roundedButton(
                      onTap: () {},
                      text: "Go Live",
                      width: MediaQuery.of(context).size.width * 0.6,
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ));
  }

  Widget meetingsList(context) {
    final meetingProv = Provider.of<MeetingsProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 340,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => Text(
          meetingProv.meetings[0].title!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        itemCount: meetingProv.meetings.length,
      ),
    );
  }
}
