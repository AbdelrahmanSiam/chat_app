import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/Widgets/chat_bubble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/register%20-cubits/cubit/chat_cubit.dart';
import 'package:chat_app/helper/scroll_to_end.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static String pageId = "ChatScreen";
  List<MessageModel> messageList = [];
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
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
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatSucsessState) {
            messageList = state.message;
          }
        },
        builder: (context, state) {
          bool isLoading = state is MessageSendingState;
          return Column(
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
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: value, email: email);
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
                    suffixIcon:isLoading? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                ): Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
