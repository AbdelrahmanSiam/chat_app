import 'package:chat_app/Widgets/chat_bubble.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static String pageId = "ChatScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/images.jpeg",
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Chat",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            //using expanded widget to make listview takes the available height of the column where is the screen height now if you want to ensure give the column smaller height and check it
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ChatBubble();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor),
                ),
                suffixIcon: Icon(
                  Icons.send,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
