import 'package:flutter/material.dart';
import 'package:mozz_task/constants/colors.dart';
import 'package:mozz_task/models/user_model.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final users = [
    const User(id: 1, name: "Акнур", surname: 'Каппарова', online: true)
  ];

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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
        Container(
          height: 50,
          width: 50,
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
            borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
          child: const Text(
            "AK", 
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold,
              fontSize: 20),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Виктор Власов",
              style: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
                fontSize: 17)
              ),
            Row(children: [
              Text("Вы: "),
              Text(
                "Уже сделал?",
                style: const TextStyle(
                color: darkGrey,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w300,
                fontSize: 14),
            )])
            ],)
          ],
        ),
        Text("Вчера",
        style: const TextStyle(
              color: darkGrey,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w300,
              fontSize: 14),
        )])
    );
  }
}
