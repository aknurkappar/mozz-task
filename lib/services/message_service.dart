import 'dart:async';
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

  Stream<List<Message>> getChatMessages({required String secondUserId}) async* {
    // get list of messages current user or another user in chat send/recieved from each other
    String? currentUserId = await UserService.instance?.getCurrentUserId();

    var receivedMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: secondUserId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());

    var sentMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: secondUserId)
        .where('senderId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirebase(doc)).toList());

    await for (var combined in Rx.combineLatest2(
        receivedMessagesStream,
        sentMessagesStream,
        (List<Message> received, List<Message> sent) => received
          ..addAll(sent)
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt)))) {
      yield combined;
    }
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
    await FirebaseFirestore.instance.collection('messages').add({
      'senderId': currentUserId,
      'receiverId': secondUserId,
      'text': text,
      'imageURl': imageURl,
      'time': '${DateTime.now().hour}:${DateTime.now().minute}',
      'date':
          '${DateTime.now().month}, ${DateTime.now().day}, ${DateTime.now().year}',
      'seen': false,
      'createdAt': FieldValue.serverTimestamp()
    });
  }
}
