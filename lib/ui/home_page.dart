import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/services/notification_service.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui/add_task_bar.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:todo_app/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  NotifyHelper? _notifyHelper;
  DateTime _selectedDate = DateTime.now();
  TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    _notifyHelper = NotifyHelper();
    _notifyHelper?.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [_addTaskBar(), _addDateBar(), _tasksBar()],
      ),
    );
  }

  _tasksBar() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context, index) {
            return TaskTile(_taskController.taskList[index]);
          });
    }));
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () async {
          ThemeService().switchTheme();
          _notifyHelper?.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activate Light Theme"
                  : "Activated Dark Theme");
        },
        child: Icon(
          (ThemeService().theme == ThemeMode.dark)
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Image(
          image: AssetImage(Get.isDarkMode
              ? "images/personal_fill_dark.png"
              : "images/personal_fill_light.png"),
          width: 26,
          height: 26,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _addTaskBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          AddTaskButton("Add Task", () async {
            await Get.to(AddTaskPage());
            _taskController.loadTasks();
          })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
          debugPrint("on date selected $_selectedDate");
        },
      ),
    );
  }
}
