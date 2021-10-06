import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/db/hive_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/db/sqlite_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/interface/log_interface.dart';

class LogRepository {
  static late LogInterface dbObject;
  late bool isHive;

  LogRepository();

  init({required bool isHive}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.init();
  }

  addLogs(Log log) => dbObject.addLogs(log);

  close() => dbObject.close();

  deleteLogs(int logId) => dbObject.deleteLogs(logId);

  Future<List<Log>> getLogs() => dbObject.getLogs();
}