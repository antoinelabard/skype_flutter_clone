import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/constants.dart';
import 'package:skype_flutter_clone/screens/call_screens/pickup/pickup_layout.dart';
import 'package:skype_flutter_clone/widgets/logs/widgets/log_list_container.dart';
import 'package:skype_flutter_clone/widgets/skype_appbar.dart';

import 'widgets/floating_column.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        appBar: SkypeAppbar(
          title: "Calls",
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
          ],
        ),
        backgroundColor: Constants.blackColor,
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
        floatingActionButton: FloatingColumn(),
      ),
    );
  }
}
