import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/repository/log_repository.dart';
import 'package:skype_flutter_clone/screens/call_screens/pickup/pickup_layout.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/widgets/skype_appbar.dart';

import 'floating_column.dart';

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
        body: Center(
          child: TextButton(
            child: Text("Click me"),
            onPressed: () {
              LogRepository.init(isHive: true);
              LogRepository.addLogs(Log());
            },
          ),
        ),
        floatingActionButton: FloatingColumn(),
      ),
    );
  }
}
