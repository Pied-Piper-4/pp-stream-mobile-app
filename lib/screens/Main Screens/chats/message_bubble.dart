import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';

class MessageBubble extends StatelessWidget {
  final String? message;
  final bool? isMe;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
              color:  yellowColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: !isMe! ? Radius.circular(0) : Radius.circular(20),
              bottomRight: isMe! ? Radius.circular(0) : Radius.circular(20),
            ),
          ),
          child: Text(
            message!,
            style: TextStyle(
            color: pureWhiteBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
