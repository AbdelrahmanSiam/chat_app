part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}

final class ChatSucsessState extends ChatState {
  List<MessageModel> message;

  ChatSucsessState({required this.message});
}

final class MessageSendingState extends ChatState {}
