import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        child: Text(
          "Hello , i am abdo basha.",
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}
