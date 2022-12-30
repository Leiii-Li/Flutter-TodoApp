import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bean/task.dart';

class AppDatabaseHelper {
  static Database? _databaseInstance;
  static final int _version = 1;
  static final String _taskTableName = "tasks";
  static final String _databaseName = "todo.db";

  static Future<void> initDatabase() async {
    if (_databaseInstance != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + _databaseName;
      debugPrint("init database called $_path");
      _databaseInstance = await openDatabase(_path, version: _version,
          onCreate: (db, version) async {
        print("create a new one");
        await _databaseInstance?.execute('''
          CREATE TABLE $_taskTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, startTime TEXT, endTime TEXT, remind INTEGER, repeat TEXT, color INTEGER, isCompleted INTEGER)
        ''');
      });
    } catch (e) {
      print("create database error");
    }
  }

  static Future<int> insertTask(Task task) async {
    debugPrint("insert function called");
    return await _databaseInstance?.insert(_taskTableName, task.toJson()) ?? 1;
  }

  static Future<List<Map<String, Object?>>?> queryAllTasks() async {
    return await _databaseInstance?.query(_taskTableName);
  }
}
