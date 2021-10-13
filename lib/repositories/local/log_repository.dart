import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/repositories/local/hive_methods.dart';
import 'package:skype_flutter_clone/repositories/local/log_interface.dart';
import 'package:skype_flutter_clone/repositories/local/sqlite_methods.dart';

/// Repository allowing to store locally the trace of the calls made between the
/// active user and its contacts.
class LogRepository {
  static late LogInterface dbObject;
  late bool isHive;

  LogRepository();

  /// Instantiates the database and offers to choose between the SQLite or Hive
  /// implementation.
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
