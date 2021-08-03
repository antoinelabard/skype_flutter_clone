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
  TextEditingController _textEditingController = TextEditingController();
  bool isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: customAppbar(context),
      body: Column(
        children: [chatControls()],
      ),
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

  chatControls() => Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(child: messageList()),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: Constants.fabGradient, shape: BoxShape.circle),
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: TextField(
              controller: _textEditingController,
              style: TextStyle(color: Colors.white),
              onChanged: (val) {
                if (val.length > 0 && val.trim() != "")
                  setState(() {
                    isWriting = true;
                  });
                else
                  setState(() {
                    isWriting = false;
                  });
              },
              decoration: InputDecoration(
                  hintText: "Message...",
                  hintStyle: TextStyle(
                    color: Constants.greyColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide.none),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  filled: true,
                  fillColor: Constants.separatorColor,
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.face),
                  )),
            )),
            isWriting
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.record_voice_over),
                  ),
            isWriting ? Container() : Icon(Icons.camera_alt),
            isWriting
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        gradient: Constants.fabGradient,
                        shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        // size: 15,
                      ),
                      onPressed: () {},
                    ),
                  )
                : Container()
          ],
        ),
      );

  messageList() {}
}
