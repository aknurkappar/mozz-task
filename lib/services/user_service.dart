import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:mozz_task/models/user_model.dart';

class UserService{
  static UserService? _instance;

  final List<User> chatUsers = [
    const User(id: 2, name: "Виктор", surname: 'Власов', online: true),
    const User(id: 1, name: "Акнур", surname: 'Каппарова', online: true),
  ];

  static UserService? get instance {
    if (_instance == null) {
      _instance = UserService._();
      return _instance;
    }
    return _instance;
  }

  UserService._();

  initialize() {
    _instance = UserService._();
  }

  static Stream<List<User>> getUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}