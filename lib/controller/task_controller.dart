import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/bean/task.dart';
import 'package:todo_app/db/app_db.dart';

class TaskController extends GetxController {
  RxList taskList = RxList();

  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask(Task task) async {
    return await AppDatabaseHelper.insertTask(task);
  }

  void loadTasks() async {
    taskList.clear();
    List<Map<String, Object?>>? queryAllTasks =
        await AppDatabaseHelper.queryAllTasks();
    debugPrint(" tasks size : ${queryAllTasks?.length}");
    if (queryAllTasks != null && queryAllTasks.isNotEmpty) {
      for (int i = 0; i < queryAllTasks.length; i++) {
        taskList.add(Task.fromJson(queryAllTasks[i]));
      }
    }
  }

  void completeTask(Task task) async {
    var completeTask = await AppDatabaseHelper.completeTask(task);
    debugPrint("completed task call , $completeTask");
  }

  void deleteTask(Task task) async {
    AppDatabaseHelper.deleteTask(task);
  }
}
