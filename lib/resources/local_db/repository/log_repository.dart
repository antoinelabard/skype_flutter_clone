import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/db/hive_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/db/sqlite_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/interface/log_interface.dart';

class LogRepository implements LogInterface{
  static late LogInterface dbObject;
  bool isHive;

  LogRepository({required this.isHive}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
  }

  @override
  addLogs(Log log) {
    dbObject.addLogs(log);
  }

  @override
  close() {
    dbObject.close();
  }

  @override
  deleteLogs(int logId) {
    dbObject.deleteLogs(logId);
  }

  @override
  Future<List<Log>> getLogs() {
    return dbObject.getLogs();
  }

  @override
  init() {
    dbObject.init();
  }
}