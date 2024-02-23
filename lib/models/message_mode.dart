import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String time;
  final String date;
  final String text;
  final String imageURL;
  final String createdAt;

  const Message(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.date,
      required this.text,
      required this.imageURL,
      required this.createdAt});

  factory Message.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
        id: doc.id,
        chatId: data['chatId'] ?? '',
        senderId: data['senderId'] ?? '',
        receiverId: data['receiverId'] ?? '',
        time: data['time'] ?? '',
        date: data['date'] ?? '',
        text: data['text'] ?? '',
        imageURL: data['imageURL'] ?? '',
        createdAt: data['seen'] ?? '');
  }
}
