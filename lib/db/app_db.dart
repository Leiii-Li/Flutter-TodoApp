import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bean/task.dart';

class AppDatabaseHelper {
  static Database? _databaseInstance;
  static final int _version = 1;
  static final String _taskTableName = "tasks";
  static final String _databaseName = "todo_db";

  static Future<void> initDatabase() async {
    if (_databaseInstance != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + _databaseName;
      _databaseInstance =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        debugPrint("create a new one");

        return _databaseInstance?.execute(
          "CREATE TABLE $_taskTableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note STRING, date STRING, "
          "startTime STRING, endTime STRING, "
          "remind INTEGER, repeat STRING, "
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } on Exception catch (e) {
      debugPrint("create database error");
    }
  }

  static Future<int> insertTask(Task task) async {
    debugPrint("insert function called");
    return await _databaseInstance?.insert(_taskTableName, task.toJson()) ?? 1;
  }
}
