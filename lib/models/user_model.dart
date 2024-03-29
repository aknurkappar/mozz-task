import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final bool online;
  final String avatar;

  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.online,
      required this.avatar
      });

  factory User.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
      online: data['online'],
      avatar: data['avatar'] ?? '',
    );
  }
}
