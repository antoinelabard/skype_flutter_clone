import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/repositories/firebase/call_methods.dart';
import 'package:skype_flutter_clone/repositories/local/log_repository.dart';
import 'package:skype_flutter_clone/screens/call_screens/call_screen.dart';
import 'package:skype_flutter_clone/utils/permissions.dart';
import 'package:skype_flutter_clone/widgets/cached_image.dart';

/// PickupScreen: Provides a user interface for the user to manage a call
/// session.
class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({Key? key, required this.call}) : super(key: key);

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  var callMethods = CallMethods();

  addToLocalStorage({required String callStatus}) {
    Log log = Log(
        callerName: widget.call.callerName,
        callerPic: widget.call.callerPic,
        receiverName: widget.call.receiverName,
        receiverPic: widget.call.receiverPic,
        timestamp: DateTime.now().toString(),
        callStatus: callStatus);

    LogRepository.addLogs(log);
  }

  var isCallMissed = true;

  @override
  void dispose() {
    super.dispose();
    if (isCallMissed) {
      addToLocalStorage(callStatus: CALL_STATUS_MISSED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Incoming...",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            CachedImage(widget.call.callerPic, isRound: true, radius: 180),
            Text(
              widget.call.callerName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      isCallMissed = false;
                      addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                      await callMethods.endCall(call: widget.call);
                    },
                    icon: Icon(Icons.call_end),
                    color: Colors.redAccent),
                SizedBox(width: 25),
                IconButton(
                    onPressed: () async {
                      isCallMissed = false;
                      addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CallScreen(call: widget.call)))
                          : {};
                    },
                    icon: Icon(Icons.call))
              ],
            )
          ],
        ),
      ),
    );
  }
}
