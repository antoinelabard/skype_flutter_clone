import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/db/hive_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/db/sqlite_methods.dart';
import 'package:skype_flutter_clone/resources/local_db/interface/log_interface.dart';

class LogRepository {
  static late LogInterface dbObject;
  late bool isHive;

  LogRepository();

  static init({required bool isHive}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static close() => dbObject.close();

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static Future<List<Log>> getLogs() => dbObject.getLogs();
}