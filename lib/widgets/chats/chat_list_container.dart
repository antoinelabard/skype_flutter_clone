import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/constants.dart';

import '../custom_tile.dart';

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  const ChatListContainer({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: 2,
          itemBuilder: (context, index) {
            return CustomTile(
              mini: false,
              onTap: () {},
              subtitle: Text(
                "hello",
                style: TextStyle(color: Constants.greyColor, fontSize: 14),
              ),
              leading: Container(
                constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
                child: Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/a/AATXAJz_Sh-qOWbzw88o4tekKLG1grqNQQJ_W9z36cU=s96-c"),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.onlineDotColor,
                            border: Border.all(
                                color: Constants.blackColor, width: 2)),
                      ),
                    )
                  ],
                ),
              ),
              title: Text(
                "Antoine Labard",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Arial", fontSize: 19),
              ),
            );
          }),
    );
  }
}
