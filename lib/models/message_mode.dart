import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final DateTime time;
  final String text;
  final String imageURL;
  final bool seen;

  const Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.text,
      required this.imageURL,
      required this.seen
      });

    factory Message.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      time: data['dateTime'] ?? '',
      text: data['text'] ?? '',
      imageURL: data['imageURL'] ?? '',
      seen: data['seen'] ?? false, 

    );
  }
}
