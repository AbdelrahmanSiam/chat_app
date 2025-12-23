import 'package:bloc/bloc.dart';
import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String message, required String email}) {
    emit(MessageSendingState());
    messages
        .add({kMessage: message, createdAt: DateTime.now(), messageId: email});
  }

  void fetchMessages() {
    messages.orderBy(createdAt, descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSucsessState(message: messageList));
    });
  }
}
