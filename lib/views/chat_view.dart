import 'package:flutter/material.dart';
import 'package:mozz_task/models/user_model.dart';

class ChatView extends StatefulWidget {
  final User chatUser;
  const ChatView(this.chatUser, {super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final User chatUser;

  @override
  void initState() {
    chatUser = widget.chatUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Chat ${chatUser.name}"));
  }
}
