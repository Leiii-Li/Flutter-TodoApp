import 'package:todo_app/bean/task.dart';

typedef OnTaskCompleted = void Function(Task task);
typedef OnTaskDeleted = void Function(Task task);

class TaskBottomSheetCallback {
  OnTaskCompleted onTaskCompleted;
  OnTaskDeleted onTaskDeleted;

  TaskBottomSheetCallback(
      {required this.onTaskCompleted, required this.onTaskDeleted});
}
