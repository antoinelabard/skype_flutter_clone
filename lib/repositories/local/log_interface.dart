import 'package:skype_flutter_clone/models/log.dart';

/// Provides an interface for the local logs database.
abstract class LogInterface {
  /// Instantiates the database to allow access to its data.
  init();

  addLogs(Log log);

  Future<List<Log>> getLogs();

  deleteLogs(int logId);

  close();

  /// Open tha database related to the given user.
  openDb(dbName);
}
