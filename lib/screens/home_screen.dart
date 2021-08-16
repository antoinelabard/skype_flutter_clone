import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/screens/call_screens/pickup/pickup_layout.dart';
import 'package:skype_flutter_clone/screens/page_views/chat_screen_list.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int _page = 0;
  late UserProvider userProvider;

  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });

    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
          backgroundColor: Constants.blackColor,
          body: PageView(
            children: [
              Container(
                child: ChatScreenList(),
              ),
              Center(
                  child:
                      Text("Calls log", style: TextStyle(color: Colors.white))),
              Center(
                  child:
                      Text("Contacts", style: TextStyle(color: Colors.white))),
            ],
            scrollDirection: Axis.horizontal,
            controller: pageController,
            onPageChanged: onPageChanged,
            physics: NeverScrollableScrollPhysics(),
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
                        label: "Calls log",
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.contact_phone,
                            color: _page == 2
                                ? Constants.lightBlueColor
                                : Constants.greyColor,
                          ),
                          label: "Contacts"),
                    ],
                    onTap: navigationTapped,
                    currentIndex: _page,
                  )))),
    );
  }

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  navigationTapped(int page) {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   if (pageController.hasClients) {
    pageController.jumpToPage(page);
    //   }
    // });
  }
}
