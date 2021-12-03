
import 'dart:convert';

class Message {
  final String sender;
  final String receiver;
  final String messageContent;
  final String createdAt;

  Message({
    required this.sender,
    required this.receiver,
    required this.messageContent,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      receiver: json['receiver'],
      messageContent: json['msg_content'] ?? "",
      createdAt: json['created_at']);
  }
}  
  
  List<Message> parseMessage (String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }


