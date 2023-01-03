import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bean/task.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/widgets/task_bottom_sheet_interface.dart';

class TaskBottomSheet extends StatelessWidget {
  Task _task;
  TaskBottomSheetCallback? _taskBottomSheetCallback;

  TaskBottomSheet(
    this._task,
    this._taskBottomSheetCallback, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int isComplete = _task.isCompleted ?? 0;
    if (isComplete == 1) {
      return createCompleteTaskWidget(context);
    } else {
      return createUnCompleteTaskWidget(context);
    }
  }

  Widget createCompleteTaskWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.24,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          createSlideWidget(),
          SizedBox(
            height: 40,
          ),
          _createDeleteTaskWidget(),
          SizedBox(
            height: 40,
          ),
          _createCloseSheetWidget()
        ],
      ),
    );
  }

  Widget createUnCompleteTaskWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          createSlideWidget(),
          SizedBox(
            height: 40,
          ),
          _createTaskCompleteWidget(),
          SizedBox(
            height: 10,
          ),
          _createDeleteTaskWidget(),
          SizedBox(
            height: 40,
          ),
          _createCloseSheetWidget()
        ],
      ),
    );
  }

  Widget createSlideWidget() {
    return Container(
      width: 120,
      height: 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
    );
  }

  Widget _createTaskCompleteWidget() {
    return GestureDetector(
      onTap: () => _taskBottomSheetCallback?.onTaskCompleted(_task),
      child: Container(
        height: 40,
        width: 240,
        decoration: BoxDecoration(
            color: bluishClr, borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Text(
            "Task Completed",
            style: sheetTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _createDeleteTaskWidget() {
    return GestureDetector(
      onTap: () => _taskBottomSheetCallback?.onTaskDeleted(_task),
      child: Container(
        height: 40,
        width: 240,
        decoration: BoxDecoration(
            color: pinkClr, borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Text(
            "Delete Task",
            style: sheetTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _createCloseSheetWidget() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 240,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: pinkClr)),
        child: Center(
          child: Text(
            "Close",
            style: subTitleStyle,
          ),
        ),
      ),
    );
  }
}
