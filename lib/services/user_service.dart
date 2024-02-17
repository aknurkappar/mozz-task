import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:mozz_task/firebase_options.dart';
import 'package:mozz_task/models/user_model.dart';

class UserService {
  static UserService? _instance;

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

  Stream<List<User>> getUsers() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('users');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromFirebase(doc)).toList();
    });
  }

  Future<String?> getCurrentUserId() async {
    try {
      late final String id;
      await FirebaseFirestore.instance
          .collection("users")
          .where('name', isEqualTo: 'Акнур')
          .get()
          .then((QuerySnapshot snapshot) {
        id = snapshot.docs[0].id;
      });
      return id;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
