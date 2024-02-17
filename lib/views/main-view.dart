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
                    color: lightGray),
                child: Row(
                
                 children: [
                    const ImageIcon(AssetImage("assets/icons/search_icon.png"),
                        color: darkGray, size: 30),
                    Expanded(
                      child: TextField(
                      controller: _searchTextController,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                                 BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                 BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: Colors.transparent),
                          // Border color when TextField is focused
                        ),
                        contentPadding:  EdgeInsets.all(10.0),
                        hintText: "Поиск",
                        hintStyle:  TextStyle(
                          color: darkGray,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
  
                    ))
                  ],
                ))
          ],
        ));
  }
}
