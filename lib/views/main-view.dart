import 'package:flutter/material.dart';
import 'package:mozz_task/constants/colors.dart';
import 'package:mozz_task/models/user_model.dart';
import 'package:mozz_task/views/chat_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Header(),
          SizedBox(height: 16),
          Divider(color: lightGrey),
          ChatList()
        ],
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Чаты",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                fontFamily: 'Gilroy',
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: lightGrey),
                child: Row(
                  children: [
                    const ImageIcon(AssetImage("assets/icons/search_icon.png"),
                        color: grey, size: 30),
                    Expanded(
                        child: TextField(
                      controller: _searchTextController,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          // Border color when TextField is focused
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Поиск",
                        hintStyle: TextStyle(
                            color: grey,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ))
                  ],
                )),
          ],
        ));
  }
}

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chatUsers = [
    const User(id: 2, name: "Виктор", surname: 'Власов', online: true),
    const User(id: 1, name: "Акнур", surname: 'Каппарова', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var chatUser in chatUsers)
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent), // No background color
            shadowColor: MaterialStateProperty.all(Colors.transparent), // No shadow
            elevation: MaterialStateProperty.all(0), // No elevation
            padding: MaterialStateProperty.all(EdgeInsets.zero), // No padding
          ),
          onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatView(chatUser)),
              );
          },
          child: ChatListItem(chatUser),
        )
    ]);
  }
}

class ChatListItem extends StatefulWidget {
  final User chatUser;
  const ChatListItem(this.chatUser, {super.key});

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late final User chatUser;

  @override
  void initState() {
    chatUser = widget.chatUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                        Row(children: [
                          Text("Вы: "),
                          Text(
                            "Уже сделал?",
                            style: const TextStyle(
                                color: darkGrey,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          )
                        ])
                      ],
                    )
                  ],
                ),
                Text(
                  "Вчера",
                  style: const TextStyle(
                      color: darkGrey,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w300,
                      fontSize: 14),
                )
              ]),
          const Divider(color: lightGrey)
        ]));
  }
}
