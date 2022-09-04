import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:permission_handler/permission_handler.dart';
import 'package:pp_stream_mobile_app/constant/agora.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/chats/messages.dart';
import 'package:provider/provider.dart';

class LiveStream extends StatefulWidget {
  const LiveStream({Key? key}) : super(key: key);

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;
  bool showChat = false;
  String _enteredMessage = '';
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // initPlatformState(context);
    });
  }

  Future<void> initPlatformState(buildContext) async {
    final meetingProv = Provider.of<MeetingsProvider>(buildContext, listen: false);
    final userProv = Provider.of<UserProvider>(buildContext, listen: false);

    String userId = userProv.user!.userId!;
    String creatorId = meetingProv.selectedMeeting!.creatorId!.userId!;

    if (userId == creatorId) {
      if (Platform.isAndroid) {
        await [Permission.microphone, Permission.camera].request();
      }

      // Create RTC client instance
      RtcEngineContext context = RtcEngineContext(AGORA_APP_ID);
      var engine = await RtcEngine.createWithContext(context);

      // Define event handling logic
      engine.setEventHandler(
          RtcEngineEventHandler(joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('joinChannelSuccess ${channel} ${uid}');
        setState(() {
          _joined = true;
        });
      }, userJoined: (int uid, int elapsed) {
        print('userJoined ${uid}');
        setState(() {
          _remoteUid = uid;
        });
      }, userOffline: (int uid, UserOfflineReason reason) {
        print('userOffline ${uid}');
        setState(() {
          _remoteUid = 0;
        });
      }));

      await engine.enableVideo();
      // Set channel profile as livestreaming
      await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
      // Set user role as broadcaster
      await engine.setClientRole(ClientRole.Broadcaster);
      // Join channel with channel name as 123
      await engine.joinChannel(
        meetingProv.selectedMeeting!.token,
        meetingProv.selectedMeeting!.id!,
        null,
        0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: const Text(
            "Live Streaming...",
            style: TextStyle(fontFamily: "Poppins"),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                _showStopStreamingWarning(context);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                  ),
                  Positioned( 
                    bottom: 0,
                    child: Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Messages(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: TextStyle(
                                        color: pureWhiteBackgroundColor.withOpacity(.7),
                                      ),
                                      controller: _controller,
                                      onChanged: (value) {
                                        _enteredMessage = value;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter a message...",
                                        hintStyle: TextStyle(
                                          color: pureWhiteBackgroundColor,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _controller.clear();
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: pureWhiteBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget showLiveStreamSection() {
    return _renderRemoteVideo();
  }

  Widget showChatSection() {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Expanded(
            child: Messages(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50, left: 23, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: pureWhiteBackgroundColor.withOpacity(.7),
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(
                        color: pureWhiteBackgroundColor.withOpacity(.7),
                      ),
                      labelStyle: TextStyle(
                        color: pureWhiteBackgroundColor.withOpacity(.7),
                      ),
                      hintText: "Send a message...",
                      labelText: "Send a message...",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: _enteredMessage.trim().isEmpty ? null : () {},
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != 0 && Platform.isAndroid || _remoteUid != 0 && Platform.isIOS) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: "boanerges",
      );
    }

    // if (_remoteUid != 0 && defaultTargetPlatform == TargetPlatform.windows || _remoteUid != 0 && defaultTargetPlatform == TargetPlatform.macOS) {
    //   return RtcRemoteView.TextureView(
    //     uid: _remoteUid,
    //     channelId: "boanerges",
    //   );
    // }

    else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderLocalPreview() {
    if (_joined && Platform.isAndroid || _joined && Platform.isIOS) {
      return RtcLocalView.SurfaceView();
    }

    // if (_joined && defaultTargetPlatform == TargetPlatform.windows ||
    //         _joined && defaultTargetPlatform == TargetPlatform.macOS) {
    //   return RtcLocalView.TextureView();
    // }

    else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  void _showStopStreamingWarning(context) async {
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text('Stop Streaming'),
          content: const Text('Are you sure you want to stop streaming?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, mainScreenRoute);
              },
              child: const Text(
                'Stop Streaming now',
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
