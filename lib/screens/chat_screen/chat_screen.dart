import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/widgets/custom_appbar.dart';
import 'package:skype_flutter_clone/widgets/modal_tile.dart';

class ChatScreen extends StatefulWidget {
  final LocalUser receiver;

  const ChatScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  bool isWriting = false;

  late LocalUser sender;
  var _repository = FireBaseRepository();
  late String _currentUserId;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      _currentUserId = user.uid;
      setState(() {
        sender = LocalUser(
            uid: user.uid, name: user.displayName, profilePhoto: user.photoURL);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: customAppbar(context),
      body: Column(
        children: [
          Flexible(child: messageList()),
          chatControls(),
        ],
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
            GestureDetector(
              onTap: () => addMediaModal(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: Constants.fabGradient, shape: BoxShape.circle),
                child: Icon(Icons.add),
              ),
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
                      onPressed: () => sendMessage(),
                    ),
                  )
                : Container()
          ],
        ),
      );

  messageList() => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .doc(_currentUserId)
          .collection(widget.receiver.uid!)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) =>
                chatMessageItem(snapshot.data.docs[index]));
      });

  chatMessageItem() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Container(
          child: receiverlayout(),
        ),
      );

  senderLayout() {
    var messageRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Constants.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          bottomLeft: messageRadius,
          topRight: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  receiverlayout() {
    var messageRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Constants.receiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          bottomLeft: messageRadius,
          topRight: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  addMediaModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        builder: (context) => Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () => Navigator.maybePop(context),
                          child: Icon(Icons.close)),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Content and tools",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                ),
                Flexible(
                    child: ListView(
                  children: [
                    ModalTile(
                        title: "Media",
                        subTitle: "Share photos and videos",
                        iconData: Icons.image),
                    ModalTile(
                        title: "File",
                        subTitle: "Share a file",
                        iconData: Icons.image),
                    ModalTile(
                        title: "Contact",
                        subTitle: "Share contact",
                        iconData: Icons.image),
                    ModalTile(
                        title: "Location",
                        subTitle: "Share a location",
                        iconData: Icons.image),
                    ModalTile(
                        title: "Schedule Call",
                        subTitle: "Arrange a call and get reminders",
                        iconData: Icons.image),
                    ModalTile(
                        title: "Create poll",
                        subTitle: "Share polls",
                        iconData: Icons.image),
                  ],
                ))
              ],
            ));
  }

  sendMessage() {
    var text = _textEditingController.text;
    var message = Message(
        receiverId: widget.receiver.uid!,
        senderId: sender.uid!,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');

    setState(() {
      isWriting = false;
    });

    _repository.addMessageToDb(message, sender, widget.receiver);
  }
}
