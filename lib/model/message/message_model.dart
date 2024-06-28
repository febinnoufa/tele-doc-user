import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receverId;
  final String message;
  final Timestamp timestamp;
  final bool newMessage;

  Message({
    required this.newMessage,
    required this.senderId,
    required this.senderEmail,
    required this.receverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'newMessage':newMessage,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receverId': receverId,
      'message': message,
      'timestamp': timestamp
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      newMessage: map['newMessage'],
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receverId: map['receverId'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}
