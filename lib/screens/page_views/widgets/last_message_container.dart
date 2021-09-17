import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/message.dart';

class LastMessageContainer extends StatelessWidget {
  const LastMessageContainer({Key? key, this.stream}) : super(key: key);

  final stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      if (snapshot.hasData) {
        var docList = snapshot.data!.docs;
        if (docList.isNotEmpty) {
          var message = Message.fromMap(
              docList.last.data() as Map<String, dynamic>);
          return SizedBox(width: MediaQuery
              .of(context)
              .size
              .width * .6,
            child: Text(
              message.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontSize: 14
              ),
            ),);
        }
        return Text(
            "No message", style: TextStyle(color: Colors.grey, fontSize: 14));
      }
      return Text("..", style: TextStyle(color: Colors.grey, fontSize: 14));
    });
  }
}
