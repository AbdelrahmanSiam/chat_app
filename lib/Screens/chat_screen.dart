import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/Widgets/chat_bubble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/scroll_to_end.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String pageId = "ChatScreen";
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(createdAt, descending: true)
          .snapshots(), // to get all the collection docs if i want only one doc and i know its id i cans use <DocumentSnapshot> and use messages.doc(id).get()    [if you use FutureBuilder],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          // scroll after build
          WidgetsBinding.instance
              .addPostFrameCallback((_) => scrollToEnd(scrollController));
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
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(
                              message: messageList[index],
                            )
                          : OtherChatBubble(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        kMessage: value,
                        createdAt: DateTime.now(),
                        messageId: email
                      });
                      controller.clear();
                    },
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
        } else {
          return Scaffold(body: Center(child: Text("Loading...")));
        }
      },
    );
  }
}
