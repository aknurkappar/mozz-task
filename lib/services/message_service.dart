import 'dart:async';
import 'dart:developer';
import 'package:mozz_task/models/message_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozz_task/services/user_service.dart';
import 'package:rxdart/rxdart.dart';

class MessageService {
  static MessageService? _instance;

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

  // Stream<List<Message>> getReceivedChatMessages1(
  //     {required String secondUserId}) async* {
  //   String? currentUserId = await UserService.instance?.getCurrentUserId();
  //   yield* FirebaseFirestore.instance
  //       .collection('messages')
  //       .where('receiverId', isEqualTo: currentUserId)
  //       .where('senderId', isEqualTo: secondUserId)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());
  // }

  // Stream<List<Message>> getChatMessages(
  //     {required String secondUserId}) async* {
  //   String? currentUserId = await UserService.instance?.getCurrentUserId();
  //   print("here");
  //   yield* FirebaseFirestore.instance
  //       .collection('messages')
  //       .where('senderId', isEqualTo: currentUserId)
  //       .where('receiverId', isEqualTo: secondUserId)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());
  // }

  Stream<List<Message>> getReceivedChatMessages({
    required String? currentUserId,
    required String? secondUserId,
  }) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: secondUserId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());
  }

  Stream<List<Message>> getChatMessages({required String secondUserId}) async* {
    String? currentUserId = await UserService.instance?.getCurrentUserId();
    final chatIds = [
      '${currentUserId}_$secondUserId',
      '${secondUserId}_$currentUserId'
    ];
    yield* FirebaseFirestore.instance
        .collection('messages')
        .where('chatId', whereIn: chatIds)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());
  }

  Future<void> sendMessage(
      {required String secondUserId,
      required String text,
      required String imageURl}) async {
    // creating new document in collection 'messages'
    String? currentUserId;
    await UserService.instance?.getCurrentUserId().then((value) {
      currentUserId = value;
    });

    final chatId = '${currentUserId}_$secondUserId';
    await FirebaseFirestore.instance.collection('messages').add({
      'chatId': chatId,
      'senderId': currentUserId,
      'receiverId': secondUserId,
      'text': text,
      'imageURl': imageURl,
      'time': '${DateTime.now().hour}:${DateTime.now().minute}',
      'date':
          '${DateTime.now().month}, ${DateTime.now().day}, ${DateTime.now().year}',
      'createdAt': '${DateTime.now()}'
    });
  }
}
