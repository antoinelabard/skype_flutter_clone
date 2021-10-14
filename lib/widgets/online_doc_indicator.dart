import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/enum/user_state.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/repositories/firebase/auth_methods.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

class OnlineDotIndicator extends StatelessWidget {
  OnlineDotIndicator({Key? key, required this.uid}) : super(key: key);

  final String uid;
  final _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    getColor(int? state) {
      if (state == null) {
        return Colors.orange;
      }
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    return Align(
      alignment: Alignment.topRight,
      child: StreamBuilder<DocumentSnapshot>(
          stream: _authMethods.getUserStream(uid: uid),
          builder: (context, snapshot) {
            LocalUser? user;
            if (snapshot.hasData) {
              user = LocalUser.fromMap(
                  snapshot.data?.data() as Map<String, dynamic>);
            }
            return Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(right: 5, top: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(user == null ? null : user.state)),
            );
          }),
    );
  }
}
