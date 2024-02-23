import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mozz_task/constants/colors.dart';
import 'package:mozz_task/models/message_mode.dart';
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
  late final TextEditingController _textController;

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
    return Scaffold(
        body: Column(
      children: [
        ChatHeader(chatUser),
        ChatBody(chatUser),
        Column(
          children: [
            const Divider(color: lightGrey),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: lightGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
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
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12.0)),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "Сообщение",
                        hintStyle: const TextStyle(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
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
                              _textController.clear();
                            }))
                  ],
                ))
          ],
        )
      ],
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
                          const Text('В сети',
                              style: TextStyle(
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
            padding: const EdgeInsets.all(20.0),
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
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: "Сообщение",
                    hintStyle: const TextStyle(
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
                          _textController.clear();
                        }))
              ],
            ))
      ],
    );
  }
}

class ChatBody extends StatefulWidget {
  final User chatUser;
  const ChatBody(this.chatUser, {super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late final User chatUser;
  late Stream<List<Message>> _chatMessagesStream;

  @override
  void initState() {
    super.initState();
    chatUser = widget.chatUser;
    _initializeStream();
  }

  void _initializeStream() {
    _chatMessagesStream = MessageService.instance!
        .getChatMessages(secondUserId: widget.chatUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<List<Message>>(
            stream: _chatMessagesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error occured, please, try again');
              }
              if (snapshot.hasData) {
                final List<Message>? messages = snapshot.data;
                return messages != null
                    ? ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          Message message = messages[index];
                          return (chatUser.id == message.senderId)
                              ? SentMessageItem(message)
                              : ReceivedMessageItem(message);
                          // return Container(
                          //   padding: const EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //       color: (chatUser.id == message.senderId)
                          //           ? Colors.white
                          //           : lightGreenGradient,
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(30))),
                          //   child: Text('${message.text} ${message.time}',
                          //       style: const TextStyle(color: Colors.black)),
                          // );
                        },
                      )
                    : const Text('No data');
              } else {
                return const Text('Loading...');
              }
            }));
  }
}

class SentMessageItem extends StatefulWidget {
  final Message message;
  const SentMessageItem(this.message, {super.key});

  @override
  State<SentMessageItem> createState() => _SentMessageItemState();
}

class _SentMessageItemState extends State<SentMessageItem> {
  late final Message message;
  @override
  void initState() {
    message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: lightGreenGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IntrinsicWidth(
              // margin: const EdgeInsets.only(left: 20.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                Text('${message.text}   ${message.time} ',
                    style: const TextStyle(color: Colors.black)),
                Container(
                    height: 14,
                    width: 14,
                    margin: const EdgeInsets.only(bottom: 2.0),
                    child:
                        const ImageIcon(AssetImage("assets/icons/Read.png"))),
              ])),
        ));
  }
}

class ReceivedMessageItem extends StatefulWidget {
  final Message message;
  const ReceivedMessageItem(this.message, {super.key});

  @override
  State<ReceivedMessageItem> createState() => _ReceivedMessageItemState();
}

class _ReceivedMessageItemState extends State<ReceivedMessageItem> {
  late final Message message;

  @override
  void initState() {
    message = widget.message;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('${message.text}   ${message.time} ',
              style: const TextStyle(color: Colors.black)),
        ));
  }
}
