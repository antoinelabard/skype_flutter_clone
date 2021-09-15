import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/enum/view_state.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';
import 'package:skype_flutter_clone/resources/auth_methods.dart';
import 'package:skype_flutter_clone/resources/chat_methods.dart';
import 'package:skype_flutter_clone/resources/storage_methods.dart';
import 'package:skype_flutter_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/utils/call_utils.dart';
import 'package:skype_flutter_clone/utils/permissions.dart';
import 'package:skype_flutter_clone/utils/utils.dart';
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
  final _storageMethods = StorageMethods();
  final _chatMethods = ChatMethods();
  final _authMethods = AuthMethods();
  late String _currentUserId;
  var _scrollController = ScrollController();
  var showEmojiPicker = false;
  var focusNode = FocusNode();
  late ImageUploadProvider _imageUploadProvider;

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      _currentUserId = user.uid;
      setState(() {
        sender = LocalUser(
            uid: user.uid, name: user.displayName, profilePhoto: user.photoURL);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of(context);

    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: customAppbar(context),
      body: Column(
        children: [
          Flexible(child: messageList()),
          _imageUploadProvider.getViewState == ViewState.LOADING
              ? Container(
                  padding: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: CircularProgressIndicator())
              : Container(),
          chatControls(),
          showEmojiPicker ? Container(child: emojiPicker()) : Container()
        ],
      ),
    );
  }

  customAppbar(BuildContext context) => CustomAppbar(
      title: Text(widget.receiver.name!),
      actions: [
        IconButton(
          icon: Icon(Icons.video_call),
          onPressed: () async =>
              await Permissions.cameraAndMicrophonePermissionsGranted()
                  ? CallUtils.dial(
                      from: sender, to: widget.receiver, context: context)
                  : {},
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
                child: Stack(alignment: Alignment.centerRight, children: [
              TextField(
                focusNode: focusNode,
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
                ),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (!showEmojiPicker) {
                    hideKeyboard();
                    showEmojiContainer();
                  } else {
                    showKeyboard();
                    hideEmojiContainer();
                  }
                },
                icon: Icon(Icons.face),
              )
            ])),
            isWriting
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.record_voice_over),
                  ),
            isWriting
                ? Container()
                : GestureDetector(
                    onTap: () {
                      pickImage(source: ImageSource.camera);
                    },
                    child: Icon(Icons.camera_alt)),
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
          .collection(MESSAGES_COLLECTION)
          .doc(_currentUserId)
          .collection(widget.receiver.uid!)
          .orderBy(TIMESTAMP_FIELD, descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
            controller: _scrollController,
            itemBuilder: (context, index) =>
                chatMessageItem(snapshot.data!.docs[index]));
      });

  chatMessageItem(DocumentSnapshot snapshot) {
    var _message = Message.fromMap(snapshot.data() as Map<String, dynamic>);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: _message.senderId == _currentUserId
            ? senderLayout(_message)
            : receiverlayout(_message),
        alignment: _message.senderId == _currentUserId // 5:09
            ? Alignment.centerRight
            : Alignment.centerLeft,
      ),
    );
  }

  senderLayout(Message message) {
    var messageRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Constants.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          bottomLeft: messageRadius,
          topRight: messageRadius,
        ),
      ),
      child: Padding(padding: EdgeInsets.all(10), child: getMessage(message)),
    );
  }

  receiverlayout(Message message) {
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
        child: getMessage(message),
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
                      iconData: Icons.image,
                      onTap: () => pickImage(source: ImageSource.gallery),
                    ),
                    ModalTile(
                        title: "File",
                        subTitle: "Share a file",
                        iconData: Icons.tab,
                        onTap: () {}),
                    ModalTile(
                        title: "Contact",
                        subTitle: "Share contact",
                        iconData: Icons.contacts,
                        onTap: () {}),
                    ModalTile(
                        title: "Location",
                        subTitle: "Share a location",
                        iconData: Icons.add_location,
                        onTap: () {}),
                    ModalTile(
                        title: "Schedule Call",
                        subTitle: "Arrange a call and get reminders",
                        iconData: Icons.schedule,
                        onTap: () {}),
                    ModalTile(
                        title: "Create poll",
                        subTitle: "Share polls",
                        iconData: Icons.poll,
                        onTap: () {}),
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
        timestamp: Timestamp.now(),
        type: 'text');

    setState(() {
      isWriting = false;
      _textEditingController.text = "";
    });

    _chatMethods.addMessageToDb(message, sender, widget.receiver);
  }

  getMessage(Message message) {
    return message.type != MESSAGE_TYPE_IMAGE
        ? Text(
            message.message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        : message.photoUrl != ""
            ? CachedImage(message.photoUrl)
            : Text("Dead link");
  }

  emojiPicker() => EmojiPicker(
        bgColor: Constants.separatorColor,
        indicatorColor: Constants.blueColor,
        rows: 3,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          setState(() {
            isWriting = true;
          });
          _textEditingController.text =
              _textEditingController.text + emoji.emoji;
        },
      );

  showKeyboard() => focusNode.requestFocus();

  hideKeyboard() => focusNode.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  pickImage({required ImageSource source}) async {
    var selectedImage = await Utils.pickImage(source: source);
    _storageMethods.uploadImage(
        image: selectedImage,
        receiverId: widget.receiver.uid!,
        senderId: _currentUserId,
        imageUploadProvider: _imageUploadProvider);
  }
}
