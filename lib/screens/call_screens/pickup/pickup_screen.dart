import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/call.dart';
import 'package:skype_flutter_clone/resources/call_methods.dart';
import 'package:skype_flutter_clone/screens/call_screens/call_screen.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  var callMethods = Callmethods();

  PickupScreen({Key? key, required this.call}) : super(key: key);

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
            Image.network(
              call.callerPic,
              height: 150,
              width: 150,
            ),
            Text(
              call.callerName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async =>
                        await callMethods.endCall(call: call),
                    icon: Icon(Icons.call_end),
                    color: Colors.redAccent),
                SizedBox(width: 25),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallScreen(call: call))),
                    icon: Icon(Icons.call))
              ],
            )
          ],
        ),
      ),
    );
  }
}
