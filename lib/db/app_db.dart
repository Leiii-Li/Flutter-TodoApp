import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bean/task.dart';
import 'package:intl/intl.dart';

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
            return await db.execute('''
          CREATE TABLE $_taskTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, startTime TEXT, endTime TEXT, remind INTEGER, repeat TEXT, color INTEGER, isCompleted INTEGER)
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

  static Future<List<Map<String, Object?>>?> queryAllTasks(
      DateTime selectedDate) async {
    String _selectedDateArgsValue = DateFormat.yMd().format(selectedDate);
    return _databaseInstance?.query(_taskTableName, where: "date=? or repeat=?",
        whereArgs: [_selectedDateArgsValue, "Daily"]);
  }

  static Future<int> deleteTask(Task task) async {
    return await _databaseInstance
        ?.delete(_taskTableName, where: "id=?", whereArgs: [task.id]) ??
        0;
  }

  static Future<int> completeTask(Task task) async {
    return await _databaseInstance?.update(
        _taskTableName, task.toJson(), where: "id=?", whereArgs: [task.id]) ??
        0;
  }

  static Future<List<Map<String, Object?>>?> queryTask(int taskId) async {
    return await _databaseInstance?.query(_taskTableName, where: "id=?", whereArgs: [taskId]);
  }
}
