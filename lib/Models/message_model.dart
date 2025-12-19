import 'package:chat_app/constants.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(json) {
    return MessageModel(json[kMessage],json[messageId]);
  }
}
