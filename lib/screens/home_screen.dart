import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int _page = 0;
  int _labelFontSize = 10;

  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.blackColor,
        body: PageView(
          children: [
            Center(child: Text("Chats")),
            Center(child: Text("Calls log")),
            Center(child: Text("Contacts")),
          ],
          controller: pageController,
          onPageChanged: onPageChanged(0),
        ),
        bottomNavigationBar: Container(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CupertinoTabBar(
                  backgroundColor: Constants.blackColor,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.chat,
                          color: _page == 0
                              ? Constants.lightBlueColor
                              : Constants.greyColor,
                        ),
                        label: "Chats"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.phone,
                          color: _page == 1
                              ? Constants.lightBlueColor
                              : Constants.greyColor,
                        ),
                        label: "Calls log"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.contact_phone,
                          color: _page == 2
                              ? Constants.lightBlueColor
                              : Constants.greyColor,
                        ),
                        label: "Contacts"),
                  ],
                  onTap: navigationTapped(_page),
                  currentIndex: _page,
                ))));
  }

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  navigationTapped(int page) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (pageController.hasClients) {
        pageController.jumpToPage(page);
      }
    });
  }
}
