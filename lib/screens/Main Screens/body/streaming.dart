import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/streaming_card_tile.dart';
import 'package:pp_stream_mobile_app/services/meeting.request.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/api_response.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';
import 'package:provider/provider.dart';

class StreamingPage extends StatefulWidget {
  const StreamingPage({Key? key}) : super(key: key);

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  final _formKey = GlobalKey<FormState>();
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
                            color: Color.fromRGBO(36, 52, 71, 0.5),
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
                                      "Pied Piper Live",
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
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          if (meetingProv.meetings[index].closed!) {
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
        // itemBuilder: (_, index) => GestureDetector(
        //   child: Container(
        //     child: Text(
        //       meetingProv.meetings[index].title!,
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        //   onTap: () async {
        //     final meetingProv = Provider.of<MeetingsProvider>(context, listen: false);
        //     final userDataProv = Provider.of<UserProvider>(context, listen: false);
        //     meetingProv.setSelectMeeting(meetingProv.meetings[index]);
        //     ApiResponse? apiresponse = await MeetingsApiRequest.getToken(
        //       meetingId: meetingProv.meetings[index].id,
        //       token: userDataProv.user!.token,
        //     );

        //     if (!apiresponse!.hasError) {
        //       MeetingModel chosenModel = meetingProv.meetings[index];
        //       // chosenModel.token = apiresponse.data;
        //       meetingProv.setSelectMeeting(chosenModel);
        //       Navigator.of(context).pushNamed(liveStreamPageRoute);
        //     }
        //     // Navigator.of(context).pushNamed(liveStreamPageRoute);
        //   },
        // ),
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
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            top: 20, right: 20, left: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
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
      ),
    );
  }
}
