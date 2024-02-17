

import 'package:mozz_task/models/message_mode.dart';

class UserService{
  static UserService? _instance;

  final List<Message> chatUsers = [];

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

  sendMessage(){
    
  }
}