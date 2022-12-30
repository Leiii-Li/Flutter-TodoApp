import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/bean/task.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/utils/Constant.dart';
import 'package:todo_app/widgets/create_button.dart';
import 'package:todo_app/widgets/input_field.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController _taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat(timeFormat).format(DateTime.now()).toString();
  String _endTime = DateFormat(timeFormat)
      .format(DateTime.now().add(Duration(hours: 4)))
      .toString();

  int _selectedRemind = 5;
  List _remindList = ["5", "10", "15", "20"];

  String _selectedRepeat = "None";
  List _repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColorIndex = 0;
  List _colorList = [primaryClr, pinkClr, yellowClr];

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _noteTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        color: context.theme.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              InputField("Title", "Enter title here",
                  _titleTextEditingController, null),
              InputField(
                  "Note", "Enter note here", _noteTextEditingController, null),
              InputField("Date", DateFormat.yMd().format(_selectedDate), null,
                  _dateSelectWidget()),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                        "Start Time",
                        _startTime,
                        null,
                        IconButton(
                          icon: Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _onTimeSelected(true);
                          },
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InputField(
                        "End Time",
                        _endTime,
                        null,
                        IconButton(
                          icon: Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _onTimeSelected(false);
                          },
                        )),
                  ),
                ],
              ),
              InputField(
                  "Remind",
                  "$_selectedRemind minutes early",
                  null,
                  DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    items: _remindList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRemind = int.parse(value);
                        });
                      }
                    },
                  )),
              InputField(
                  "Repeat",
                  _selectedRepeat,
                  null,
                  DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    items: _repeatList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRepeat = value;
                        });
                      }
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children:
                            List<Widget>.generate(_colorList.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColorIndex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: _colorList[index],
                                child: _selectedColorIndex == index
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  _createTaskBar()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _createTaskBar() {
    return CreateTaskButton("Create Task", () {
      _validTaskInfo();
    });
  }

  _validTaskInfo() async {
    String title = _titleTextEditingController.text;
    String note = _noteTextEditingController.text;
    if (title.isEmpty || note.isEmpty) {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Get.isDarkMode ? Colors.black : Colors.white,
          backgroundColor: Get.isDarkMode ? Colors.white : Colors.grey,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Get.isDarkMode ? Colors.black : Colors.black,
          ));
    } else {
      final task = Task(
          title: title,
          note: note,
          isCompleted: 0,
          date: _selectedDate.toString(),
          startTime: _startTime,
          endTime: _endTime,
          color: _colorList[_selectedColorIndex],
          remind: _selectedRemind,
          repeat: _selectedRepeat);
      int value = await _taskController.addTask(task);
      debugPrint("insert a new task ,id is $value");
    }
  }

  _onTimeSelected(bool isStartTime) async {
    TimeOfDay? time = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));

    if (time != null) {
      final timeStr = time.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = timeStr;
        } else {
          _endTime = timeStr;
        }
      });
    } else {
      debugPrint("time canceled");
    }
  }

  _dateSelectWidget() {
    return IconButton(
      icon: Icon(
        Icons.date_range_outlined,
        color: Get.isDarkMode ? Colors.grey : Colors.grey[600],
      ),
      onPressed: () {
        debugPrint("press date");
        _getDateFromUser();
      },
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2122));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        debugPrint("$_selectedDate");
      });
    } else {
      debugPrint("not select any time");
    }
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
}
