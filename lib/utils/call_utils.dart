import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/resources/call_methods.dart';
import 'package:skype_flutter_clone/screens/call_screens/call_screen.dart';

class CallUtils {
  static dial({required LocalUser from, required LocalUser to, context}) async {
    var callMethods = CallMethods();
    var call = Call(
        callerId: from.uid!,
        callerName: from.name!,
        callerPic: from.profilePhoto!,
        receiverId: to.uid!,
        receiverName: to.name!,
        receiverPic: to.profilePhoto!,
        channelId: Random().nextInt(100).toString());

    call.hasDialed = await callMethods.makeCall(call: call);

    if (call.hasDialed) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CallScreen(call: call)));
    }
  }
}
