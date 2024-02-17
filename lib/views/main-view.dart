import 'package:flutter/material.dart';
import 'package:mozz_task/constants/colors.dart';

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
      body: Header(),
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
        padding: const EdgeInsets.only(top: 34, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Chats",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy',
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: lightGray),
                child: Row(
                  children: [
                    const ImageIcon(AssetImage("assets/icons/search_icon.png"),
                        color: darkGray, size: 30),
                    Expanded(
                        child: TextField(
                      controller: _searchTextController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          // Border color when TextField is focused
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                        hintText: "Search",
                        hintStyle: const TextStyle(color: darkGray),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Gilroy',
                      ),
                    ))
                  ],
                ))
          ],
        ));
  }
}
