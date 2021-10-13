import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/repositories/local/hive_methods.dart';
import 'package:skype_flutter_clone/repositories/local/log_interface.dart';
import 'package:skype_flutter_clone/repositories/local/sqlite_methods.dart';

class LogRepository {
  static late LogInterface dbObject;
  late bool isHive;

  LogRepository();

  static init({required bool isHive, required String dbName}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static close() => dbObject.close();

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static Future<List<Log>> getLogs() => dbObject.getLogs();
}
