import 'dart:developer';

import 'package:mozz_task/models/message_mode.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozz_task/models/user_model.dart';
import 'package:mozz_task/services/user_service.dart';

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

  // Stream<List<Message>> getChatMessages({required String secondUserId}) {
  //   late final List<Message> messages;
  //   getChatMessagesFromFirebase(secondUserId: secondUserId)
  //       .then((value) => messages = value);
  //   return messages;
  // }

  Stream<List<Message>> getChatMessagesFromFirebase(
      {required String secondUserId}) {
    String? currentUserId;
    UserService.instance
        ?.getCurrentUserId()
        .then((value) => currentUserId = value);

    List<Message> allChatMessages = [];

    List<QueryDocumentSnapshot> allMessagesSnapshot = [];
    late final QuerySnapshot<Map<String, dynamic>> senderSnapshot;
    late final QuerySnapshot<Map<String, dynamic>> receiverSnapshot;
    FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: currentUserId)
        .where('receiverId', isEqualTo: secondUserId)
        .get()
        .then((value) => senderSnapshot = value);
    FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: secondUserId)
        .get()
        .then((value) => receiverSnapshot = value);
    allMessagesSnapshot.addAll(senderSnapshot.docs);
    allMessagesSnapshot.addAll(receiverSnapshot.docs);

    allChatMessages =
        allMessagesSnapshot.map((doc) => Message.fromFirebase(doc)).toList();
    print(allChatMessages.length);

    return allChatMessages;
  }

  Future<void> sendMessage(
      {required String secondUserId,
      required String text,
      required String imageURl}) async {
    String? currentUserId;
    await UserService.instance?.getCurrentUserId().then((value) {
      currentUserId = value;
    });
    await FirebaseFirestore.instance.collection('messages').add({
      'senderId': currentUserId,
      'receiverId': secondUserId,
      'text': text,
      'imageURl': imageURl,
      'time': DateTime.now(),
      'seen': false
    });
  }

  Stream<List<Message>> getAllMessages() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('users');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList();
    });
  }

  // Stream<List<Message>>? getChatMessages(
  //     {required String currentUserId, required String secondUserId}) {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection("messages")
  //         .where('senderId', isEqualTo: currentUserId)
  //         .get()
  //         .then((QuerySnapshot snapshot) {
  //       List<Message> messages = snapshot.docs
  //           .map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
  //           .toList();
  //       return messages;
  //     });
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  //   return null;
  // }
}
