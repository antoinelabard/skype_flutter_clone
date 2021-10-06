import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/interface/log_interface.dart';

class SqliteMethods implements LogInterface {
  @override
  addLogs(Log log) {
    print("Data added to SQlite database.");
    // TODO: implement addLogs
    throw UnimplementedError();
  }

  @override
  close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  deleteLogs(int logId) {
    // TODO: implement deleteLogs
    throw UnimplementedError();
  }

  @override
  Future<List<Log>> getLogs() {
    // TODO: implement getLogs
    throw UnimplementedError();
  }

  @override
  init() {
    print("SQlite database initialised.");
    // TODO: implement init
    throw UnimplementedError();
  }
}