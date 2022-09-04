import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/providers/meeting.provider.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/services/meeting.request.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveStreamingVideo extends StatefulWidget {
  const LiveStreamingVideo({Key? key}) : super(key: key);

  @override
  State<LiveStreamingVideo> createState() => _LiveStreamingVideoState();
}

class _LiveStreamingVideoState extends State<LiveStreamingVideo> {
  @override
  Widget build(BuildContext context) {
    final meetingProv = Provider.of<MeetingsProvider>(context);
    final userProv = Provider.of<UserProvider>(context);
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1484780599,
        appSign: '7d4095bbeb97c1d44618b9af5888dd126570960ac4e6fdeb2b7a303ea8755041',
        userID: userProv
            .user!.userId!, // userID should only contain numbers, English characters and  '_'
        userName: userProv.user!.name!, // userName can contain any characters
        liveName: meetingProv.selectedMeeting!.title!,
        config: ZegoUIKitPrebuiltLiveStreamingConfig(
          // set config properties based on roles, UI will drive by properties
          turnOnCameraWhenJoining:
              meetingProv.selectedMeeting!.creatorId!.userId == userProv.user!.userId,
          turnOnMicrophoneWhenJoining:
              meetingProv.selectedMeeting!.creatorId!.userId == userProv.user!.userId,
          useSpeakerWhenJoining: false,
          menuBarButtons: true
              ? [
                  ZegoLiveMenuBarButtonName.toggleCameraButton,
                  ZegoLiveMenuBarButtonName.toggleMicrophoneButton,
                  ZegoLiveMenuBarButtonName.switchCameraFacingButton,
                  ZegoLiveMenuBarButtonName.leaveButton,
                  ZegoLiveMenuBarButtonName.endButton,
                  ZegoLiveMenuBarButtonName.switchAudioOutputButton
                ]
              : const [],
          useEndLiveStreamingButton: true,
          useVideoViewAspectFill: true,
          onEndOrLiveStreaming: () async {
            // close live streaming if you is host
            bool isCreator =
                meetingProv.selectedMeeting!.creatorId!.userId == userProv.user!.userId;
            if (isCreator) {
              try {
                var response = await MeetingsApiRequest.endMeeting(
                  meetingId: meetingProv.selectedMeeting!.id,
                  token: userProv.user!.token,
                );
                if (!response!.hasError) {
                  meetingProv.setSelectMeeting(response.data);
                  meetingProv.updateMeeting(response.data);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  return;
                }
              } catch (e) {
                print(e);
              }
            }
            Navigator.of(context).pop();
            return;
          },

          showSoundWavesInAudioMode: true,
          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
            return user != null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          userProv.user!.pic!,
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
