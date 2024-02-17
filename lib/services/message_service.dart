import 'dart:developer';

import 'package:mozz_task/models/message_mode.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  static MessageService? _instance;

  final List<Message> chatUsers = [];

  static MessageService? get instance {
    if (_instance == null) {
      _instance = MessageService._();
      return _instance;
    }
    return _instance;
  }

  MessageService._();

  initialize() {
    _instance = MessageService._();
  }

  Future<void> sendMessage() async {
    await FirebaseFirestore.instance.collection('messages').get();
  }

  Stream<List<Message>> getAllMessages() {
    return FirebaseFirestore.instance.collection("messages").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

  Stream<List<Message>>? getChatMessages(
      {required String currentUserId, required String secondUserId}) {
    try {
      FirebaseFirestore.instance
          .collection("messages")
          .where('senderId', isEqualTo: currentUserId)
          .get()
          .then((QuerySnapshot snapshot) {
        List<Message> messages = snapshot.docs
            .map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        return messages;
      });
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }
}
