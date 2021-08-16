import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({Key? key, required this.call}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var callMethods = Callmethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Call accepted"),
            MaterialButton(
                color: Colors.red,
                child: Icon(Icons.call_end, color: Colors.white),
                onPressed: () async {
                  await callMethods.endCall(call: widget.call);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
