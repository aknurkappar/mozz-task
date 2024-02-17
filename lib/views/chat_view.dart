import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mozz_task/constants/colors.dart';
import 'package:mozz_task/models/user_model.dart';
import 'package:mozz_task/services/message_service.dart';

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
    return Scaffold(
        body: Column(
      children: [ChatHeader(chatUser), ChatBody(), MessageInputWidget(chatUser)],
    ));
  }
}

class ChatHeader extends StatefulWidget {
  final User chatUser;
  const ChatHeader(this.chatUser, {super.key});

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  late final User chatUser;

  @override
  void initState() {
    chatUser = widget.chatUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                              child: Image.asset(
                                  'assets/icons/arrow_left_icon.png',
                                  height: 30,
                                  width: 30)),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                darkGreenGradient,
                                lightGreenGradient,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Text(
                          '${chatUser.name[0]}${chatUser.surname[0]}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${chatUser.name} ${chatUser.surname}',
                              style: const TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Text('В сети',
                              style: const TextStyle(
                                  color: darkGrey,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14))
                        ],
                      )
                    ],
                  )
                ]),
          ])),
      const Divider(color: lightGrey)
    ]);
  }
}

class MessageInputWidget extends StatefulWidget {
  final User chatUser;
  const MessageInputWidget(this.chatUser, {super.key});

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  late final TextEditingController _textController;
  late final User chatUser;

  @override
  void initState() {
    chatUser = widget.chatUser;
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: lightGrey),
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: IconButton(
                        padding: const EdgeInsets.all(10),
                        highlightColor: darkGrey,
                        icon: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            child: Image.asset("assets/icons/attach.png",
                                height: 30, width: 30)),
                        color: Colors.black,
                        onPressed: () {
                          // ...
                        })),
                const SizedBox(width: 16),
                Expanded(
                    child: TextField(
                  controller: _textController,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightGrey,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Сообщение",
                    hintStyle: TextStyle(
                        color: grey,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                )),
                const SizedBox(width: 16),
                Container(
                    decoration: const BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: IconButton(
                        padding: const EdgeInsets.all(10),
                        highlightColor: darkGrey,
                        icon: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            child: Image.asset(
                                "assets/icons/Big_Arrow_right.png",
                                height: 30,
                                width: 30)),
                        color: Colors.black,
                        onPressed: () async {
                          await MessageService.instance?.sendMessage(
                              secondUserId: chatUser.id,
                              text: _textController.text,
                              imageURl: '');
                        }))
              ],
            ))
      ],
    );
  }
}

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(children: [for (int i = 0; i < 100; i++) Text("$i")]));
  }
}
