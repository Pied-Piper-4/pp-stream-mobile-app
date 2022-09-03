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
          width: MediaQuery.of(context).size.width * 0.8,
          
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
          
              color:  Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: !isMe! ? Radius.circular(0) : Radius.circular(20),
              bottomRight: isMe! ? Radius.circular(0) : Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message!,
                style: TextStyle(
                color: pureWhiteBackgroundColor.withOpacity(.7),
                ),
              ),
              Text(
                "12:00",
                style: TextStyle(
                   color: pureWhiteBackgroundColor.withOpacity(.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
