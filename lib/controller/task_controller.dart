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
    if (queryAllTasks != null && queryAllTasks.isNotEmpty) {
      queryAllTasks.map((value) {
        taskList.add(Task.fromJson(value));
      });
    }
  }
}
