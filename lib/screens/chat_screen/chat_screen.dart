import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/widgets/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  final LocalUser receiver;

  const ChatScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: customAppbar(context),
    );
  }

  customAppbar(BuildContext context) => CustomAppbar(
      title: Text(widget.receiver.name!),
      actions: [
        IconButton(
          icon: Icon(Icons.video_call),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.phone),
          onPressed: () {},
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false);
}
