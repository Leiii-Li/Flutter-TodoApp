import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bean/task.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/db/app_db.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatefulWidget {
  String? _taskId;

  NotifiedPage(this._taskId, {super.key}) {}

  @override
  State<NotifiedPage> createState() => _NotifiedPageState(_taskId);
}

class _NotifiedPageState extends State<NotifiedPage> {
  TaskController _taskController = Get.put(TaskController());
  String? _taskId;
  String? _info;

  _NotifiedPageState(this._taskId) {}

  @override
  void initState() {
    int taskId = int.parse(_taskId ?? "-1");
    if (taskId != -1) {
      _taskController.queryTask(taskId);
    }
    _taskController.notifiedPageTask
        .addListener(GetStream<dynamic>(onListen: () {
      var notifiedPageTask = _taskController.notifiedPageTask;
      debugPrint("onListen $notifiedPageTask");
      if (notifiedPageTask is Task) {
        setState(() {
          Task currentTask = notifiedPageTask as Task;
          _info = currentTask.title ?? "";
        });
      }
    }, onResume: () {
      var notifiedPageTask = _taskController.notifiedPageTask;
      debugPrint("onResume ");
      if (notifiedPageTask is Task) {
        setState(() {
          Task currentTask = notifiedPageTask as Task;
          _info = currentTask.title ?? "";
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: Text(_info ?? ""),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () async {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
