import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/resources/call_methods.dart';
import 'package:skype_flutter_clone/screens/call_screens/pickup/pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final callMethods = CallMethods();

  PickupLayout({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return (userProvider.getUser() != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser().uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var call =
                    Call.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                if (!call.hasDialed) return PickupScreen(call: call);
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
