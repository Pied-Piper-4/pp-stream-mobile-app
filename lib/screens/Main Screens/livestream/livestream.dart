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
import 'package:pp_stream_mobile_app/screens/Main%20Screens/chats/messages.dart';

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
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(AGORA_APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
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
    await engine.joinChannel(AGORA_TEMP_TOKEN, 'boanerges', null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Streaming...",
          style: TextStyle(fontFamily: "Poppins"),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showChat = !showChat;
              });
            },
            icon: const Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _switch = !_switch;
              });
            },
            icon: const Icon(Icons.switch_camera),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              // child: _renderRemoteVideo(),
            ),
            showChat
                ? Expanded(
                    child: showChatSection(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget showChatSection() {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Expanded(
            child: Messages(),
          ),
          Container(
            padding: EdgeInsets.only(bottom:20, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
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
    if (_remoteUid != 0 && Platform.isAndroid ||
        _remoteUid != 0 && Platform.isIOS) {
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

  @override
  void dispose() {
    super.dispose();
  }
}
