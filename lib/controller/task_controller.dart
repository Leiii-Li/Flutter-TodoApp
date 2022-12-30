import 'package:get/get.dart';
import 'package:todo_app/bean/task.dart';
import 'package:todo_app/db/app_db.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask(Task task) async {
    return await AppDatabaseHelper.insertTask(task);
  }
}
