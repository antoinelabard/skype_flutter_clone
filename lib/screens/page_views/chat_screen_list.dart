import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/utils/utils.dart';
import 'package:skype_flutter_clone/widgets/custom_appbar.dart';
import 'package:skype_flutter_clone/widgets/new_chat_button.dart';
import 'package:skype_flutter_clone/widgets/user_circle.dart';

class ChatScreenList extends StatefulWidget {
  const ChatScreenList({Key? key}) : super(key: key);

  @override
  _ChatScreenListState createState() => _ChatScreenListState();
}

final FireBaseRepository _repository = FireBaseRepository();

class _ChatScreenListState extends State<ChatScreenList> {
  late String currentUserId;
  late String initials;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
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
      );

  CustomAppbar customAppbar(BuildContext context) => CustomAppbar(
        title: UserCircle(text: initials),
        actions: [
          IconButton(
              onPressed: () {},
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
