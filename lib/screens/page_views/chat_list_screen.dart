import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/resources/auth_methods.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/utils/utils.dart';
import 'package:skype_flutter_clone/widgets/chat_list_container.dart';
import 'package:skype_flutter_clone/widgets/custom_appbar.dart';
import 'package:skype_flutter_clone/widgets/new_chat_button.dart';
import 'package:skype_flutter_clone/widgets/user_circle.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}


class _ChatListScreenState extends State<ChatListScreen> {
  late String currentUserId;
  late String initials;
  final _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName!);
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Constants.blackColor,
        appBar: customAppbar(context),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(
          currentUserId: currentUserId,
        ),
      );

  CustomAppbar customAppbar(BuildContext context) => CustomAppbar(
        title: UserCircle(text: initials),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
      );
}
