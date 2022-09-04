import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/Data/chats.dart';
import 'package:pp_stream_mobile_app/providers/user.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/chats/message_bubble.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    return ListView.builder(
      itemCount: getAllChatMessages().length,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext ctx, int index) {
        return MessageBubble(
          message: getAllChatMessages()[index].message,
          isMe: getAllChatMessages()[index].sender == userProv.user?.name
              ? true
              : false,
        );
      },
    );
  }
}
