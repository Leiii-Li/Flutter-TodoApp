import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/bean/task.dart';
import 'package:todo_app/db/app_db.dart';

class TaskController extends GetxController {
  RxList taskList = RxList();
  Rx<dynamic> notifiedPageTask = Rx<Task?>(null);

  Future<int> addTask(Task task) async {
    return await AppDatabaseHelper.insertTask(task);
  }

  void loadTasks(DateTime selectedDate) async {
    taskList.clear();
    List<Map<String, Object?>>? queryAllTasks =
        await AppDatabaseHelper.queryAllTasks(selectedDate);
    if (queryAllTasks != null && queryAllTasks.isNotEmpty) {
      for (int i = 0; i < queryAllTasks.length; i++) {
        taskList.add(Task.fromJson(queryAllTasks[i]));
      }
    }
    debugPrint(" tasks size : ${queryAllTasks?.length}");
  }

  void completeTask(Task task) async {
    var completeTask = await AppDatabaseHelper.completeTask(task);
    debugPrint("completed task call , $completeTask");
  }

  void deleteTask(Task task) async {
    AppDatabaseHelper.deleteTask(task);
  }

  void queryTask(int taskId) async {
    try {
      List<Map<String, Object?>>? queryTaskJson =
          await AppDatabaseHelper.queryTask(taskId);
      if (queryTaskJson != null) {
        Task task = Task.fromJson(queryTaskJson[0]);
        notifiedPageTask.value = task;
      }
    } catch (e) {
      notifiedPageTask.value = null;
    }
  }
}
