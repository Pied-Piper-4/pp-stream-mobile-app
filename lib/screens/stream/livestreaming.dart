import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveStreamingVideo extends StatefulWidget {
  const LiveStreamingVideo({Key? key}) : super(key: key);

  @override
  State<LiveStreamingVideo> createState() => _LiveStreamingVideoState();
}

class _LiveStreamingVideoState extends State<LiveStreamingVideo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1484780599,
        appSign: '7d4095bbeb97c1d44618b9af5888dd126570960ac4e6fdeb2b7a303ea8755041',
        userID: "user_id", // userID should only contain numbers, English characters and  '_'
        userName: 'user_name',
        liveName: 'live_name',
        config: ZegoUIKitPrebuiltLiveStreamingConfig(
          // set config properties based on roles, UI will drive by properties
          turnOnCameraWhenJoining: true,
          turnOnMicrophoneWhenJoining: true,
          useSpeakerWhenJoining: !true,
          menuBarButtons: true
              ? [
                  ZegoLiveMenuBarButtonName.toggleCameraButton,
                  ZegoLiveMenuBarButtonName.toggleMicrophoneButton,
                  ZegoLiveMenuBarButtonName.switchCameraFacingButton,
                ]
              : const [],
          useEndLiveStreamingButton: true,
        ),
      ),
    );
  }
}
