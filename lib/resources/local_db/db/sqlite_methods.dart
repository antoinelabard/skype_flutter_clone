import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/interface/log_interface.dart';
import 'package:sqflite/sqflite.dart';

class SqliteMethods implements LogInterface {
  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      print("db was null, now awaiting it");
      _db = await init();
    }
    return _db!;
  }

  var databaseName = "";
  var tableName = "Call_logs";

  var id = "log_id";
  var callerName = "caller_name";
  var callerPic = "caller_pic";
  var receiverName = "receiver_name";
  var receiverPic = "receiver_pic";
  var callStatus = "call_status";
  var timestamp = "timestamp";

  @override
  addLogs(Log log) async {
    print("Data added to SQlite database.");
    var dbClient = await db;
    await dbClient.insert(tableName, log.toMap());
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }

  @override
  deleteLogs(int logId) async {
    var dbClient = await db;
    return await dbClient.delete(tableName, where: "$id = ?", whereArgs: [logId]);
  }

  updateLogs(Log log) async {
    var dbClient = await db;
    await dbClient.update(tableName, log.toMap(),whereArgs: [log.logId], where: "$id = ?");
  }

  @override
  Future<List<Log>> getLogs() async {
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient.query(tableName, columns: [
        id,
        callerName,
        callerPic,
        receiverName,
        receiverPic,
        callStatus,
        timestamp
      ]);
      List<Log> logList = [];
      if (maps.isNotEmpty) {
        for (Map map in maps) {
          logList.add(Log.fromMap(map));
        }
      }
      return logList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  init() async {
    print("SQlite database initialised.");
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery = """
        CREATE TABLE $tableName (
        $id TEXT PRIMARY KEY,
        $callerName TEXT,
        $callerPic TEXT,
        $receiverName TEXT,
        $receiverPic TEXT,
        $callStatus TEXT,
        $timestamp TEXT)
        """;

    await db.execute(createTableQuery);
    print("table created");
  }

  @override
  openDb(dbName) => databaseName = dbName;
}
