import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/services/meeting.request.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({Key? key}) : super(key: key);

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  bool? isPrivate = false;
  @override
  Widget build(BuildContext context) {
    final userDataProv = Provider.of<UserProvider>(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Padding(
          padding:
              EdgeInsets.only(left: 14.0, right: 14, top: MediaQuery.of(context).size.height / 15),
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
                    padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
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
                            // color: Color.fromRGBO(36, 52, 71, 0.5),
                            
                            image: DecorationImage(image: AssetImage(cover)),
                            
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 26, // Image radius
                            backgroundImage: NetworkImage(userDataProv.user?.pic ??
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
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: const Text(
                                      "Piper Chat",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "PoppinsMedium",
                                          color: Colors.white),
                                    ),
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
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Popular Streams',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                              fontFamily: "PoppinsMedium",
                              color: pureWhiteBackgroundColor.withOpacity(.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    meetingsList(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> goLive(context) async {}

  Widget meetingsList(context) {
    final meetingProv = Provider.of<MeetingsProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 230,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) => SizedBox(
          width: width,
          // height: 250,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
            child: Container(
                constraints: const BoxConstraints.expand(height: 100),
                color: const Color.fromRGBO(36, 52, 71, 0.5),
                alignment: Alignment.centerLeft,
                // transform: Matrix4.rotationZ(0.1),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                meetingProv.meetings[index].closed! ? "Closed" : "Live",
                                style: TextStyle(
                                    color: meetingProv.meetings[index].closed!
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            meetingProv.meetings[index].title!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            meetingProv.meetings[index].description ?? "",
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: meetingProv.meetings[index].closed! ? Colors.red : Colors.green,
                        ),
                        onPressed: () {
                          if (!meetingProv.meetings[index].closed!) {
                            MeetingModel chosenModel = meetingProv.meetings[index];
                            meetingProv.setSelectMeeting(chosenModel);
                            Navigator.of(context).pushNamed(liveStreamPageRoute);
                          }
                        },
                      )
                    ],
                  ),
                )),
          ),
        ),
        itemCount: meetingProv.meetings.length,
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
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20, right: 20, left: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8.0),
                  RoundedInput(
                    onSaved: (value) {
                      mystate(() {
                        title = value;
                      });
                    },
                    onChanged: (data) {
                      mystate(() {
                        title = data;
                      });
                    },
                    hintText: "Stream Title",
                    keyboardType: TextInputType.text,
                    denySpace: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedInput(
                    onSaved: (data) {
                      mystate(() {
                        description = data;
                      });
                    },
                    onChanged: (data) {
                      mystate(() {
                        description = data;
                      });
                    },
                    hintText: "Stream Desc",
                    keyboardType: TextInputType.text,
                    denySpace: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: roundedButton(
                            onTap: () {
                              createStream(context);
                            },
                            text: "Go Live",
                            width: MediaQuery.of(context).size.width * 0.6,
                            backgroundColor: primaryColor,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlutterSwitch(
                          activeText: "Private",
                          inactiveText: "Public",
                          width: 125.0,
                          height: 55.0,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: isPrivate!,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            mystate(() {
                              isPrivate = val;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> createStream(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final meetingProv = Provider.of<MeetingsProvider>(context, listen: false);
      final userProv = Provider.of<UserProvider>(context, listen: false);

      showDiaglog(context: context, text: 'Going live');
      try {
        var response = await MeetingsApiRequest.createMeeting(
          title: title,
          description: description,
          isPrivate: isPrivate!,
          token: userProv.user!.token,
          userId: userProv.user!.userId,
        );

        print("ok");
        if (!response!.hasError) {
          print("ok2");
          meetingProv.addMeeting(response.data!);
          meetingProv.setSelectMeeting(response.data);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(liveStreamPageRoute);
          return;
        }
      } catch (e) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        print(e);
        return;
      }
    }
  }
}
