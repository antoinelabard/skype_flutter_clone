import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/call_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/repository/log_repository.dart';
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

    var log = Log(
        callerName: from.name!,
        callerPic: from.profilePhoto!,
        callStatus: CALL_STATUS_DIALLED,
        receiverName: to.name!,
        receiverPic: to.profilePhoto!,
        timestamp: DateTime.now().toString());
    var callMade = await callMethods.makeCall(call: call);

    call.hasDialed = true;

    if (callMade) {
      LogRepository.addLogs(log);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CallScreen(call: call)));
    }
  }
}
