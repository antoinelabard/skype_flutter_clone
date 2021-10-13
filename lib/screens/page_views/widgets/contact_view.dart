import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/models/contact.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/resources/auth_methods.dart';
import 'package:skype_flutter_clone/resources/chat_methods.dart';
import 'package:skype_flutter_clone/screens/chat_screens/chat_screen.dart';
import 'package:skype_flutter_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_flutter_clone/widgets/custom_tile.dart';

import 'last_message_container.dart';
import 'online_doc_indicator.dart';

class ContactView extends StatelessWidget {
  ContactView({Key? key, required this.contact}) : super(key: key);

  final Contact contact;
  final _authMethods = AuthMethods();

  @override
  build(BuildContext context) {
    return FutureBuilder(
        future: _authMethods.getUserDetailsById(contact.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LocalUser user = snapshot.data as LocalUser;
            return ViewLayout(contact: user);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class ViewLayout extends StatelessWidget {
  ViewLayout({Key? key, required this.contact}) : super(key: key);

  final LocalUser contact;
  final _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return CustomTile(
      mini: false,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(receiver: contact)));
      },
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: [
            CachedImage(contact.profilePhoto!, radius: 80, isRound: true),
            OnlineDotIndicator(uid: contact.uid!)
          ],
        ),
      ),
      title: Text(
        (contact.name ?? ".."),
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
          stream: _chatMethods.fetchLastMessageBetween(
              senderId: userProvider.getUser().uid, receiverId: contact.uid!)),
    );
  }
}
