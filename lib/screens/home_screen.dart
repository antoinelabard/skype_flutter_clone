import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/enum/user_state.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/resources/auth_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/repository/log_repository.dart';
import 'package:skype_flutter_clone/screens/call_screens/pickup/pickup_layout.dart';
import 'package:skype_flutter_clone/screens/page_views/chat_list_screen.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/widgets/logs/log_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late PageController pageController;
  int _page = 0;
  late UserProvider userProvider;
  var _authMethods = AuthMethods();

  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();
      if (userProvider.getUser() != null) {
        _authMethods.setUserState(
            userId: userProvider.getUser().uid, userState: UserState.Online);
      }
      LogRepository.init(isHive: false, dbName: userProvider.getUser().uid);
    });

    pageController = PageController(initialPage: 0);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    String currentUserId =
        (userProvider.getUser() != null) ? userProvider.getUser().uid : "";

    switch (state) {
      case AppLifecycleState.paused:
        _authMethods.setUserState(
            userId: currentUserId, userState: UserState.Waiting);
        return;
      case AppLifecycleState.resumed:
        _authMethods.setUserState(
            userId: currentUserId, userState: UserState.Online);
        return;
      case AppLifecycleState.inactive:
        _authMethods.setUserState(
            userId: currentUserId, userState: UserState.Offline);
        return;
      case AppLifecycleState.detached:
        _authMethods.setUserState(
            userId: currentUserId, userState: UserState.Offline);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
          backgroundColor: Constants.blackColor,
          body: PageView(
            children: [
              ChatListScreen(),
              LogScreen(),
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
