import 'package:cloud_firestore/cloud_firestore.dart';
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
}
