import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/repository/log_repository.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

